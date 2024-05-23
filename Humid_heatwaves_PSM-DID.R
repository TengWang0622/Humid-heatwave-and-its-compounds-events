#############################################################################
#
#                       P   R   O   J   E   C   T
#                                   of
#                             Humid heatwaves 
#                                   on
#               public health response and socio-economic burden 
#                                                                  
#############################################################################

# Developed by Teng Wang & Hanxu Shi

# Contact: wang.teng19@alumni.imperial.ac.uk
#          handsomegaoaixu@163.com

# Version - 20240325

# Branch: Main Script
# Description: PSM-DID analysis

############################################
#             Preparation
############################################

# Preparation

library(readxl)
library(tidyverse)
#library(dlnm)
#library(splines)
#library(survival)
#library(mvmeta)
library(dplyr)
library(magrittr)
library(Matrix)


library(foreach)
library(doParallel)
library(progress)

library(lme4)
#library(lmerTest)

library(ape)

library(MatchIt)
library(WeightIt)
library(MASS)
library(cli)


# Input date variables

match=11
pre=7
warn=3
post=7
after=14


val_pre=0    # 0 or 1 or 2
val_warn=2   # 0 or 1 or 2
val_post=1   # 0 or 1 or 2
val_after=2  # 0 or 1 or 2

No_replicate=14

No_subgroup=18
No_controlCounty=4
Start_year=2016
Start_date=c('2016-01-01')

# Input data files
df=Case_all
df_Geo=Geo_all


# =========== Compute the individual index =========== 

df$tempmaxC=round(5/9*(df$tempmax-32),digits=1)
df$tempC=round(5/9*(df$temp-32),digits=1)
df$tempminC=round(5/9*(df$tempmin-32),digits=1)

thres_temp=27.4 #--------------------------------------------------------------------- Input 

## ! NA 在pressure中
na_positions <- which(is.na(df$pressure))
df$pressure[is.na(df$pressure)]=1013.25

df$Index_temp=round((df$tempmaxC/thres_temp)*exp(0.01*(df$tempC-df$tempmaxC)),digits=2)
df$Index_HI=round(exp(1*(0.05*(df$tempC-thres_temp)+df$humidity/100-0.5)),digits=2)#削弱后的HI
df$Index_P=round(1*(1-(df$pressure-1013.25)/1013.25)+0,digits=2)
df$Index_SR=round(0.1*(df$solarradiation-min(df$solarradiation))/(max(df$solarradiation)-min(df$solarradiation))+0.9,digits=2)
df$Index_SE=round(0.1*(df$solarenergy-min(df$solarenergy))/(max(df$solarenergy)-min(df$solarenergy))+0.9,digits=2)

df$Index=round(df$Index_temp*df$Index_HI*df$Index_P*df$Index_SR,digits=2)
df$checkIndex=ifelse(df$Index >= 1.42, 1, 0) #--------------------------------------------------------------------- Input
df$checkIndex_Precip=ifelse(df$precip > 0, 1, 0)


# ================= Prepost analysis ======================

df$checkEventSum=df$checkIndex+c(df$checkIndex[(No_subgroup+1):nrow(df)],rep(0,No_subgroup))+c(df$checkIndex[(2*No_subgroup+1):nrow(df)],rep(0,2*No_subgroup))
df$checkEvent=ifelse(df$checkEventSum == 3, 1, 0)

df$checkPrecipSum=df$checkIndex_Precip+c(df$checkIndex_Precip[(No_subgroup+1):nrow(df)],rep(0,No_subgroup))+c(df$checkIndex_Precip[(2*No_subgroup+1):nrow(df)],rep(0,2*No_subgroup))+c(df$checkIndex_Precip[(3*No_subgroup+1):nrow(df)],rep(0,3*No_subgroup))+c(df$checkIndex_Precip[(4*No_subgroup+1):nrow(df)],rep(0,4*No_subgroup))+c(df$checkIndex_Precip[(5*No_subgroup+1):nrow(df)],rep(0,5*No_subgroup))+c(df$checkIndex_Precip[(6*No_subgroup+1):nrow(df)],rep(0,6*No_subgroup))
df$checkPrecip=ifelse(df$checkPrecipSum >= 1, 1, 0)
df$checkONLYheat=df$checkEvent-df$checkIndex_Precip

id_row=seq(1,length(df$checkONLYheat),by=No_subgroup)# --------------modity the variable to compute independent heatwave，precipitation or compound events: df$checkEvent, df$checkPrecip, df$checkCompound
Po_row=which(df$checkONLYheat[id_row]==1)
criterion=which(diff(c(0,Po_row))>=match+pre+warn+post+after)
selected_row=Po_row[criterion]

template_case_post=t(seq(0,No_subgroup*post-1,by=1))
template_case_warn=t(seq(-No_subgroup*warn,-1,by=1))

if(pre>0){
  template_case_pre=t(seq(-No_subgroup*(warn+pre),-No_subgroup*warn-1,by=1))
  row_case_pre=data.frame()
  for(i in 1:length(criterion)){
    row_case_pre=rbind(row_case_pre,template_case_pre)
  }
  case_pre=(selected_row-1)*No_subgroup+1+row_case_pre
}

if(after>0){
  template_case_after=t(seq(No_subgroup*post,No_subgroup*(post+after)-1,by=1))
  row_case_after=data.frame()
  for(i in 1:length(criterion)){
    row_case_after=rbind(row_case_after,template_case_after)
  }
  case_after=(selected_row-1)*No_subgroup+1+row_case_after
}

row_case_warn=data.frame()
row_case_post=data.frame()


for(i in 1:length(criterion)){
  row_case_post=rbind(row_case_post,template_case_post)
  row_case_warn=rbind(row_case_warn,template_case_warn)
}

case_post=(selected_row-1)*No_subgroup+1+row_case_post
case_warn=(selected_row-1)*No_subgroup+1+row_case_warn


df$case=-1# --------------------------------------------------------------------------------------------------------------Input
df$case[unlist(case_post)]=val_post
df$case[unlist(case_warn)]=val_warn

if(pre>0){
  df$case[unlist(case_pre)]=val_pre
}

if(after>0){
  df$case[unlist(case_after)]=val_after
}

prepost=df[df$case == 0 | df$case == 1, ]

prepost$ID=rep(1:(nrow(prepost)/(No_replicate*No_subgroup)),by=1,each=No_replicate*No_subgroup)

# #mutate covariates
# prepost %<>%mutate(DOW=weekdays(as.Date(datetime)))
# 
# prepost %<>%
#   mutate(holiday = case_when(datetime >= as.Date("2016-02-07") & datetime <= as.Date("2016-02-13")
#                              | datetime >= as.Date("2017-01-27") & datetime <= as.Date("2017-02-02") | datetime >= as.Date("2018-02-15") & datetime <= as.Date("2018-02-21") 
#                              | datetime >=as.Date("2019-09-01") & datetime <= as.Date("2019-12-31") 
#                              | datetime >=as.Date("2019-02-04") & datetime <= as.Date("2019-02-10") 
#                              | datetime >=as.Date("2020-01-25") & datetime <= as.Date("2020-01-31")
#                              | datetime >=as.Date("2021-02-12") & datetime <= as.Date("2021-02-18")
#                              | datetime >=as.Date("2022-02-01") & datetime <= as.Date("2022-02-07")~ "春节",TRUE ~ "其他"))
# prepost$holiday[str_which(prepost$datetime,'01-01|01-02|01-03')]<-'元旦'
# prepost$holiday[str_which(prepost$datetime,'10-01|10-02|10-03|10-04|10-05|10-06|10-07')]<-'国庆节'
# prepost$holiday[str_which(prepost$datetime,'05-01|05-02|05-03|05-04|05-05')]<-'劳动节'
# prepost$holiday[str_which(prepost$holiday,'其他')]<-0
# prepost$holiday[str_which(prepost$holiday,'春节|劳动节|国庆节|元旦')]<-1
# prepostCounty1=lmer(All_cause ~ case + (1|datetime) + DOW + holiday, data=prepost, REML=FALSE)
# summary(prepostCounty1)
# saveRDS(prepost,'Z:/EnvH/Heatwave/Posted/Datasets/Derived/PrePost_All/prepost.rds')

# =============== Compute Moran's I ===================

#Global Moran's I

df_Geo = separate(df_Geo, Address, into = c("Latitude", "Longitude"), sep = ",", remove = FALSE)

temp_Geo=na.omit(df_Geo)


Matrix_dists=1/as.matrix(dist(cbind(temp_Geo$Latitude,temp_Geo$Longitude)))
diag(Matrix_dists)=0

MI_Angina=Moran.I(temp_Geo$Angina,Matrix_dists)
MI_MI=Moran.I(temp_Geo$MI,Matrix_dists)
MI_C_isch=Moran.I(temp_Geo$C_isch,Matrix_dists)
MI_Others=Moran.I(temp_Geo$Others,Matrix_dists)
MI_All_cause=Moran.I(temp_Geo$All_cause,Matrix_dists)

MI_result=cbind(MI_Angina,MI_MI,MI_C_isch,MI_Others,MI_All_cause)
print(MI_result)


# Local Moran's I

compute_localMI=function(value,Latitude,Longitude){
  MatrixW=1/as.matrix(dist(cbind(Latitude,Longitude)))
  diag(MatrixW)=0
  ave_value=mean(value)
  delta_value=value-ave_value
  m2=sum(delta_value*delta_value)/length(value)
  output=delta_value/m2*(MatrixW %*% delta_value)/rowSums(MatrixW)
}

MI_Lc_Angina=compute_localMI(temp_Geo$Angina,temp_Geo$Latitude,temp_Geo$Longitude)
MI_Lc_MI=compute_localMI(temp_Geo$MI,temp_Geo$Latitude,temp_Geo$Longitude)
MI_Lc_C_isch=compute_localMI(temp_Geo$C_isch,temp_Geo$Latitude,temp_Geo$Longitude)
MI_Lc_Others=compute_localMI(temp_Geo$Others,temp_Geo$Latitude,temp_Geo$Longitude)
MI_Lc_All_cause=compute_localMI(temp_Geo$All_cause,temp_Geo$Latitude,temp_Geo$Longitude)

MI_Lc_result=cbind(MI_Lc_Angina,MI_Lc_MI,MI_Lc_C_isch,MI_Lc_Others,MI_Lc_All_cause)
print(MI_Lc_result)

# Check spatial autocorrelation
MI_Lc_check=ifelse(MI_Lc_result<0.5,1,0)#---------------------------------------------------------------------------- Input


# ================= Check the physical distance (remove the nearby counties) =================

Check_distance=as.matrix(dist(cbind(temp_Geo$Latitude,temp_Geo$Longitude)))
dist_limit=quantile(Check_distance,1.0)
Check_distance=ifelse(Check_distance>4 & Check_distance<=dist_limit,1,0)

# ================= Check the County & date (remove the event counties) =================

County_seq=unique(df$County)
df_Geo=df_Geo[match(County_seq,df_Geo$County),]

# Build a matrix containing the no event counties

event_row=(selected_row-1)*No_subgroup+1
Event_info=df[event_row,]
No_event_county=data.frame()
jumpEventID=data.frame()
for(i in 1:length(event_row)){
  
  Event_loc=Event_info$County[i]
  Po_event_check=which(df_Geo$County==Event_loc)
  
  Event_date=Event_info$datetime[i]
  
  Event_year=format(Event_date, "%Y")
  total_days=0
  for(j in Start_year:Event_year){
    is_leap_year=leap_year(j)
    if(is_leap_year){
      total_days=total_days+366
    }else{
      total_days=total_days+365
    }
  }
  
  No_of_day=as.integer(difftime(ymd(Event_date), ymd(Start_date), units = "days"))+1
  Po_date_check=seq(No_of_day-28,No_of_day+27,by=1)

  jumpEventID=rbind(jumpEventID,i)
  matrix_ones=matrix(1,nrow=length(County_seq),ncol=length(Po_date_check))#构建单位矩阵
  date_row_matrix=(seq(1,length(County_seq))-1)*total_days*No_subgroup*matrix_ones+t(((Po_date_check-1)*No_subgroup+1)*t(matrix_ones))
  
  matrix_df_row4date=as.data.frame(matrix(df$checkEvent[date_row_matrix],nrow=length(County_seq),ncol=length(Po_date_check),byrow=TRUE))
  check_df_row4date=rowSums(matrix_df_row4date)
  check_df_row4date=ifelse(check_df_row4date>0,0,1)
  
  if(any(is.na(check_df_row4date))==TRUE){
    print(i)
  }
  No_event_county=rbind(No_event_county,check_df_row4date)
}

na_rows <- which(apply(No_event_county, 1, function(row) any(is.na(row))))
# ====================== Tabulate the event-control county =========================

# NOTE--------------------------------------------------------------------------------------------------------------------
# control County         1)疾病类型                       Angina, MI, C_ish, Others, All_cause  为MI_Lc_check的1到5列    |
#                        2)空间相关性 Moran's I           MI_result(global) 和 MI_Lc_check(local)                        |
#                        3)地理位置                       Check_distance                                                 |
#                        4)所在前后28(共56天)无风险事件   No_event_county                                                |
# ------------------------------------------------------------------------------------------------------------------------   

MI_Lc_check=data.frame(MI_Lc_check)
colnames(MI_Lc_check)=c('Angina','MI','C_isch','Others','All_cause')

df_County=data.frame()
cli_progress_bar('Processing O3 dataset', total=nrow(jumpEventID), type='tasks',
                 format="{cli::pb_bar} {pb_percent} @ {cli::pb_current}:{cli::pb_total} ETA: {cli::pb_eta}")

for(j in 1:nrow(jumpEventID)){
  i=jumpEventID[j,1]
  EventID=i
  Event_loc=Event_info$County[i]
  Event_date=Event_info$datetime[i]
  
  EventID_repeated=rep(EventID, each = ncol(No_event_county))
  Event_loc_repeated=rep(Event_loc, each = ncol(No_event_county))
  Event_date_repeated=rep(Event_date, each = ncol(No_event_county))
  
  Po_loc=which(df_Geo$County==Event_loc)
  CheckNoevent=data.frame(t(No_event_county[j,]))
  
  subevent=cbind(ID=EventID_repeated,County=Event_loc_repeated,datetime=Event_date_repeated,ControlCounty=df_Geo$County,MI_Lc_check,CheckDist=Check_distance[,Po_loc],CheckNoevent)
  colnames(subevent)=c('ID','County','datetime','ControlCounty','MI_Angina','MI_MI','MI_C_isch','MI_Others','MI_All_cause','CheckDist','Checkdate')
  df_County=rbind(df_County,subevent)
  cli_progress_update()
}

df_County=merge(df_County,df_Geo,by.x='ControlCounty',by.y='County')

df_County$CheckVAL_Angina=ifelse(df_County$Angina>=quantile(df_County$Angina,0.8),1,0)
df_County$CheckVAL_MI=ifelse(df_County$MI>=quantile(df_County$MI,0.8),1,0)
df_County$CheckVAL_C_isch=ifelse(df_County$C_isch>=quantile(df_County$C_isch,0.8),1,0)
df_County$CheckVAL_Others=ifelse(df_County$Others>=quantile(df_County$Others,0.8),1,0)
df_County$CheckVAL_All_cause=ifelse(df_County$All_cause>=quantile(df_County$All_cause,0) & df_County$All_cause<=quantile(df_County$All_cause,1),1,0)


df_County$Group_Angina=df_County$MI_Angina*df_County$CheckDist*df_County$Checkdate*df_County$CheckVAL_Angina
df_County$Group_MI=df_County$MI_MI*df_County$CheckDist*df_County$Checkdate*df_County$CheckVAL_MI
df_County$Group_C_isch=df_County$MI_C_isch*df_County$CheckDist*df_County$Checkdate*df_County$CheckVAL_C_isch
df_County$Group_Others=df_County$MI_Others*df_County$CheckDist*df_County$Checkdate*df_County$CheckVAL_Others
df_County$Group_All_cause=df_County$MI_All_cause*df_County$CheckDist*df_County$Checkdate*df_County$CheckVAL_All_cause


print(df_County)

#saveRDS(df_County,'desktop/df_County.rds')

# ====================== Compute PSM =========================

Data_eco=eco_2016

df_did_20=merge(df_County,Data_eco,by.x='ControlCounty',by.y='地区')

df_did_20=rename(df_did_20, 'prate'='性别比\n(女=100)')

df_did=df_did_20 


setdiff(df_County$County,Data_eco$地区)
prepost=prepost[!(prepost$County %in% setdiff(prepost$County, Data_eco$地区)), ]



unique_elements=unique(df_did$County[!df_did$County %in% df_did$ControlCounty]) 
df_did=df_did[!(df_did$County %in% unique_elements | df_did$ControlCounty %in% unique_elements), ]


df_weather=data.frame(County=df$County,datetime=df$datetime,tempC=df$tempC)
df_weather=df_weather[seq(1,nrow(df_weather),by=18),]

County_result=data.frame()
cli_progress_bar('Processing O3 dataset', total=length(unique(df_did$ID)), type='tasks',
                 format="{cli::pb_bar} {pb_percent} @ {cli::pb_current}:{cli::pb_total} ETA: {cli::pb_eta}")
for(i in 1:length(unique(df_did$ID))){
  ID_all=sort(unique(df_did$ID))
  
  tempPSM=df_did[df_did$ID == ID_all[i], ]
  
  inverse_All_cause=ecdf(tempPSM$All_cause)
  tempPSM$QAT_All_cause=inverse_All_cause(tempPSM$All_cause)
  
  tempPSM= merge(tempPSM,df_weather, by.x = c("ControlCounty", "datetime"), by.y = c("County", "datetime"))
  
  order_specified=which(tempPSM$ControlCounty==tempPSM$County[1])                                                                       
  tempPSM=tempPSM[c(order_specified, setdiff(1:nrow(tempPSM), order_specified)), ]                                                                                         
  
  tempPSM$CheckQAT_All_cause=ifelse(tempPSM$QAT_All_cause>=0.8 & tempPSM$QAT_All_cause<=1,1,0)
  
  tempPSM$Group_All_cause=tempPSM$Group_All_cause*tempPSM$CheckQAT_All_cause
  
  
  rownames(tempPSM)=1:nrow(tempPSM)
  tempPSM$PSM=abs(tempPSM$Checkdate-1)
  
  if(1 %in% tempPSM$PSM){
    tempPSM$PSM=tempPSM$PSM
  }else{
    random_Checkdate=sample(1:length(tempPSM$PSM),length(tempPSM$PSM)/2,replace=FALSE)
    tempPSM$PSM[random_Checkdate]=1
  }
  
  m = matchit(PSM~ prate + urban + 男盲 + 女盲 + ser_rate + tempC,
              data=tempPSM,
              distance='logit',
              method='nearest',
              replace=FALSE,
              ratio=No_controlCounty)
  #m$match.matrix[1,]
  
  ID=i
  Case=c(1,rep(0,No_controlCounty-1))
  

  temp_output=cbind(ID,Group,Case)
  County_result=rbind(County_result,temp_output)
  cli_progress_update()
}

print(County_result)

#saveRDS(County_result,'desktop/County_result.rds')


# ==================== Manipulation ========================

delete_elements=unique(prepost$County[!prepost$County %in% df_did$County])
prepost=prepost[!(prepost$County %in% delete_elements), ]

prepost$ID=rep(1:(length(prepost$County)/(No_replicate*No_subgroup)),each=No_replicate*No_subgroup)

#saveRDS(prepost,'desktop/prepost.rds')

# Combine prepost and County_result

prepost_replicated=prepost[rep(seq_len(nrow(prepost)), each = No_controlCounty), ]

County_result_replicated=data.frame()
for(i in seq(1,nrow(County_result),by=No_controlCounty)){
  sub_County_result=County_result[i:(i+No_controlCounty-1),]#子集
  sub_County_result_replicated=do.call(rbind, replicate(No_replicate*No_subgroup, sub_County_result, simplify = FALSE))
  County_result_replicated=rbind(County_result_replicated,sub_County_result_replicated)
}

prepost_replicated$caseCounty=County_result_replicated$Case
prepost_replicated$County=County_result_replicated$Group

df_formal=prepost_replicated[,c('datetime','County','Gender','Age_g','Employmentn','case','caseCounty')]
df_pair=df[,c('datetime','County','Gender','Age_g','Employmentn','Angina','MI','C_isch','Others','All_cause','tempmaxC','tempC','humidity','Index_temp','Index_HI','Index')]
did_result=merge(df_formal,df_pair,by=c('datetime','County','Gender','Age_g','Employmentn'),all.x=TRUE)

# Compute offset population (according to the obs windows)
eco_all <- rename(eco_all,'Population'=`合 计`)
did_result <- merge(did_result,eco_all,by.x='County',by.y='地区')
saveRDS(did_result,'Z:/EnvH/Heatwave/Posted/Datasets/Derived/did_result.rds')

did=glmer(All_cause~caseCounty*case + (1|datetime) + offset(log(Population)),data=did_result)
summary(did)
