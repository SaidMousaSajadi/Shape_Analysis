Ax9 = axes ;
hold(Ax9,'on')
[~,Lab,~,~] = bwboundaries(BW) ;
bw = Lab == 1 ;
imshow(bw,'Parent',Ax9) ;
%% Maximum Inscribed Circle(MIC)
% run('MIC_withCentroid') ;
run('MIC_withSkeleton') ;
%%
theta = 0:0.01:2*pi ;
xCircMIC = XMIC + RMIC*cos(theta) ;
yCircMIC = YMIC + RMIC*sin(theta) ;

plot(Ax9,XMIC,YMIC,'*b') ;
plot(Ax9,xCircMIC,yCircMIC,'b','LineWidth',1.75) ;
%% Distance
for i = 1:length(X)
    D(i) = pdist([XMIC YMIC ; X(i) Y(i)]) ;
end

Alpha = 2*asind(RMIC/max(D)) ;
MaxInd = find(D == max(D)) ;
plot(Ax9,X(MaxInd(1)),Y(MaxInd(1)),'*y')

Side = sqrt(max(D)^2 - RMIC^2) ;

for i = 1:length(xCircMIC)
    Sider(i) = pdist([X(MaxInd(1)) Y(MaxInd(1)) ; xCircMIC(i) yCircMIC(i)]) ;
end
DSide = abs(Sider - Side) ;
PointInd = find(DSide == min(DSide)) ;
plot(Ax9,xCircMIC(PointInd(1)),yCircMIC(PointInd(1)),'*r')

plot(Ax9,[XMIC xCircMIC(PointInd(1))] , [YMIC yCircMIC(PointInd(1))],'g','LineWidth',1.5) 
plot(Ax9,[XMIC X(MaxInd(1))] , [YMIC Y(MaxInd(1))],'m','LineWidth',1.5)
plot(Ax9,[xCircMIC(PointInd(1)) X(MaxInd(1))] , [yCircMIC(PointInd(1)) Y(MaxInd(1))],'c','LineWidth',1.5)

AngularityFactor = (180 - Alpha)*(max(D)/RMIC) 










