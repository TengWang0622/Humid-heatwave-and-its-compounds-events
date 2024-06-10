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
#          shx@bjmu.edu.cn

# Version - 20240325

# Branch: Supplementary Script
# Description: Identify and tabulate all the Pure precipitation events dataframe, 
#              further analysis should be carried out in Humid_heatwave_Burden.R

############################################
#             Preparation
############################################

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

No_subgroup=1
No_controlCounty=4
Start_year=2016
Start_date=c('2016-01-01')

# Input data files
df=Crawl_extra

df=df[df$datetime >= as.Date("2016-01-01") & df$datetime <= as.Date("2022-12-31"), ]

df_Loc = Loc_info
df=merge(df, df_Loc, by.x = "Address", by.y = "loc")

colnames(df)[colnames(df) == "name"]="County"

# =========== Compute the individual index =========== 

df$tempmaxC=round(5/9*(df$tempmax-32),digits=1)
df$tempC=round(5/9*(df$temp-32),digits=1)
df$tempminC=round(5/9*(df$tempmin-32),digits=1)

thres_temp=27.4 #--------------------------------------------------------------------- Input 

## Remove NA
na_positions <- which(is.na(df$pressure))
df$pressure[is.na(df$pressure)]=1013.25

df$Index_temp=round((df$tempmaxC/thres_temp)*exp(0.01*(df$tempC-df$tempmaxC)),digits=2)
df$Index_HI=round(exp(1*(0.05*(df$tempC-thres_temp)+df$humidity/100-0.5)),digits=2)
df$Index_P=round(1*(1-(df$pressure-1013.25)/1013.25)+0,digits=2)
df$Index_SR=round(0.1*(df$solarradiation-min(df$solarradiation))/(max(df$solarradiation)-min(df$solarradiation))+0.9,digits=2)
df$Index_SE=round(0.1*(df$solarenergy-min(df$solarenergy))/(max(df$solarenergy)-min(df$solarenergy))+0.9,digits=2)

df$Index=round(df$Index_temp*df$Index_HI*df$Index_P*df$Index_SR,digits=2)
df$checkIndex=ifelse(df$Index >= 1.42, 1, 0) #--------------------------------------------------------------------- Input
df$checkIndex_Precip=ifelse(df$precip >= 0.669, 1, 0)  ###Heavy or more catastropic precipitation
# df$checkIndex_Precip=ifelse(df$precip >= 0.984, 1, 0)

# ####Precip index calculation####
# # precip90=0.354
# # wind_ref=10.8
# # df$Index_Precip=df$precip/precip90*exp(0.001*df$windspeed^2/wind_ref^2)*df$Index_P
## precip50=0.072
# wind_ref=10.8
# df$Index_Precip=df$precip/precip50*exp(0.001*df$windspeed^2/wind_ref^2)*df$Index_P
# df$checkIndex_Precip=ifelse(df$Index_Precip >= 16.919, 1, 0)
# #df$checkIndex_Precip=ifelse(df$Index_Precip >= 1.55848, 1, 0)   ##(80th)
# # dft <- df
# # dft %<>% subset(dft$Index_Precip!=0)
# # quantile(dft$Index_Precip,seq(0,1,0.1))
# # df$checkIndex_Precip=ifelse(df$Index_Precip >= 0.002740724 & df$Index_Precip < 0.337089526, 1, 0) ##mild (<60th)
# # df$checkIndex_Precip=ifelse(df$Index_Precip >= 0.337089526 & df$Index_Precip < 1.045243654, 1, 0) ####Light precipitation (60-80th)
# # df$checkIndex_Precip=ifelse(df$Index_Precip >= 1.045243654, 1, 0)   ##Moderate precipitation (80th)



# ================= Prepost analysis ======================

df$checkEventSum=df$checkIndex+c(df$checkIndex[(No_subgroup+1):nrow(df)],rep(0,No_subgroup))+c(df$checkIndex[(2*No_subgroup+1):nrow(df)],rep(0,2*No_subgroup))
df$checkEvent=ifelse(df$checkEventSum == 3, 1, 0)

#df$checkPrecipSum=df$checkIndex_Precip+c(df$checkIndex_Precip[(No_subgroup+1):nrow(df)],rep(0,No_subgroup))+c(df$checkIndex_Precip[(2*No_subgroup+1):nrow(df)],rep(0,2*No_subgroup))+c(df$checkIndex_Precip[(3*No_subgroup+1):nrow(df)],rep(0,3*No_subgroup))+c(df$checkIndex_Precip[(4*No_subgroup+1):nrow(df)],rep(0,4*No_subgroup))+c(df$checkIndex_Precip[(5*No_subgroup+1):nrow(df)],rep(0,5*No_subgroup))+c(df$checkIndex_Precip[(6*No_subgroup+1):nrow(df)],rep(0,6*No_subgroup))
#df$checkPrecipSum=c(df$checkIndex_Precip[(3*No_subgroup+1):nrow(df)],rep(0,3*No_subgroup))+c(df$checkIndex_Precip[(4*No_subgroup+1):nrow(df)],rep(0,4*No_subgroup))+c(df$checkIndex_Precip[(5*No_subgroup+1):nrow(df)],rep(0,5*No_subgroup))+c(df$checkIndex_Precip[(6*No_subgroup+1):nrow(df)],rep(0,6*No_subgroup))
#df$checkPrecipSum=df$checkIndex_Precip+c(df$checkIndex_Precip[(No_subgroup+1):nrow(df)],rep(0,No_subgroup))+c(df$checkIndex_Precip[(2*No_subgroup+1):nrow(df)],rep(0,2*No_subgroup))#+c(df$checkIndex_Precip[(3*No_subgroup+1):nrow(df)],rep(0,3*No_subgroup))+c(df$checkIndex_Precip[(4*No_subgroup+1):nrow(df)],rep(0,4*No_subgroup))+c(df$checkIndex_Precip[(5*No_subgroup+1):nrow(df)],rep(0,5*No_subgroup))+c(df$checkIndex_Precip[(6*No_subgroup+1):nrow(df)],rep(0,6*No_subgroup))
df$checkPrecipSum=df$checkIndex_Precip+c(df$checkIndex_Precip[(No_subgroup+1):nrow(df)],rep(0,No_subgroup))+c(df$checkIndex_Precip[(2*No_subgroup+1):nrow(df)],rep(0,2*No_subgroup))+c(df$checkIndex_Precip[(3*No_subgroup+1):nrow(df)],rep(0,3*No_subgroup))+c(df$checkIndex_Precip[(4*No_subgroup+1):nrow(df)],rep(0,4*No_subgroup))+c(df$checkIndex_Precip[(5*No_subgroup+1):nrow(df)],rep(0,5*No_subgroup))+c(df$checkIndex_Precip[(6*No_subgroup+1):nrow(df)],rep(0,6*No_subgroup))
df$checkPrecip=ifelse(df$checkPrecipSum >= 1, 1, 0)

df$checkONLYPrecip=df$checkIndex_Precip-df$checkEvent
id_row=seq(1,length(df$checkONLYPrecip),by=No_subgroup)# -------------Modify the variable to consider heatwave，precipitation or compound: df$checkEvent, df$checkPrecip, df$checkCompound
Po_row=which(df$checkONLYPrecip[id_row]==1)
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
df$case[unlist(case_post)]=val_post #----------------------------0 or 1 or 2
df$case[unlist(case_warn)]=val_warn

if(pre>0){
  df$case[unlist(case_pre)]=val_pre
}

if(after>0){
  df$case[unlist(case_after)]=val_after
}

prepost=df[df$case == 0 | df$case == 1, ]

prepost$ID=rep(1:(nrow(prepost)/(No_replicate*No_subgroup)),by=1,each=No_replicate*No_subgroup)

saveRDS(prepost,'/Users/wangteng/Downloads/ChinaPrecip.rds')



