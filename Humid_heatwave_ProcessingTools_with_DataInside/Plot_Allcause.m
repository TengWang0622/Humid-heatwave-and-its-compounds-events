%%

clc
clear
close all
set(0,'defaultfigurecolor','w')

figure_fontsize=18;

yy=-[2
     3.5
     5
     6.5
     
     8.5+1
     10+1
     11.5+1
     13+1
     
     15+2
     16.5+2
     18+2
     19.5+2
     
     21.5+3
     23+3
     24.5+3
     26+3];

xx1=[2.25 0.06 4.44
    2.10 -1.52 5.72
    1.10 0.30, 1.90
    0.92 0.64, 1.20
    
    2.21 1.08, 3.34
    2.13 1.25, 3.01
    1.32 0.60, 2.04
    0.95 -1.04, 2.94
    
    0.49 0.08, 0.90
    0.48 0.10, 0.86
    0.45 0.07, 0.83
    0.19 -0.21, 0.59
    
    0.01 -0.31, 0.29
    0.006 -0.03, 0.04
    0.02 -0.29, 0.33
    0.07 -0.35, 0.21];

oo1=[0
    0
    0
    0
    
    0
    0
    0
    0
    
    0
    0
    0
    0
    
    -0.01
    0
    0
    -0.07];

BarColor=[0 128 255
    102 178 255
    153 204 255
    204 229 255
    
    255 153 51
    255 178 102
    255 204 153
    255 229 204
    
    135 135 135
    160 160 160
    192 192 192
    224 224 224
    
    147 64 255
    165 100 255
    195 150 255
    230 213 252]/255;

MarkerColor=[0 0 255
    0 0 255
    0 0 255
    0 0 255
    
    153 76 0
    153 76 0
    153 76 0
    153 76 0
    
    0 0 0
    0 0 0
    0 0 0
    0 0 0
    
    127 0 255
    127 0 255
    127 0 255
    127 0 255]/255;


fig1=figure(1);
for i=1:length(yy)
    rectangle('Position',[oo1(i),yy(i),xx1(i,1),1],'FaceColor',BarColor(i,:),'EdgeColor','none')
    hold on
    scatter(xx1(i,2),yy(i)+0.5,30,MarkerColor(i,:),'o','filled')
    hold on
    scatter(xx1(i,3),yy(i)+0.5,30,MarkerColor(i,:),'o','filled')
    hold on
    linex=[xx1(i,2),xx1(i,3)];
    liney=[yy(i),yy(i)]+0.5;
    plot(linex,liney,'-','color',MarkerColor(i,:))
end
set(gca,'ytick',[],'yticklabel',[])

xref=[0 0];
yref=[0 -30];
plot(xref,yref,'-k')

xlabel('Risk (95% CI)')
fig1.Position = [475 79 286 898];
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')



%%



yy=-[2
     3.5
     5
     6.5
     
     8.5+1
     10+1
     11.5+1
     13+1
     
     15+2
     16.5+2
     18+2
     19.5+2
     
     21.5+3
     23+3
     24.5+3
     26+3];

xx2=[1.70 0.83, 2.57
    1.37 0.37, 2.37
    1.10 0.30, 1.90
    0.92 0.64, 1.20
    
    1.57 1.12, 2.03
    0.92 0.43, 1.41
    0.41 0.11, 0.71
    0.91 0.04, 1.86
    
    0.58 0.31, 0.85
    0.44 0.18, 0.70
    0.23 -0.008, 0.47
    0.09 -0.85, 0.67
    
    0.008 -0.21, 0.23
    0.005 -0.04, 0.05
    0.02 -0.12, 0.16
    0.008 -0.17, 0.19];

oo2=[0
    0
    0
    0
    
    0
    0
    0
    0
    
    0
    0
    0
    -0.09
    
    0
    0
    0
    0];

BarColor=[0 128 255
    102 178 255
    153 204 255
    204 229 255
    
    255 153 51
    255 178 102
    255 204 153
    255 229 204
    
    135 135 135
    160 160 160
    192 192 192
    224 224 224
    
    147 64 255
    165 100 255
    195 150 255
    230 213 252]/255;


fig2=figure(2);
for i=1:length(yy)
    rectangle('Position',[oo2(i),yy(i),xx2(i,1),1],'FaceColor',BarColor(i,:),'EdgeColor','none')
    hold on
    scatter(xx2(i,2),yy(i)+0.5,30,'ok','filled')
    hold on
    scatter(xx2(i,3),yy(i)+0.5,30,'ok','filled')
    hold on
    linex=[xx2(i,2),xx2(i,3)];
    liney=[yy(i),yy(i)]+0.5;
    plot(linex,liney,'-k')
end
set(gca,'ytick',[],'yticklabel',[])

xref=[0 0];
yref=[0 -30];
plot(xref,yref,'-k')
xlim([-2,6])
xlabel('Risk (%)')
fig2.Position = [475 79 286 898];
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')


%%



yy=-[2
     3.5
     5
     6.5
     
     8.5+1
     10+1
     11.5+1
     13+1
     
     15+2
     16.5+2
     18+2
     19.5+2
     
     21.5+3
     23+3
     24.5+3
     26+3];

xx3=[0.14 -0.26, 0.54
    0.38 -0.007, 0.77
    0.48 -0.11, 1.07
    0.60 -0.13, 1.33
    
    0.13 -0.49, 0.23
    0.38 -0.004, 0.76
    0.53 -0.07, 1.13
    0.22 -0.13, 0.57
    
    0.24 -0.10, 0.58
    0.33 -0.05, 0.71
    0.21 -0.13, 0.55
    0.12 -0.13, 0.37
    
    0.12 -0.20, 0.44
    0.009 -0.22, 0.24
    0.01 -0.14, 0.12
    0.015 -0.014, 0.044];

oo3=[0
    0
    0
    0
    
    -0.13
    0
    0
    0
    
    0
    0
    0
    0
    
    0
    0
    0
    0];

BarColor=[0 128 255
    102 178 255
    153 204 255
    204 229 255
    
    255 153 51
    255 178 102
    255 204 153
    255 229 204
    
    135 135 135
    160 160 160
    192 192 192
    224 224 224
    
    147 64 255
    165 100 255
    195 150 255
    230 213 252]/255;


fig3=figure(3);
for i=1:length(yy)
    rectangle('Position',[oo3(i),yy(i),xx3(i,1),1],'FaceColor',BarColor(i,:),'EdgeColor','none')
    hold on
    scatter(xx3(i,2),yy(i)+0.5,30,'ok','filled')
    hold on
    scatter(xx3(i,3),yy(i)+0.5,30,'ok','filled')
    hold on
    linex=[xx3(i,2),xx3(i,3)];
    liney=[yy(i),yy(i)]+0.5;
    plot(linex,liney,'-k')
end
set(gca,'ytick',[],'yticklabel',[])

xref=[0 0];
yref=[0 -30];
plot(xref,yref,'-k')
xlim([-2,6])
xlabel('Risk (%)')
fig3.Position = [475 79 286 898];
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')

%%



yy=-[2
     3.5
     5
     6.5
     
     8.5+1
     10+1
     11.5+1
     13+1
     
     15+2
     16.5+2
     18+2
     19.5+2
     
     21.5+3
     23+3
     24.5+3
     26+3];

xx4=[1.26 -0.71, 3.23
    1.58 -1.96, 5.12
    0.93 -0.97, 2.83
    1.42 1.11, 1.73
    
    1.13 -0.63, 2.89
    0.44 -0.67, 1.55
    1.07 0.98, 1.16
    1.08 0.15, 2.01
    
    0.23 -0.34, 0.80
    0.23 -0.07, 0.53
    0.28 0.10, 0.46
    0.09 -0.05, 0.23
    
    0.04 -0.44, 0.52
    0.003 -0.11, 0.12
    0.02 0.01, 0.03
    0.02 -0.36, 0.32];

oo4=[0
    0
    0
    0
    
    0
    0
    0
    0
    
    0
    0
    0
    0
    
    0
    0
    0
    -0.02];

BarColor=[0 128 255
    102 178 255
    153 204 255
    204 229 255
    
    255 153 51
    255 178 102
    255 204 153
    255 229 204
    
    135 135 135
    160 160 160
    192 192 192
    224 224 224
    
    147 64 255
    165 100 255
    195 150 255
    230 213 252]/255;


fig4=figure(4);
for i=1:length(yy)
    rectangle('Position',[oo4(i),yy(i),xx4(i,1),1],'FaceColor',BarColor(i,:),'EdgeColor','none')
    hold on
    scatter(xx4(i,2),yy(i)+0.5,30,'ok','filled')
    hold on
    scatter(xx4(i,3),yy(i)+0.5,30,'ok','filled')
    hold on
    linex=[xx4(i,2),xx4(i,3)];
    liney=[yy(i),yy(i)]+0.5;
    plot(linex,liney,'-k')
end
set(gca,'ytick',[],'yticklabel',[])

xref=[0 0];
yref=[0 -30];
plot(xref,yref,'-k')
xlim([-2,6])
xlabel('Risk (%)')
fig4.Position = [475 79 286 898];
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')





fig5=figure(5)
fig5.Position = [475 79 1500 898];
[ha,pos]=tight_subplot(1,4,[0.1 0.1],[0.1 0.1],[0.1,0.1])

axes(ha(2))

for i=1:length(yy)
    rectangle('Position',[oo1(i),yy(i),xx1(i,1),1],'FaceColor',BarColor(i,:),'EdgeColor','none')
    hold on
    scatter(xx1(i,2),yy(i)+0.5,30,MarkerColor(i,:),'o','filled')
    hold on
    scatter(xx1(i,3),yy(i)+0.5,30,MarkerColor(i,:),'o','filled')
    hold on
    linex=[xx1(i,2),xx1(i,3)];
    liney=[yy(i),yy(i)]+0.5;
    plot(linex,liney,'-','color',MarkerColor(i,:))
end
xlim([-2 6])
ylim([-30 0])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xtick',[-2:2:6],'xticklabel',[-2:2:6])
%xref=[0 0];
%yref=[0 -30];
%plot(xref,yref,'-k')

xlim([-2 6])

xlabel('Risk (95% CI)')
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')

axes(ha(3))

for i=1:length(yy)
    rectangle('Position',[oo2(i),yy(i),xx2(i,1),1],'FaceColor',BarColor(i,:),'EdgeColor','none')
    hold on
    scatter(xx2(i,2),yy(i)+0.5,30,MarkerColor(i,:),'o','filled')
    hold on
    scatter(xx2(i,3),yy(i)+0.5,30,MarkerColor(i,:),'o','filled')
    hold on
    linex=[xx2(i,2),xx2(i,3)];
    liney=[yy(i),yy(i)]+0.5;
    plot(linex,liney,'-','color',MarkerColor(i,:))
end
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xtick',[-2:2:6],'xticklabel',[-2:2:6])
xref=[0 0];
%yref=[0 -30];
%plot(xref,yref,'-k')
xlim([-2,6])
xlabel('Risk (95% CI)')

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')


axes(ha(4))

for i=1:length(yy)
    rectangle('Position',[oo3(i),yy(i),xx3(i,1),1],'FaceColor',BarColor(i,:),'EdgeColor','none')
    hold on
    scatter(xx3(i,2),yy(i)+0.5,30,MarkerColor(i,:),'o','filled')
    hold on
    scatter(xx3(i,3),yy(i)+0.5,30,MarkerColor(i,:),'o','filled')
    hold on
    linex=[xx3(i,2),xx3(i,3)];
    liney=[yy(i),yy(i)]+0.5;
    plot(linex,liney,'-','color',MarkerColor(i,:))
end
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xtick',[-2:2:6],'xticklabel',[-2:2:6])
%xref=[0 0];
%yref=[0 -30];
%plot(xref,yref,'-k')
xlim([-2,6])
xlabel('Risk (95% CI)')

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')

axes(ha(1))

for i=1:length(yy)
    rectangle('Position',[oo4(i),yy(i),xx4(i,1),1],'FaceColor',BarColor(i,:),'EdgeColor','none')
    hold on
    scatter(xx4(i,2),yy(i)+0.5,30,MarkerColor(i,:),'o','filled')
    hold on
    scatter(xx4(i,3),yy(i)+0.5,30,MarkerColor(i,:),'o','filled')
    hold on
    linex=[xx4(i,2),xx4(i,3)];
    liney=[yy(i),yy(i)]+0.5;
    plot(linex,liney,'-','color',MarkerColor(i,:))
end
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xtick',[-2:2:6],'xticklabel',[-2:2:6])
%xref=[0 0];
%yref=[0 -30];
%plot(xref,yref,'-k')
xlim([-2,6])
xlabel('Risk (95% CI)')

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')


%%
fig6=figure(6)

fig6.Position = [475 79 1500 898];

[ha,pos]=tight_subplot(1,1,[0.1 0.1],[0.1 0.1],[0.1,0.1])



fontsize=18;

ylim([-30 0])
xlim([-3 30])

text(10.2,0.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)
text(15.2,0.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)
text(20.2,0.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)
text(25.2,0.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)

yy=yy+0.5

text(-1,yy(4)+0.16,'Chronic IHD','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',90)
text(-1,yy(8)+1.12,'Angina','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',90)
text(-1,yy(12)+1.77,'MI','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',90)
text(-1,yy(16)+1.14,'Others','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',90)



text(0,yy(1),'Pure hot spell','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(2),'Compound event (shower/light rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(3),'Compound event (moderate rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(4),'Extreme precipitation','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(0,yy(5),'Pure hot spell','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(6),'Compound event (shower/light rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(7),'Compound event (moderate rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(8),'Extreme precipitation','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(0,yy(9),'Pure hot spell','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(10),'Compound event (shower/light rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(11),'Compound event (moderate rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(12),'Extreme precipitation','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(0,yy(13),'Pure hot spell','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(14),'Compound event (shower/light rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(15),'Compound event (moderate rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(16),'Extreme precipitation','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

% Pre-Warning

text(10,yy(1),'1.26 (-0.71, 3.23)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(2),'1.58 (-1.96, 5.12)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(3),'0.93 (-0.97, 2.83)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(4),'1.42 (1.11, 1.73)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10,yy(5),'1.13 (-0.63, 2.89)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(6),'0.44 (-0.67, 1.55)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(7),'1.07 (0.98, 1.16)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(8),'1.08 (0.15, 2.01)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10,yy(9),'0.23 (-0.34, 0.80)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(10),'0.23 (-0.07, 0.53)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(11),'0.28 (0.10, 0.46)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(12),'0.09 (-0.05, 0.23)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10,yy(13),'0.04 (-0.44, 0.52)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(14),'0.003 (-0.11, 0.12)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(15),'0.02 (0.01, 0.03)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(16),'-0.02 (-0.36, 0.32)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

% Pre-Post 1week

ss=1.5;
text(10*ss,yy(1),'2.25 (0.06, 4.44)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(2),'2.10 (-1.52, 5.72)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(3),'1.10 (0.30, 1.90)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(4),'0.92 (0.64, 1.20)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10*ss,yy(5),'2.21 (1.08, 3.34)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(6),'2.13 (1.25, 3.01)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(7),'1.32 (0.60, 2.04)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(8),'0.95 (-1.04, 2.94)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10*ss,yy(9),'0.49 (0.08, 0.90)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(10),'0.48 (0.10, 0.86)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(11),'0.45 (0.07, 0.83)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(12),'0.19 (-0.21, 0.59)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10*ss,yy(13),'-0.01(-0.31, 0.29)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(14),'0.006 (-0.03, 0.04)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(15),'0.02 (-0.29, 0.33)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(16),'-0.07 (-0.35, 0.21)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

% Pre-Post 2week

ss=2;
text(10*ss,yy(1),'1.70 (0.83, 2.57)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(2),'1.37 (0.37, 2.37)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(3),'1.04 (0.25, 1.83)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(4),'0.84 (0.24, 1.44)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10*ss,yy(5),'1.57 (1.12, 2.03)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(6),'0.92 (0.43, 1.41)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(7),'0.41 (0.11, 0.71)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(8),'0.91 (0.04, 1.86)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10*ss,yy(9),'0.58 (0.31, 0.85)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(10),'0.44 (0.18, 0.70)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(11),'0.23 (-0.008, 0.47)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(12),'-0.09 (-0.85, 0.67)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10*ss,yy(13),'0.008 (-0.21, 0.23)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(14),'0.005 (-0.04, 0.05)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(15),'0.02 (-0.12, 0.16)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(16),'0.008 (-0.17, 0.19)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

% Pre-Post 3week

ss=2.5;
text(10*ss,yy(1),'0.14 (-0.26, 0.54)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(2),'0.38 (-0.007, 0.77)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(3),'0.48 (-0.11, 1.07)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(4),'0.60 (-0.13, 1.33)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10*ss,yy(5),'-0.13 (-0.49, 0.23)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(6),'0.38 (-0.004, 0.76)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(7),'0.53 (-0.07, 1.13)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(8),'0.22 (-0.13, 0.57)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10*ss,yy(9),'0.24 (-0.10, 0.58)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(10),'0.33 (-0.05, 0.71)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(11),'0.21 (-0.13, 0.55)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(12),'0.12 (-0.13, 0.37)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10*ss,yy(13),'0.12 (-0.20, 0.44)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(14),'0.009 (-0.22, 0.24)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(15),'0.01 (-0.14, 0.12)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(16),'0.015 (-0.014, 0.044)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


xlabel('Risk (95% CI)')

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')
