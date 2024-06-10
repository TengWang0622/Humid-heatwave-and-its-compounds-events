%%

clc
clear
close all
set(0,'defaultfigurecolor','w')

figure_fontsize=18;

yy=-[8.5+1
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

xx1=[4.95 0.54, 9.36
    3.30 0.62, 5.98
    2.94 0.10, 5.78
    1.97 -0.71, 4.65
    
    2.34 0.90, 3.78
    1.69 -1.56, 4.94
    1.39 0.32, 2.46
    0.80 0.64, 0.96
    
    0.45 0.39, 0.51
    0.27 -0.38, 0.92
    0.23 -0.41, 0.87
    0.22 -0.27, 0.76
    
    ];

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
];

BarColor=[255 51 153
    255 102 178
    255 153 204
    255 204 229
    
    102 213 202
    124 228 217
    159 240 232
    191 246 241
    
    110 185 145
    155 216 184
    178 228 201
    202 229 215
    
    
    
    ]/255;

MarkerColor=[204 0 102
    204 0 102
    204 0 102
    204 0 102
    
    58 179 159
    58 179 159
    58 179 159
    58 179 159
    
    64 144 112
    64 144 112
    64 144 112
    64 144 112
    
    ]/255;


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


xx2=[3.29 0.39, 6.19
    2.22 0.04, 4.40
    0.54 -0.34, 1.42
    1.13 -0.35, 2.61
    
    1.61 0.04, 3.18
    0.22 -0.23, 0.67
    0.01 -1.60, 1.58
    0.69 -0.46, 1.84
    
    0.30 -0.15, 0.75
    0.06 -0.39, 0.51
    0.03 -0.40, 0.46
    0.09 -0.25, 0.43
    
    ];

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
    0
    
   ];


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


xx3=[0.17 -1.11, 0.77
    0.42 -3.55, 4.39
    0.58 -2.92, 4.08
    0.43 -1.23, 1.66
    
    0.12 -0.33, 0.09
    0.03 -1.52, 1.58
    0.26 -1.31, 1.83
    0.10 -0.62, 0.82
    
    0.10 -0.46, 0.66
    0.17 -0.41, 0.75
    0.14 -0.45, 0.73
    0.04 -0.08, 0.16
    
    ];

oo3=[-0.17
    0
    0
    0
    
    -0.12
    0
    0
    0
    
    0
    0
    0
    0
    
    ];




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




xx4=[1.89 1.23, 2.55
    1.57 -2.35, 5.49
    2.21 -0.41, 4.83
    1.14 -2.56, 4.84
    
    0.91 -3.09, 4.91
    0.75 -2.46, 3.96
    1.56 -1.02, 4.14
    0.57 -0.68, 1.82
    
    0.03 -0.99, 1.05
    0.05 -1.01, 1.11
    0.09 -0.89, 1.07
    0.14 -0.82, 0.54
    
    ];

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
    -0.14];




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
set(gca,'YAxisLocation','Origin')




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
xlim([-4 10])
ylim([-30 0])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xtick',[-4:2:10],'xticklabel',[-4:2:10])
xlabel('Risk (95% CI)')
set(gca,'YAxisLocation','Origin')

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
xlim([-4 10])
ylim([-30 0])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xtick',[-4:2:10],'xticklabel',[-4:2:10])
xlabel('Risk (95% CI)')
set(gca,'YAxisLocation','Origin')

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
xlim([-4 10])
ylim([-30 0])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xtick',[-4:2:10],'xticklabel',[-4:2:10])
xlabel('Risk (95% CI)')
set(gca,'YAxisLocation','Origin')

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
xlim([-4 10])
ylim([-30 0])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xtick',[-4:2:10],'xticklabel',[-4:2:10])
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

text(10.2,0.5-6.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)
text(15.2,0.5-6.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)
text(20.2,0.5-6.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)
text(25.2,0.5-6.5,'Risk (95% CI)','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',0)

yy=yy+0.5

text(-1,yy(4)+0.96,'Old-age','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',90)
text(-1,yy(8)+0.42,'Middle-age','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',90)
text(-1,yy(12)+0.37,'Young-age','fontsize',figure_fontsize,'fontweight','bold','fontname','times new roman','color','k','rotation',90)



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


% Pre-Warning

text(10,yy(1),'1.89 (1.23, 2.55)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(2),'1.57 (-2.35, 5.49)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(3),'2.21 (-0.41, 4.83)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(4),'1.14 (-2.56, 4.84)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10,yy(5),'0.91 (-3.09, 4.91)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(6),'0.75 (-2.46, 3.96)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(7),'1.56 (-1.02, 4.14)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(8),'0.57 (-0.68, 1.82)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10,yy(9),'0.03 (-0.99, 1.05)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(10),'0.05 (-1.01, 1.11)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(11),'0.09 (-0.89, 1.07)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10,yy(12),'-0.14 (-0.82, 0.54))','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

% Pre-Post 1week

ss=1.5;
text(10*ss,yy(1),'4.95 (0.54, 9.36)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(2),'3.30 (0.62, 5.98)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(3),'2.94 (0.10, 5.78)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(4),'1.97 (-0.71, 4.65)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10*ss,yy(5),'2.34 (0.90, 3.78)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(6),'1.69 (-1.56, 4.94)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(7),'1.39 (0.32, 2.46)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(8),'0.80 (0.64, 0.96)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10*ss,yy(9),'0.45 (0.39, 0.51)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(10),'0.27 (-0.38, 0.92)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(11),'0.23 (-0.41, 0.87)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(12),'0.22 (-0.27, 0.76)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


% Pre-Post 2week

ss=2;
text(10*ss,yy(1),'3.29 (0.39, 6.19)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(2),'2.22 (0.04, 4.40)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(3),'0.54 (-0.34, 1.42)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(4),'1.13 (-0.35, 2.61)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10*ss,yy(5),'1.61 (0.04, 3.18) ','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(6),'0.22 (-0.23, 0.67)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(7),'-0.01 (-1.60, 1.58)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(8),'0.69 (-0.46, 1.84)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10*ss,yy(9),'0.30 (-0.15, 0.75)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(10),'0.06 (-0.39, 0.51)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(11),'0.03 (-0.40, 0.46)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(12),'0.09 (-0.25, 0.43)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


% Pre-Post 3week

ss=2.5;
text(10*ss,yy(1),'-0.17 (-1.11, 0.77)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(2),'0.42 (-3.55, 4.39)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(3),'0.58 (-2.92, 4.08)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(4),'0.43 (-1.23, 1.66)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


text(10*ss,yy(5),'-0.12 (-0.33, 0.09)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(6),'0.03 (-1.52, 1.58)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(7),'0.26 (-1.31, 1.83)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(8),'0.10 (-0.62, 0.82)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)

text(10*ss,yy(9),'0.10 (-0.46, 0.66)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(10),'0.17 (-0.41, 0.75)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(11),'0.14 (-0.45, 0.73)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)
text(10*ss,yy(12),'0.04 (-0.08, 0.16)','fontsize',figure_fontsize,'fontname','times new roman','color','k','rotation',0)


xlabel('Risk (95% CI)')

set(gca,'fontsize',figure_fontsize,'fontname','times new roman')
