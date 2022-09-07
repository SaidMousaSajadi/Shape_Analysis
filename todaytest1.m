clear all ; close all ; clc 
%% import image png
[IM , M] = imread('Shape2.png') ;
IM = imresize(IM,[300 NaN]) ; % for decrease compute process
G = rgb2gray(IM) ; % rgb to grayscale image
BW = imbinarize(G) ; % grayscale image to binary image
BW = imerode(BW,strel('disk',1)) ; % Improve Binary image

%% 
[~,Lab,~,~] = bwboundaries(BW) ;
bw = Lab == 1 ;
imshow(bw) ; hold on ;
[Bound,~,~,~] = bwboundaries(bw) ;
% global x y % additional
x = Bound{2,1}(:,2) ;
y = Bound{2,1}(:,1) ;
plot(x,y,'b','LineWidth',1.25) ;

index = randi(length(x),[1,25]) ;
% index = [400:10:460] ;
xr = x(index) ;
yr = y(index) ;

plot(xr,yr,'*y') ;

Para = CircleFitByKasa([xr , yr]) ;

xc = round(Para(1)) ;
yc = round(Para(2)) ;

% plot(xc,yc,'or') ;
theta = 0:0.01:2*pi ;
xp = xc + (Para(3)+10)*cos(theta) ;
yp = yc + (Para(3)+10)*sin(theta) ;

plot(xp,yp,'r')

LCen = CheckCenterInGrain(bw,xc,yc) ;

[~,Factor] = CheckCircleInGrain(bw,xc,yc,Para(3)+10,0.9)

[~,Factor] = CheckGrainInCircle(bw,xc,yc,Para(3)+10,0.9)












