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
# Description: Pre-post analysis

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

match=11 #match=11
pre=7    #pre=3
warn=3   #warn=7
post=7   #post=7
after=14 #after=14


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

#########################################################
#                Processing and Analysis
#########################################################

# =========== Compute the individual index =========== 

df$tempmaxC=round(5/9*(df$tempmax-32),digits=1)
df$tempC=round(5/9*(df$temp-32),digits=1)
df$tempminC=round(5/9*(df$tempmin-32),digits=1)

thres_temp=27.4 #--------------------------------------------------------------------- Input 

## ! NA 在pressure中
na_positions <- which(is.na(df$pressure))
df$pressure[is.na(df$pressure)]=1013.25

df$Index_temp=round((df$tempmaxC/thres_temp)*exp(0.01*(df$tempC-df$tempmaxC)),digits=2)
df$Index_HI=round(exp(1*(0.05*(df$tempC-thres_temp)+df$humidity/100-0.5)),digits=2)
df$Index_P=round(1*(1-(df$pressure-1013.25)/1013.25)+0,digits=2)
df$Index_SR=round(0.1*(df$solarradiation-min(df$solarradiation))/(max(df$solarradiation)-min(df$solarradiation))+0.9,digits=2)
df$Index_SE=round(0.1*(df$solarenergy-min(df$solarenergy))/(max(df$solarenergy)-min(df$solarenergy))+0.9,digits=2)

df$Index=round(df$Index_temp*df$Index_HI*df$Index_P*df$Index_SR,digits=2)
df$checkIndex=ifelse(df$Index >= 1.42, 1, 0) #--------------------------------------------------------------------- Input
#df$checkIndex=ifelse(df$Index >= 1 & df$Index < 1.1, 1, 0)
#df$checkIndex=ifelse(df$Index >= 1.1 & df$Index < 1.2, 1, 0)
#df$checkIndex=ifelse(df$Index >= 1.2 & df$Index < 1.3, 1, 0)
#df$checkIndex=ifelse(df$Index >= 1.3 & df$Index <= 1.42, 1, 0)
#df$checkIndex=ifelse(df$Index < 1, 1, 0)
df$checkIndex_Precip=ifelse(df$precip > 0, 1, 0)


# ================= Prepost analysis ======================

df$checkEventSum=df$checkIndex+c(df$checkIndex[(No_subgroup+1):nrow(df)],rep(0,No_subgroup))+c(df$checkIndex[(2*No_subgroup+1):nrow(df)],rep(0,2*No_subgroup))
df$checkEvent=ifelse(df$checkEventSum == 3, 1, 0)

df$checkPrecipSum=df$checkIndex_Precip+c(df$checkIndex_Precip[(No_subgroup+1):nrow(df)],rep(0,No_subgroup))+c(df$checkIndex_Precip[(2*No_subgroup+1):nrow(df)],rep(0,2*No_subgroup))+c(df$checkIndex_Precip[(3*No_subgroup+1):nrow(df)],rep(0,3*No_subgroup))+c(df$checkIndex_Precip[(4*No_subgroup+1):nrow(df)],rep(0,4*No_subgroup))+c(df$checkIndex_Precip[(5*No_subgroup+1):nrow(df)],rep(0,5*No_subgroup))+c(df$checkIndex_Precip[(6*No_subgroup+1):nrow(df)],rep(0,6*No_subgroup))
df$checkPrecip=ifelse(df$checkPrecipSum >= 1, 1, 0)

df$checkONLYheat=df$checkEvent-df$checkIndex_Precip

id_row=seq(1,length(df$checkONLYheat),by=No_subgroup)# ---------------------Specify which to analyse: heatwave，precipitation or compound: df$checkEvent, df$checkPrecip, df$checkCompound
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


df$case=-1
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

#mutate covariates
prepost %<>%mutate(DOW=weekdays(as.Date(datetime)))

prepost %<>%
  mutate(holiday = case_when(datetime >= as.Date("2016-02-07") & datetime <= as.Date("2016-02-13")
                             | datetime >= as.Date("2017-01-27") & datetime <= as.Date("2017-02-02") | datetime >= as.Date("2018-02-15") & datetime <= as.Date("2018-02-21") 
                             | datetime >=as.Date("2019-09-01") & datetime <= as.Date("2019-12-31") 
                             | datetime >=as.Date("2019-02-04") & datetime <= as.Date("2019-02-10") 
                             | datetime >=as.Date("2020-01-25") & datetime <= as.Date("2020-01-31")
                             | datetime >=as.Date("2021-02-12") & datetime <= as.Date("2021-02-18")
                             | datetime >=as.Date("2022-02-01") & datetime <= as.Date("2022-02-07")~ "春节",TRUE ~ "其他"))
prepost$holiday[str_which(prepost$datetime,'01-01|01-02|01-03')]<-'元旦'
prepost$holiday[str_which(prepost$datetime,'10-01|10-02|10-03|10-04|10-05|10-06|10-07')]<-'国庆节'
prepost$holiday[str_which(prepost$datetime,'05-01|05-02|05-03|05-04|05-05')]<-'劳动节'
prepost$holiday[str_which(prepost$holiday,'其他')]<-0
prepost$holiday[str_which(prepost$holiday,'春节|劳动节|国庆节|元旦')]<-1
saveRDS(prepost,'Z:/EnvH/Heatwave/Posted/Datasets/Derived/PrePost_All/prepost.rds')

prepostCounty1=glmer(All_cause ~ case + (1|datetime) + DOW + holiday, data=prepost)
summary(prepostCounty1)
exp(summary(prepostCounty1)$coefficients)

###Sungroup (Age and Sex)###
prepost_pheatwavem <- subset(prepost_pheatwave, prepost_pheatwave$Gender=='Male')
prepost_pheatwavef <- subset(prepost_pheatwave,prepost_pheatwave$Gender=='Female')
prepostCounty1=glmer(All_cause ~ case + (1|datetime) + DOW + holiday, data=prepost_pheatwavem)
summary(prepostCounty1)
exp(summary(prepostCounty1)$coefficients)

prepost_pheatwavea <- subset(prepost_pheatwave, prepost_pheatwave$Age_g=='18_44y')
prepost_pheatwaveb <- subset(prepost_pheatwave,prepost_pheatwave$Age_g=='45_64y')
prepost_pheatwavec <- subset(prepost_pheatwave,prepost_pheatwave$Age_g=='65y')
prepostCounty1=glmer(All_cause ~ case + (1|datetime) + DOW + holiday, data=prepost_pheatwavea)
summary(prepostCounty1)
exp(summary(prepostCounty1)$coefficients)
