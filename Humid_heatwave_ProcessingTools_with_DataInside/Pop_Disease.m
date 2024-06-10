
clc
clear
close all
set(0,'defaultfigurecolor','w')

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

Groupset=4;
No_bar=length(BarColor(:,1));
No_group=No_bar./Groupset;
No_group_gap=No_group-1;
No_bar_gap=No_group*3;


PopA = [83958
167787
82423
37176


266634
531863
267896
115208


85843
171338
84019
36805


81244
162225
79364
34481


]; 

PopB=[
61360
122170
59118
26432


218724
439459
217797
95202


64582
127965
61487
27705

58414
116642
56198
25010


    ];

PopC=[
    19697
39175
18460
8554

67937
136458
68210
29222

20522
40147
18891
8674

18774
37174
17445
8021

    ];

PopD=[
    4091
8047
3920
1814

12555
24936
12638
5437

4044
8052
3905
1754

3797
7518
3710
1611
];
% Prewarn
radiusAll=[PopA(4),PopA(12),PopA(16),PopA(8),PopB(4),PopB(12),PopB(16),PopB(8),PopC(4),PopC(12),PopC(16),PopC(8),PopD(4),PopD(12),PopD(16),PopD(8)];
% 1week
radiusAll=[PopA(1),PopA(9),PopA(13),PopA(5),PopB(1),PopB(9),PopB(13),PopB(5),PopC(1),PopC(9),PopC(13),PopC(5),PopD(1),PopD(9),PopD(13),PopD(5)];
% 2week
radiusAll=[PopA(2),PopA(10),PopA(14),PopA(6),PopB(2),PopB(10),PopB(14),PopB(6),PopC(2),PopC(10),PopC(14),PopC(6),PopD(2),PopD(10),PopD(14),PopD(6)];
% 3week
radiusAll=[PopA(3),PopA(11),PopA(15),PopA(7),PopB(3),PopB(11),PopB(15),PopB(7),PopC(3),PopC(11),PopC(15),PopC(7),PopD(3),PopD(11),PopD(15),PopD(7)];

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
