%% Sensitivity for Heat wave project
 
% Developed by Teng
% Updated on July 1st 2023

% =======Objectives=======



%% Preparation

clc
clear
close all
set(0,'defaultfigurecolor','w')


%%

figure_fontsize=18;


Temp_thres=27.4;


figure(1)

Temp_mean=0:40/100:40;
Temp_max=0:40/100:40;

k=0;
for i=1:length(Temp_mean)
    for j=1:length(Temp_max)
        if Temp_max(j)>=Temp_mean(i)
            k=k+1;
            Vector_Temp_mean(1,k)=Temp_mean(i);
            Vector_Temp_max(1,k)=Temp_max(j);
            Vector_Temp_Index(1,k)=Temp_max(j)/27.4*exp(0.01*(Temp_mean(i)-Temp_max(j)));
        end
    end
end

[X, Y] = meshgrid(linspace(min(Vector_Temp_mean), max(Vector_Temp_mean), 100), linspace(min(Vector_Temp_max), max(Vector_Temp_max), 100));
Z = griddata(Vector_Temp_mean, Vector_Temp_max, Vector_Temp_Index, X, Y, 'cubic');


s=surf(X, Y, Z,'FaceAlpha',0.7);
s.EdgeColor = 'none';
xlabel('\itT_{\rmmax} \rm(\circC)')
ylabel('<\itT\rm> (\circC)')
zlabel('\itI_T')

c_bar=colorbar;
c_bar.Label.String='\itI_T';
    

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')



figure(2)

Humidity=0:1:100;
k=0;
for i=1:length(Temp_mean)
    for j=1:length(Humidity)
        k=k+1;
        Vector_Temp_mean(1,k)=Temp_mean(i);
        Vector_Humidity(1,k)=Humidity(j);
        Vector_Index_HI(1,k)=exp(0.05*(Temp_mean(i)-Temp_thres)+Humidity(j)/100-0.5);
    end
end

[X, Y] = meshgrid(linspace(min(Vector_Temp_mean), max(Vector_Temp_mean), 100), linspace(min(Vector_Humidity), max(Vector_Humidity), 100));
Z = griddata(Vector_Temp_mean, Vector_Humidity, Vector_Index_HI, X, Y, 'cubic');


s=surf(X, Y, Z,'FaceAlpha',0.7);
s.EdgeColor = 'none';
xlabel('<\itT\rm> (\circC)')
ylabel('\itRH \rm(%)')
zlabel('\itI_{HI}')

c_bar=colorbar;
c_bar.Label.String='\itI_{HI}';
    

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')


figure(3)

Pressure=101.325-5:0.1:101.325+5;
Index_P=Pressure/101.325;

plot(Pressure,Index_P,'-k','linewidth',2)

xlabel('\itP \rm(kPa)')
ylabel('\itI_P')
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')



figure(4)

SE=0:0.549:54.9;
Index_SE=0.1*(SE/54.9)+0.9;

plot(SE,Index_SE,'-k','linewidth',2)

xlabel('\itE \rm(W/m^2)')
ylabel('\itI_E')
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')





figure(5)


Test_Temp=min(Vector_Temp_Index):(max(Vector_Temp_Index)-min(Vector_Temp_Index))/100:max(Vector_Temp_Index);
Test_HI=min(Vector_Index_HI):(max(Vector_Index_HI)-min(Vector_Index_HI))/100:max(Vector_Index_HI);

Test_P=1;
Test_E=0.95;

k=0;
for i=1:length(Test_Temp)
    for j=1:length(Test_HI)
        k=k+1;
        Vector_Test_Temp(1,k)=Test_Temp(i);
        Vector_Test_HI(1,k)=Test_HI(j);
        Vector_Index(1,k)=Test_Temp(i)*Test_HI(j)*Test_P*Test_E;
    end
end

[X, Y] = meshgrid(linspace(min(Vector_Test_Temp), max(Vector_Test_Temp), 100), linspace(min(Vector_Test_HI), max(Vector_Test_HI), 100));
Z = griddata(Vector_Test_Temp, Vector_Test_HI, Vector_Index, X, Y, 'cubic');


s=surf(X, Y, Z,'FaceAlpha',0.7);
s.EdgeColor = 'none';
xlabel('\itI_T')
ylabel('\itI_{HI}')
zlabel('\itI_{heatwave}')

c_bar=colorbar;
c_bar.Label.String='\itI_{heatwave}';
    

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')


figure(6)

Precip=0:13.109/100:13.109;
Wind=0:122.9/100:122.9;
Precip95=0.713;
Wind_ref=10.8;

k=0;
for i=1:length(Precip)
    for j=1:length(Wind)
        k=k+1;
        Vector_Precip(1,k)=Precip(i);
        Vector_Wind(1,k)=Wind(j);
        Vector_Index_Precip(1,k)=Precip(i)/Precip95*exp(0.001*Wind(j).^2/Wind_ref^2)*Test_P;
    end
end

[X, Y] = meshgrid(linspace(min(Vector_Precip), max(Vector_Precip), 100), linspace(min(Vector_Wind), max(Vector_Wind), 100));
Z = griddata(Vector_Precip, Vector_Wind, Vector_Index_Precip, X, Y, 'cubic');


s=surf(X, Y, Z,'FaceAlpha',0.7);
s.EdgeColor = 'none';
xlabel('\itR \rm(mm)')
ylabel('\itW \rm(m/s)')
zlabel('\itI_{precip}')

c_bar=colorbar;
c_bar.Label.String='\itI_{precip}';
    

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')

figure(7)

Index_wind=exp(0.001*Wind.^2/Wind_ref^2);
plot(Wind,Index_wind,'-k','linewidth',2)
xlabel('\itW \rm(m/s)')
ylabel('\itI_W')

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')


figure(8)



Precip=0:13.109/100:13.109;
Wind=min(min(Index_wind)):(max(Index_wind)-min(Index_wind))/100:max(Index_wind);
Precip95=0.713;
Wind_ref=10.8;

k=0;
for i=1:length(Precip)
    for j=1:length(Wind)
        k=k+1;
        Vector_Precip(1,k)=Precip(i);
        Vector_Wind(1,k)=Wind(j);
        Vector_Index_Precip(1,k)=Precip(i)/Precip95*exp(0.001*Wind(j).^2/Wind_ref^2)*Test_P;
    end
end

[X, Y] = meshgrid(linspace(min(Vector_Precip), max(Vector_Precip), 100), linspace(min(Vector_Wind), max(Vector_Wind), 100));
Z = griddata(Vector_Precip, Vector_Wind, Vector_Index_Precip, X, Y, 'cubic');


s=surf(X, Y, Z,'FaceAlpha',0.7);
s.EdgeColor = 'none';
xlabel('\itR \rm(mm)')
ylabel('\itI_W')
zlabel('\itI_{precip}')

c_bar=colorbar;
c_bar.Label.String='\itI_{precip}';
    

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')














