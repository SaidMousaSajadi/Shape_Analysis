clear all ; clc ; clf % close all

theta = 0:0.01:2*pi ;
xc = 0 ; yc = 0 ; r = 1 ;

xd = xc + r*cos(theta) ;
yd = yc + r*sin(theta) ;

NoiseFactor = 0.2 ;

xd = xd + NoiseFactor * randn(size(xd)) ;
yd = yd + NoiseFactor * randn(size(yd)) ;

% index = randi(size(xd,2),[1,randi(length(theta),[1,1])]) ;
index = randi(size(xd,2),[1,180]) ;
% index = [100:10:250] ;

plot(xd(index),yd(index),'*k') ; hold on ;
axis equal
%%
ResultK = CircleFitByKasa([xd',yd']) ;
XDK = ResultK(1) + ResultK(3)*cos(theta) ;
YDK = ResultK(2) + ResultK(3)*sin(theta) ;
plot(ResultK(1),ResultK(2),'or')
plot(XDK,YDK,'r','LineWidth',2.5)


ResultP = CircleFitByPratt([xd',yd']) ;
XDP = ResultP(1) + ResultP(3)*cos(theta) ;
YDP = ResultP(2) + ResultP(3)*sin(theta) ;
plot(ResultP(1),ResultP(2),'og')
plot(XDP,YDP,'g','LineWidth',2.5)

ResultT = CircleFitByTaubin([xd',yd']) ;
XDT = ResultT(1) + ResultT(3)*cos(theta) ;
YDT = ResultT(2) + ResultT(3)*sin(theta) ;
plot(ResultT(1),ResultT(2),'ob')
plot(XDT,YDT,'b','LineWidth',2.5)

ResultL = CircleFitByLandau([xd',yd']) ;
XDL = ResultL(1) + ResultL(3)*cos(theta) ;
YDL = ResultL(2) + ResultL(3)*sin(theta) ;
plot(ResultL(1),ResultL(2),'oy')
plot(XDL,YDL,'y','LineWidth',2.5) ;




