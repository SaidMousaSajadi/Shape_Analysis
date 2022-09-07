Ax11 = axes ;
hold(Ax11,'on')
[~,Lab,~,~] = bwboundaries(BW) ;
bw = Lab == 1 ;
imshow(bw,'Parent',Ax11) ;
%% MIC
% tip1
% run('MIC_withCentroid')
% tip2
run('MIC_withSkeleton')
%%
theta = 0:0.01:2*pi ;
xCircMIC = XMIC + RMIC*cos(theta) ;
yCircMIC = YMIC + RMIC*sin(theta) ;

plot(Ax11,XMIC,YMIC,'*b') ;
plot(Ax11,xCircMIC,yCircMIC,'b','LineWidth',1.75) ;

%% MCC Step1
% Tip1:
% run('MCC_withoutSelectMIC')
% Tip2:
% run('MCC_withCentroidMIC')
% Tip3:
run('MCC_withSkeletonMIC')
%% Step2
% Tip1:
% run('MCC_FitWithCluseter')
% Tip2:
run('MCC_FitWithPeak')

Theta = 0:0.01:2*pi ;
xcircMCC = XMCC + RMCC*cos(Theta) ;
ycircMCC = YMCC + RMCC*sin(Theta) ;
plot(Ax11,xcircMCC,ycircMCC,'r','LineWidth',1.5) ;


title(['Circularity = ' num2str(sqrt(RMIC/RMCC))])


%% Shade
patch(Ax11,[xCircMIC , xcircMCC] , [yCircMIC , ycircMCC] , 'g','linestyle','none','FaceAlpha' , 0.3)
%% Least Square Circle(LSC)
RL = mean([RMIC,RMCC]) ;
XL = mean([XMIC,XMCC]) ;
YL = mean([YMIC,YMCC]) ;

Theta = 0:0.01:2*pi ;
xcircL = XL + RL*cos(Theta) ;
ycircL = YL + RL*sin(Theta) ;
plot(Ax11,xcircL,ycircL,'--m','LineWidth',2) ;






