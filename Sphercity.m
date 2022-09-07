%% Sphercity
Ax10 = axes ;
hold(Ax10,'on') ;
% For Show
[Bound,Lab,~,~] = bwboundaries(BW) ;
bw = Lab == 1 ;
imshow(bw,'Parent',Ax10)
%% Step1
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

%% Show MCC
Theta = 0:0.01:2*pi ;
xcircR = XMCC + RMCC*cos(Theta) ;
ycircR = YMCC + RMCC*sin(Theta) ;
h1 = plot(Ax10,xcircR,ycircR,'r','LineWidth',1.5) ;

s = regionprops(bw,'EquivDiameter','Area') ;

REQU = sqrt(s.Area/pi) ;

title (['Spherecity = ' num2str(REQU/RMCC)])
