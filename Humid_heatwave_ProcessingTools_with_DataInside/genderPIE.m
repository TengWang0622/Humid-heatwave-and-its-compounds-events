
clc
clear
close all
set(0,'defaultfigurecolor','w')

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

Groupset=4;
No_bar=length(BarColor(:,1));
No_group=No_bar./Groupset;
No_group_gap=No_group-1;
No_bar_gap=No_group*3;


PopA = [94045
187071
89069
40679

304439
609332
305573
132254

97263
192436
92611
41285

89812
179573
86222
38118

]; 

PopB=[
75097
150108
74123
33297

261411
523384
260968
112827


77728
155066
75691
33656


72417
143986
70495
31030
    ];

% Prewarn
radiusAll=[PopA(4),PopA(12),PopA(16),PopA(8),PopB(4),PopB(12),PopB(16),PopB(8)];
% 1week
radiusAll=[PopA(1),PopA(9),PopA(13),PopA(5),PopB(1),PopB(9),PopB(13),PopB(5)];
% 2week
%radiusAll=[PopA(2),PopA(10),PopA(14),PopA(6),PopB(2),PopB(10),PopB(14),PopB(6)];
% 3week
%radiusAll=[PopA(3),PopA(11),PopA(15),PopA(7),PopB(3),PopB(11),PopB(15),PopB(7)];

radiusAll=log10(radiusAll)-2;
colorID=1:length(BarColor(:,1));


% Sequence

%[radiusAll, idx] = sort(radiusAll, 'descend')
%colorID=idx;


size_bar=5;
size_bargap=2;
size_groupgap=2;

Range=360;
darc=Range./(size_bar*No_bar+size_bargap*No_bar_gap+size_groupgap*(No_group_gap+1));

Range=180;
darc=Range./(size_bar*No_bar+size_bargap*No_bar_gap+size_groupgap*No_group_gap);


piece=[darc*size_bar darc*size_bargap darc*size_bar darc*size_bargap darc*size_bar darc*size_bargap darc*size_bar];
Distribution=piece;
for ss=1:No_group-1

Distribution=[Distribution darc*size_groupgap piece];

end

Arc_result=[0,cumsum(Distribution)];

for kk=1:length(radiusAll)
    
    radius=radiusAll(kk);

    theta_range = deg2rad([Arc_result(2*kk-1), Arc_result(2*kk)]); % 圆心角范围（度数转换为弧度）

    % 计算圆心角对应的极坐标角度
    theta = linspace(theta_range(1), theta_range(2), 100);

    % 构造扇形的极坐标数据
    r = ones(size(theta)) * radius;
    polar_data = [theta, fliplr(theta); zeros(size(theta)), r];

    % 绘制扇形图
    figure(10000);
    hold on

    if kk==1
       ax=polaraxes;
       ax.ThetaLim = [0, Range];
    end
    polarplot(polar_data(1, :), polar_data(2, :), 'Color',BarColor(colorID(kk),:), 'LineWidth', 2);
    hold on

    %ax.RLim = [0, 150000];

    % 设置极坐标轴的角度范围为0到180度
    ax.ThetaLim = [0, Range];


    % 模拟填充扇形内部的蓝色效果
    hold on;
    theta_fill = linspace(theta_range(1), theta_range(2), 100);
    
   
    
    r_fill = ones(size(theta_fill)) * radius;
    polarplot(theta_fill, r_fill, 'Color',BarColor(colorID(kk),:), 'LineWidth', 2);
    hold on
    for i=1:99
        polarplot([theta_fill(i), theta_fill(i+1)], [0, radius], 'Color',BarColor(colorID(kk),:), 'LineWidth', 2);
        hold on
        
        polarplot([theta_fill(i), theta_fill(i+1)], [0, 1], 'Color',[1 1 1], 'LineWidth', 2);
        hold on
        
        
    end
    hold on
end

%set(gca,'XColor','none')
%set(gca,'YColor','none')
set(gca,'fontsize',22,'fontname','times new roman')


thetaticks([])
%thetaticks([0 90])
%thetaticklabels({'gender', 'age'})
ax.RLim = [0, 4];
rticks([0:1:6])
rticklabels(["0","10^1","10^2","10^3","10^4"',"10^5","10^6"])
rticks([0:1:4])
rticklabels(["0","10^3","10^4"',"10^5","10^6"])



%rticklabels([0:1:6])

set(gca,'raxislocation',0,'layer','top')
