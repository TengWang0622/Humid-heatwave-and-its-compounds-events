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

# Branch: Main Script
# Description: Burden computation

############################################
#             Preparation
############################################

# Preparation

library(tidyr)
#library(openxlsx)

# Input the variables

No_replicate=14
No_subgroup=1

df_population=AgeSex

#df_GPD=GDP
#df_GDP_Pop_County=merge(df_GPD, df_population, by = "County")

df_City=df_GDP_Pop_City           

df_City$Cost_dir=14638.22*0.0019
df_City$Cost_indir=3.88*df_City$GDP/df_City$Pop*10000

#df_City$Cost_indir[is.nan(df_City$Cost_indir)]=0         # Remove NaN values

df_City$Cost=df_City$Cost_dir+df_City$Cost_indir
names(df_City)[names(df_City) == "City"]="County"         # Rename the City name as County

Burden_Heatoutput=data.frame()
Burden_Precipoutput=data.frame()
Burden_CompMoutput=data.frame()
Burden_CompSoutput=data.frame()

for(zz in 1:4){
  if(zz==1){
    prepost=ChinaHeat
  }
  if(zz==2){
    prepost=ChinaPrecip
  }
  if(zz==3){
    prepost=ChinaCompM
  }
  if(zz==4){
    prepost=ChinaCompS
  }
  
  subyearSTART=c("2016-01-01","2017-01-01","2018-01-01","2019-01-01","2020-01-01","2021-01-01","2022-01-01","2016-01-01")
  subyearEND=c("2016-12-31","2017-12-31","2018-12-31","2019-12-31","2020-12-31","2021-12-31","2022-12-31","2022-12-31")
  
  
  for(kk in 1:7){ # Subyear: kk in 1:7   Total years 16-22: kk in 8:8
    df_subyear=subset(prepost, datetime >= as.POSIXlt(subyearSTART[kk]) & datetime <= as.POSIXlt(subyearEND[kk]))
    Burden_row=seq((No_subgroup*No_replicate/2),(nrow(df_subyear)+No_subgroup*No_replicate/2),by=No_subgroup*No_replicate)
    df_Event=df_subyear[Burden_row,]
    SumEvent=df_Event %>% group_by(County) %>% summarize(County = unique(County), lon=mean(as.numeric(lon)), lat=mean(as.numeric(lat)), NoEvent = n())
    
    df_PopGDP=df_City
    df_Burden=merge(SumEvent,df_PopGDP, by.x = "County", by.y = "County", all = TRUE)
    
    Inflation=5.88*0.01
    PPP=1/4.208
    
    # Male
    if(zz==1){
      Risk_HeatMale=     # Input the risk (95CI considered)
      
      df_Burden$HeatMale=df_Burden$NoEvent*Risk_HeatMale*(1-Risk_HeatMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$HeatMale_dir=df_Burden$NoEvent*Risk_HeatMale*(1-Risk_HeatMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$HeatMale_indir=df_Burden$NoEvent*Risk_HeatMale*(1-Risk_HeatMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost_indir*PPP*(1+Inflation)
    }
    if(zz==2){
      Risk_PrecipMale=     # Input the risk (95CI considered)
        
      df_Burden$PrecipMale=df_Burden$NoEvent*Risk_PrecipMale*(1-Risk_PrecipMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$PrecipMale_dir=df_Burden$NoEvent*Risk_PrecipMale*(1-Risk_PrecipMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$PrecipMale_indir=df_Burden$NoEvent*Risk_PrecipMale*(1-Risk_PrecipMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost_indir*PPP*(1+Inflation)
    }
    if(zz==3){
      Risk_CompMMale=     # Input the risk (95CI considered)
        
      df_Burden$CompMMale=df_Burden$NoEvent*Risk_CompMMale*(1-Risk_CompMMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$CompMMale_dir=df_Burden$NoEvent*Risk_CompMMale*(1-Risk_CompMMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$CompMMale_indir=df_Burden$NoEvent*Risk_CompMMale*(1-Risk_CompMMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost_indir*PPP*(1+Inflation)
    }
    if(zz==4){
      Risk_CompSMale=     # Input the risk (95CI considered)
        
      df_Burden$CompSMale=df_Burden$NoEvent*Risk_CompSMale*(1-Risk_CompSMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$CompSMale_dir=df_Burden$NoEvent*Risk_CompSMale*(1-Risk_CompSMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$CompSMale_indir=df_Burden$NoEvent*Risk_CompSMale*(1-Risk_CompSMale)^(df_Burden$NoEvent-1)*df_Burden$Male*df_Burden$Cost_indir*PPP*(1+Inflation)
    }
    
    # Female
    if(zz==1){
      Risk_HeatFemale=     # Input the risk (95CI considered)
      
      df_Burden$HeatFemale=df_Burden$NoEvent*Risk_HeatFemale*(1-Risk_HeatFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$HeatFemale_dir=df_Burden$NoEvent*Risk_HeatFemale*(1-Risk_HeatFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$HeatFemale_indir=df_Burden$NoEvent*Risk_HeatFemale*(1-Risk_HeatFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==2){
      Risk_PrecipFemale=     # Input the risk (95CI considered)
      
      df_Burden$PrecipFemale=df_Burden$NoEvent*Risk_PrecipFemale*(1-Risk_PrecipFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$PrecipFemale_dir=df_Burden$NoEvent*Risk_PrecipFemale*(1-Risk_PrecipFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$PrecipFemale_indir=df_Burden$NoEvent*Risk_PrecipFemale*(1-Risk_PrecipFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==3){
      Risk_CompMFemale=     # Input the risk (95CI considered)
      
      df_Burden$CompMFemale=df_Burden$NoEvent*Risk_CompMFemale*(1-Risk_CompMFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$CompMFemale_dir=df_Burden$NoEvent*Risk_CompMFemale*(1-Risk_CompMFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$CompMFemale_indir=df_Burden$NoEvent*Risk_CompMFemale*(1-Risk_CompMFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==4){
      Risk_CompSFemale=     # Input the risk (95CI considered)
      
      df_Burden$CompSFemale=df_Burden$NoEvent*Risk_CompSFemale*(1-Risk_CompSFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$CompSFemale_dir=df_Burden$NoEvent*Risk_CompSFemale*(1-Risk_CompSFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$CompSFemale_indir=df_Burden$NoEvent*Risk_CompSFemale*(1-Risk_CompSFemale)^(df_Burden$NoEvent-1)*df_Burden$Female*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    
    # Age 18-44
    if(zz==1){
      Risk_HeatAge18_44=     # Input the risk (95CI considered)
      
      df_Burden$Heat18_44=df_Burden$NoEvent*Risk_HeatAge18_44*(1-Risk_HeatAge18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$Heat18_44_dir=df_Burden$NoEvent*Risk_HeatAge18_44*(1-Risk_HeatAge18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$Heat18_44_indir=df_Burden$NoEvent*Risk_HeatAge18_44*(1-Risk_HeatAge18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==2){
      Risk_PrecipAge18_44=     # Input the risk (95CI considered)
      
      df_Burden$Precip18_44=df_Burden$NoEvent*Risk_PrecipAge18_44*(1-Risk_PrecipAge18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$Precip18_44_dir=df_Burden$NoEvent*Risk_PrecipAge18_44*(1-Risk_PrecipAge18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$Precip18_44_indir=df_Burden$NoEvent*Risk_PrecipAge18_44*(1-Risk_PrecipAge18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==3){
      Risk_CompM18_44=     # Input the risk (95CI considered)
      
      df_Burden$CompM18_44=df_Burden$NoEvent*Risk_CompM18_44*(1-Risk_CompM18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$CompM18_44_dir=df_Burden$NoEvent*Risk_CompM18_44*(1-Risk_CompM18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$CompM18_44_indir=df_Burden$NoEvent*Risk_CompM18_44*(1-Risk_CompM18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==4){
      Risk_CompS18_44=     # Input the risk (95CI considered)
      
      df_Burden$CompS18_44=df_Burden$NoEvent*Risk_CompS18_44*(1-Risk_CompS18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$CompS18_44_dir=df_Burden$NoEvent*Risk_CompS18_44*(1-Risk_CompS18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$CompS18_44_indir=df_Burden$NoEvent*Risk_CompS18_44*(1-Risk_CompS18_44)^(df_Burden$NoEvent-1)*df_Burden$Agea*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    
    # Age 45-64
    if(zz==1){
      Risk_HeatAge45_64=     # Input the risk (95CI considered)
      
      df_Burden$Heat45_64=df_Burden$NoEvent*Risk_HeatAge45_64*(1-Risk_HeatAge45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$Heat45_64_dir=df_Burden$NoEvent*Risk_HeatAge45_64*(1-Risk_HeatAge45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$Heat45_64_indir=df_Burden$NoEvent*Risk_HeatAge45_64*(1-Risk_HeatAge45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==2){
      Risk_Precip45_64=     # Input the risk (95CI considered)
      
      df_Burden$Precip45_64=df_Burden$NoEvent*Risk_Precip45_64*(1-Risk_Precip45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$Precip45_64_dir=df_Burden$NoEvent*Risk_Precip45_64*(1-Risk_Precip45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$Precip45_64_indir=df_Burden$NoEvent*Risk_Precip45_64*(1-Risk_Precip45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==3){
      Risk_CompM45_64=     # Input the risk (95CI considered)
        
      df_Burden$CompM45_64=df_Burden$NoEvent*Risk_CompM45_64*(1-Risk_CompM45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$CompM45_64_dir=df_Burden$NoEvent*Risk_CompM45_64*(1-Risk_CompM45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$CompM45_64_indir=df_Burden$NoEvent*Risk_CompM45_64*(1-Risk_CompM45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==4){
      Risk_CompS45_64=     # Input the risk (95CI considered)
      
      df_Burden$CompS45_64=df_Burden$NoEvent*Risk_CompS45_64*(1-Risk_CompS45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$CompS45_64_dir=df_Burden$NoEvent*Risk_CompS45_64*(1-Risk_CompS45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$CompS45_64_indir=df_Burden$NoEvent*Risk_CompS45_64*(1-Risk_CompS45_64)^(df_Burden$NoEvent-1)*df_Burden$Ageb*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    # Age 65
    if(zz==1){
      Risk_HeatAge65=     # Input the risk (95CI considered)
      
      df_Burden$Heat65=df_Burden$NoEvent*Risk_HeatAge65*(1-Risk_HeatAge65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$Heat65_dir=df_Burden$NoEvent*Risk_HeatAge65*(1-Risk_HeatAge65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$Heat65_indir=df_Burden$NoEvent*Risk_HeatAge65*(1-Risk_HeatAge65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==2){
      Risk_Precip65=     # Input the risk (95CI considered)
      
      df_Burden$Precip65=df_Burden$NoEvent*Risk_Precip65*(1-Risk_Precip65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$Precip65_dir=df_Burden$NoEvent*Risk_Precip65*(1-Risk_Precip65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$Precip65_indir=df_Burden$NoEvent*Risk_Precip65*(1-Risk_Precip65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==3){
      Risk_CompM65=     # Input the risk (95CI considered)
      
      df_Burden$CompM65=df_Burden$NoEvent*Risk_CompM65*(1-Risk_CompM65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$CompM65_dir=df_Burden$NoEvent*Risk_CompM65*(1-Risk_CompM65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$CompM65_indir=df_Burden$NoEvent*Risk_CompM65*(1-Risk_CompM65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    if(zz==4){
      Risk_CompS65=     # Input the risk (95CI considered)
      
      df_Burden$CompS65=df_Burden$NoEvent*Risk_CompS65*(1-Risk_CompS65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost*PPP*(1+Inflation)
      df_Burden$CompS65_dir=df_Burden$NoEvent*Risk_CompS65*(1-Risk_CompS65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost_dir*PPP*(1+Inflation)
      df_Burden$CompS65_indir=df_Burden$NoEvent*Risk_CompS65*(1-Risk_CompS65)^(df_Burden$NoEvent-1)*df_Burden$Agec*df_Burden$Cost_indir*PPP*(1+Inflation)
      
    }
    
    #df_Burden=na.omit(df_Burden)
    #df_Burden[df_Burden == Inf]=0
    
    if(zz==1){
      subyear_Heatoutput=c(sum(df_Burden$HeatMale),sum(df_Burden$HeatMale_dir),sum(df_Burden$HeatMale_indir),sum(df_Burden$HeatFemale),sum(df_Burden$HeatFemale_dir),sum(df_Burden$HeatFemale_indir),sum(df_Burden$Heat18_44),sum(df_Burden$Heat18_44_dir),sum(df_Burden$Heat18_44_indir),sum(df_Burden$Heat45_64),sum(df_Burden$Heat45_64_dir),sum(df_Burden$Heat45_64_indir),sum(df_Burden$Heat65),sum(df_Burden$Heat65_dir),sum(df_Burden$Heat65_indir))
      Burden_Heatoutput=rbind(Burden_Heatoutput,subyear_Heatoutput)
    }
    if(zz==2){
      subyear_Precipoutput=c(sum(df_Burden$PrecipMale),sum(df_Burden$PrecipMale_dir),sum(df_Burden$PrecipMale_indir),sum(df_Burden$PrecipFemale),sum(df_Burden$PrecipFemale_dir),sum(df_Burden$PrecipFemale_indir),sum(df_Burden$Precip18_44),sum(df_Burden$Precip18_44_dir),sum(df_Burden$Precip18_44_indir),sum(df_Burden$Precip45_64),sum(df_Burden$Precip45_64_dir),sum(df_Burden$Precip45_64_indir),sum(df_Burden$Precip65),sum(df_Burden$Precip65_dir),sum(df_Burden$Precip65_indir))
      Burden_Precipoutput=rbind(Burden_Precipoutput,subyear_Precipoutput)
    }
    if(zz==3){
      subyear_CompMoutput=c(sum(df_Burden$CompMMale),sum(df_Burden$CompMMale_dir),sum(df_Burden$CompMMale_indir),sum(df_Burden$CompMFemale),sum(df_Burden$CompMFemale_dir),sum(df_Burden$CompMFemale_indir),sum(df_Burden$CompM18_44),sum(df_Burden$CompM18_44_dir),sum(df_Burden$CompM18_44_indir),sum(df_Burden$CompM45_64),sum(df_Burden$CompM45_64_dir),sum(df_Burden$CompM45_64_indir),sum(df_Burden$CompM65),sum(df_Burden$CompM65_dir),sum(df_Burden$CompM65_indir))
      Burden_CompMoutput=rbind(Burden_CompMoutput,subyear_CompMoutput)
    }
    if(zz==4){
      subyear_CompSoutput=c(sum(df_Burden$CompSMale),sum(df_Burden$CompSMale_dir),sum(df_Burden$CompSMale_indir),sum(df_Burden$CompSFemale),sum(df_Burden$CompSFemale_dir),sum(df_Burden$CompSFemale_indir),sum(df_Burden$CompS18_44),sum(df_Burden$CompS18_44_dir),sum(df_Burden$CompS18_44_indir),sum(df_Burden$CompS45_64),sum(df_Burden$CompS45_64_dir),sum(df_Burden$CompS45_64_indir),sum(df_Burden$CompS65),sum(df_Burden$CompS65_dir),sum(df_Burden$CompS65_indir))
      Burden_CompSoutput=rbind(Burden_CompSoutput,subyear_CompSoutput)
    }
    
  }
  
  if(zz==1){
    df_Heat=data.frame(df_Burden['County'],'lon'=df_Burden$lon,'lat'=df_Burden$lat,'NoHeat'=df_Burden$NoEvent,df_Burden['Heat18_44'],df_Burden['Heat18_44_dir'],df_Burden['Heat18_44_indir'],df_Burden['Heat45_64'],df_Burden['Heat45_64_dir'],df_Burden['Heat45_64_indir'],df_Burden['Heat65'],df_Burden['Heat65_dir'],df_Burden['Heat65_indir'])
  }
  if(zz==2){
    df_Precip=data.frame(df_Burden['County'],'lon'=df_Burden$lon,'lat'=df_Burden$lat,'NoPrecip'=df_Burden$NoEvent,df_Burden['Precip18_44'],df_Burden['Precip18_44_dir'],df_Burden['Precip18_44_indir'],df_Burden['Precip45_64'],df_Burden['Precip45_64_dir'],df_Burden['Precip45_64_indir'],df_Burden['Precip65'],df_Burden['Precip65_dir'],df_Burden['Precip65_indir'])
  }
  if(zz==3){
    df_CompM=data.frame(df_Burden['County'],'lon'=df_Burden$lon,'lat'=df_Burden$lat,'NoCompM'=df_Burden$NoEvent,df_Burden['CompM18_44'],df_Burden['CompM18_44_dir'],df_Burden['CompM18_44_indir'],df_Burden['CompM45_64'],df_Burden['CompM45_64_dir'],df_Burden['CompM45_64_indir'],df_Burden['CompM65'],df_Burden['CompM65_dir'],df_Burden['CompM65_indir'])
  }
  if(zz==4){
    df_CompS=data.frame(df_Burden['County'],'lon'=df_Burden$lon,'lat'=df_Burden$lat,'NoCompS'=df_Burden$NoEvent,df_Burden['CompS18_44'],df_Burden['CompS18_44_dir'],df_Burden['CompS18_44_indir'],df_Burden['CompS45_64'],df_Burden['CompS45_64_dir'],df_Burden['CompS45_64_indir'],df_Burden['CompS65'],df_Burden['CompS65_dir'],df_Burden['CompS65_indir'])
  }
  
}  

test=data.frame(df_Burden['County'],'NoHeat'=df_Burden$NoEvent)

if(kk==8){
  colnames(Burden_Heatoutput)=c('Male','Male_dir','Male_indir','Female','Female_dir','Female_indir','Age18_44','Age18_44_dir','Age18_44_indir','Age45_64','Age45_64_dir','Age45_64_indir','Age65','Age65_dir','Age65_indir')
  colnames(Burden_Precipoutput)=c('Male','Male_dir','Male_indir','Female','Female_dir','Female_indir','Age18_44','Age18_44_dir','Age18_44_indir','Age45_64','Age45_64_dir','Age45_64_indir','Age65','Age65_dir','Age65_indir')
  colnames(Burden_CompMoutput)=c('Male','Male_dir','Male_indir','Female','Female_dir','Female_indir','Age18_44','Age18_44_dir','Age18_44_indir','Age45_64','Age45_64_dir','Age45_64_indir','Age65','Age65_dir','Age65_indir')
  colnames(Burden_CompSoutput)=c('Male','Male_dir','Male_indir','Female','Female_dir','Female_indir','Age18_44','Age18_44_dir','Age18_44_indir','Age45_64','Age45_64_dir','Age45_64_indir','Age65','Age65_dir','Age65_indir')
  
  Overview=rbind(Burden_Heatoutput,Burden_Precipoutput,Burden_CompMoutput,Burden_CompSoutput)
  rownames(Overview)=c('Heat','Precip','CompM','CompS')
  print(Overview)
  
  df_OverallCountyBurden=merge(df_Heat, df_Precip, by = "County", all = TRUE)
  df_OverallCountyBurden=merge(df_OverallCountyBurden, df_CompM, by = "County", all = TRUE)
  df_OverallCountyBurden=merge(df_OverallCountyBurden, df_CompS, by = "County", all = TRUE)
  
  Burden1622=na.omit(df_OverallCountyBurden)
  
  df_Heat$AVE_BurdenHeat=(df_Heat$Heat18_44+df_Heat$Heat45_64+df_Heat$Heat65)/7
  df_Precip$AVE_BurdenPrecip=(df_Precip$Precip18_44+df_Precip$Precip45_64+df_Precip$Precip65)/7
  df_CompM$AVE_BurdenCompM=(df_CompM$CompM18_44+df_CompM$CompM45_64+df_CompM$CompM65)/7
  df_CompS$AVE_BurdenCompS=(df_CompS$CompS18_44+df_CompS$CompS45_64+df_CompS$CompS65)/7
  
  write.xlsx(df_Heat, file = "/Users/wangteng/Downloads/df_Heat.xlsx", rowNames = FALSE)
  write.xlsx(df_Precip, file = "/Users/wangteng/Downloads/df_Precip.xlsx", rowNames = FALSE)
  write.xlsx(df_CompM, file = "/Users/wangteng/Downloads/df_CompM.xlsx", rowNames = FALSE)
  write.xlsx(df_CompS, file = "/Users/wangteng/Downloads/df_CompS.xlsx", rowNames = FALSE)
  
  #write.xlsx(Burden1622, file = "/Users/wangteng/Downloads/Burden1622.xlsx", rowNames = FALSE)
}

ProcessBurden=function(Burden_output){
  rownames(Burden_output)=c('2016','2017','2018','2019','2020','2021','2022')
  colnames(Burden_output)=c('Male','Male_dir','Male_indir','Female','Female_dir','Female_indir','Age18_44','Age18_44_dir','Age18_44_indir','Age45_64','Age45_64_dir','Age45_64_indir','Age65','Age65_dir','Age65_indir')
  
  Burden_output$SexALL=Burden_output$Male+Burden_output$Female
  Burden_output$SexALL_dir=Burden_output$Male_dir+Burden_output$Female_dir
  Burden_output$SexALL_indir=Burden_output$Male_indir+Burden_output$Female_indir
  
  Burden_output$AgeALL=Burden_output$Age18_44+Burden_output$Age45_64+Burden_output$Age65
  Burden_output$AgeALL_dir=Burden_output$Age18_44_dir+Burden_output$Age45_64_dir+Burden_output$Age65_dir
  Burden_output$AgeALL_indir=Burden_output$Age18_44_indir+Burden_output$Age45_64_indir+Burden_output$Age65_indir
  
  return(Burden_output)
}

ProcessOverall=function(Burden_output){
  
  Total_Burden=sum(Burden_output$AgeALL)
  Total_Age18_44=sum(Burden_output$Age18_44)
  Total_Age45_64=sum(Burden_output$Age45_64)
  Total_Age65=sum(Burden_output$Age65)
  
  Total_Burden_dir=sum(Burden_output$AgeALL_dir)
  Total_Age18_44_dir=sum(Burden_output$Age18_44_dir)
  Total_Age45_64_dir=sum(Burden_output$Age45_64_dir)
  Total_Age65_dir=sum(Burden_output$Age65_dir)
  
  Total_Burden_indir=sum(Burden_output$AgeALL_indir)
  Total_Age18_44_indir=sum(Burden_output$Age18_44_indir)
  Total_Age45_64_indir=sum(Burden_output$Age45_64_indir)
  Total_Age65_indir=sum(Burden_output$Age65_indir)
  
  Percentage_Age18_44=round(sum(Burden_output$Age18_44)/Total_Burden,4)
  Percentage_Age45_64=round(sum(Burden_output$Age45_64)/Total_Burden,4)
  Percentage_Age65=round(sum(Burden_output$Age65)/Total_Burden,4)
  
  Overall=c('Total'=Total_Burden,'Total_dir'=Total_Burden_dir,'Total_indir'=Total_Burden_indir,'Age18_44'=Total_Age18_44,'Age18_44_dir'=Total_Age18_44_dir,'Age18_44_indir'=Total_Age18_44_indir,'Percentage18_44'=Percentage_Age18_44,'Age45_64'=Total_Age45_64,'Age45_64_dir'=Total_Age45_64_dir,'Age45_64_indir'=Total_Age45_64_indir,'Percentage45-64'=Percentage_Age45_64,'Age65'=Total_Age65,'Age65_dir'=Total_Age65_dir,'Age65_indir'=Total_Age65_indir,'Percentage65'=Percentage_Age65)
  return(Overall)
}

if(kk<8){
  Heatoutput=ProcessBurden(Burden_Heatoutput)
  Precipoutput=ProcessBurden(Burden_Precipoutput)
  CompMoutput=ProcessBurden(Burden_CompMoutput)
  CompSoutput=ProcessBurden(Burden_CompSoutput)
  
  Overall_Heat=ProcessOverall(Heatoutput)
  Overall_Precip=ProcessOverall(Precipoutput)
  Overall_CompM=ProcessOverall(CompMoutput)
  Overall_CompS=ProcessOverall(CompSoutput)
  
  Overall_Event=rbind(Overall_Heat,Overall_Precip,Overall_CompM,Overall_CompS)
  
  print(Heatoutput)
  print(Precipoutput)
  print(CompMoutput)
  print(CompSoutput)
  print(Overall_Event)
}





