%%

clc
clear
close all
set(0,'defaultfigurecolor','w')

figure_fontsize=18;

yy=-[
     
     15+2
     16.5+2
     18+2
     19.5+2
     
     21.5+3
     23+3
     24.5+3
     26+3];

xx1=[3.68 1.11, 6.25
    1.66 -0.95, 4.27
    2.01 -0.34, 4.36
    0.91 0.75, 1.07
    
    2.15 0.22, 4.08
    1.53 -0.82, 3.88
    1.04 0.83, 1.25
    1.07 0.19, 1.95];

oo1=[0
    0
    0
    0
    
    0
    0
    0
    0
    
    ];

BarColor=[
    255 100 100
    255 150 150
    255 200 200
    255 230 230
    
    64 64 255
    92 74 255
    128 128 255
    169 159 255
    ]/255;

MarkerColor=[200 0 0
    200 0 0
    200 0 0
    200 0 0
    
    67 50 225
    67 50 225
    67 50 225
    67 50 225
    
    ]/255;


fig1=figure(1);
for i=1:8
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

xx2=[2.48 0.80, 4.16
    1.16 -0.74, 3.06
    0.54 -0.99, 2.07
    1.06 0.02, 2.10
    
    0.98 -0.60, 2.56
    0.52 -1.24, 2.28
    0.10 -0.04, 0.24
    0.88 -0.14, 1.90
    
];

oo2=[0
    0
    0
    0
    
    0
    0
    0
    0
    
 ];



fig2=figure(2);
for i=1:8
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



xx3=[0.17 -0.34, 0.68
    0.18 -1.61, 1.97
    0.34 -1.58, 2.26
    1.00 -0.64, 2.64
    
    0.60 -0.60, 1.26
    0.23 -1.50, 1.96
    0.51 -1.31, 2.33
    0.62 -0.92, 2.16];

oo3=[0
    0
    0
    0
    
    0
    0
    0
    0
];



fig3=figure(3);
for i=1:8
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



xx4=[1.68 -0.24, 3.60
    0.36 -0.11, 0.83
    1.41 -2.38, 5.20
    1.05 -1.11, 3.21
    
    1.87 -1.75, 5.49
    0.55 -1.88, 2.98
    0.78 -1.73, 3.29
    0.99 -1.05, 3.03
    
];

oo4=[0
    0
    0
    0
    
    0
    0
    0
    0];
    



fig4=figure(4);
for i=1:8
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
xlim([-4,8])
xlabel('Risk (%)')
fig4.Position = [475 79 286 898];
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')





fig5=figure(5)
fig5.Position = [475 79 1500 898];
[ha,pos]=tight_subplot(1,4,[0.1 0.1],[0.1 0.1],[0.1,0.1])

axes(ha(2))

for i=1:8
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
xlim([-4,8])
ylim([-30 0])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xtick',[-4:2:8],'xticklabel',[-4:2:8])
%xref=[0 0];
%yref=[0 -30];
%plot(xref,yref,'-k')


xlabel('Risk (95% CI)')
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')
set(gca,'YAxisLocation','Origin')
axes(ha(3))

for i=1:8
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
set(gca,'xtick',[-4:2:8],'xticklabel',[-4:2:8])
xref=[0 0];
%yref=[0 -30];
%plot(xref,yref,'-k')
xlim([-4,8])
ylim([-30 0])

xlabel('Risk (95% CI)')
set(gca,'YAxisLocation','Origin')
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')


axes(ha(4))

for i=1:8
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
set(gca,'xtick',[-4:2:8],'xticklabel',[-4:2:8])
%xref=[0 0];
%yref=[0 -30];
%plot(xref,yref,'-k')
xlim([-4,8])
ylim([-30 0])

xlabel('Risk (95% CI)')

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')
set(gca,'YAxisLocation','Origin')
axes(ha(1))

for i=1:8
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
set(gca,'xtick',[-4:2:8],'xticklabel',[-4:2:8])
%xref=[0 0];
%yref=[0 -30];
%plot(xref,yref,'-k')
xlim([-4,8])
ylim([-30 0])
xlabel('Risk (95% CI)')
set(gca,'YAxisLocation','Origin')
set(gca,'fontsize',figure_fontsize,'fontname','times new roman')


%%
fig6=figure(6)

fig6.Position = [475 79 1500 898];

[ha,pos]=tight_subplot(1,1,[0.1 0.1],[0.1 0.1],[0.1,0.1])



fontsize=18;

ylim([-30 0])
xlim([-3 30])

text(10.2,0.5-14.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)
text(15.2,0.5-14.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)
text(20.2,0.5-14.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)
text(25.2,0.5-14.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)

yy=yy+0.5;

text(-1,yy(4)+1.4,'Male','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',90)
text(-1,yy(8)+1.06,'Female','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',90)



text(0,yy(1),'Pure hot spell','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(2),'Compound event (shower/light rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(3),'Compound event (moderate rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(4),'Extreme precipitation','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(0,yy(5),'Pure hot spell','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(6),'Compound event (shower/light rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(7),'Compound event (moderate rain)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(0,yy(8),'Extreme precipitation','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

% Pre-Warning

text(10,yy(1),'1.68 (-0.24, 3.60)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(2),'0.36 (-0.11, 0.83)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(3),'1.41 (-2.38, 5.20)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(4),'1.05 (-1.11, 3.21)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10,yy(5),'1.87 (-1.75, 5.49)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(6),'0.55 (-1.88, 2.98)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(7),'0.78 (-1.73, 3.29)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(8),'0.99 (-1.05, 3.03)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

% Pre-Post 1week

ss=1.5;
text(10*ss,yy(1),'3.68 (1.11, 6.25)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(2),'1.66 (-0.95, 4.27)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(3),'2.01 (-0.34, 4.36)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(4),'0.91 (0.75, 1.07)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10*ss,yy(5),'2.15 (0.22, 4.08)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(6),'1.53 (-0.82, 3.88)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(7),'1.04 (0.83, 1.25)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(8),'1.07 (0.19, 1.95)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


% Pre-Post 2week

ss=2;
text(10*ss,yy(1),'2.48 (0.80, 4.16)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(2),'1.16 (-0.74, 3.06)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(3),'0.54 (-0.99, 2.07)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(4),'1.06 (0.02, 2.10)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10*ss,yy(5),'0.98 (-0.60, 2.56)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(6),'0.52 (-1.24, 2.28)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(7),'0.10 (-0.04, 0.24)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(8),'0.88 (-0.14, 1.90)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


% Pre-Post 3week

ss=2.5;
text(10*ss,yy(1),'0.17 (-0.34, 0.68)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(2),'0.18 (-1.61, 1.97)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(3),'0.34 (-1.58, 2.26)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(4),'1.00 (-0.64, 2.64)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10*ss,yy(5),'0.60 (-0.60, 1.26)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(6),'0.23 (-1.50, 1.96)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(7),'0.51 (-1.31, 2.33)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(8),'0.62 (-0.92, 2.16)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)



xlabel('Risk (95% CI)')

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')
