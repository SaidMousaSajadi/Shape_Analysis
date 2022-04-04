%% Axes Properties
Ax1 = axes ;
hold(Ax1,'on') ;
%% Bondary Properties
[~,Lab,~,~] = bwboundaries(BW) ;
BW = Lab == 3 ;
%% RegionProperties
s = regionprops(BW,'MinFeretProperties','Orientation') ;
%% Inner Figure
Fi = figure('Color','w') ;
Axi = gca ; 
hold(Axi,'on') ;
Alpha = 180 + s.MinFeretAngle ;
% plot(Axi,s.MinFeretCoordinates(:,1),s.MinFeretCoordinates(:,2)) ;
axis(Axi,'equal') ;
view(-Alpha,90)
imshow(~BW,'Parent',Axi)
Axi.Toolbar.Visible = 'off' ;
pause(1)
Frame = getframe(Fi) ;
close(Fi) ; clear Fi
imwrite(Frame.cdata,'test.png') ;
clear Frame ;
%% Reinstalling
[im , m] = imread('test.png') ;
delete('test.png') ;

g = rgb2gray(im) ; % rgb to grayscale image
bw = imbinarize(g) ; % grayscale image to binary image
bw = imerode(bw,strel('disk',1)) ; % Improve Binary image

[~,Lab,~,~] = bwboundaries(bw) ;
bw = Lab == 3 ;

%% RegionProperties
S = regionprops(bw,'MinFeretProperties','Orientation','BoundingBox','MaxFeretProperties') ;

%% Show
imshow(~bw,'Parent',Ax1)

plot(Ax1,[S.MinFeretCoordinates(:,1)] , [mean(S.MinFeretCoordinates(:,2)) ; mean(S.MinFeretCoordinates(:,2))],'b','LineWidth',1) ;
plot(Ax1,[S.BoundingBox(1)+S.BoundingBox(3)/2 S.BoundingBox(1)+S.BoundingBox(3)/2] , [S.BoundingBox(2) S.BoundingBox(2)+S.BoundingBox(4)],'g','LineWidth',1)

rectangle(Ax1,'Position',S.BoundingBox,'EdgeColor','r','LineWidth',1)

view(Ax1,Alpha,90)
ElongationFactor = S.BoundingBox(3)/S.BoundingBox(4) 

Ti = title(Ax1,{'Elongation = \color{blue}^{S}\color{black}/\color{green}_{L}' ; ['\color{black}Elongation = ' num2str(ElongationFactor)]},'FontName','Times','FontAngle','italic','FontSize',16) ;
Ti.Units = 'normalized' ;
Ti.Position = Ti.Position + [0  -0.1  0] ;

% Show legend
legend({'Smallest possible dimension' , 'Length in \theta direction'}) ;








