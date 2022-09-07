Ax7 = axes ;;
hold(Ax7,'on') ;
%% 
[~,Lab,~,~] = bwboundaries(BW) ;
bw = Lab == 1 ;
[Bound,Lab,~,~] = bwboundaries(bw) ;

imshow(bw,'Parent',Ax7) ;
plot(Ax7,Bound{2,1}(:,2),Bound{2,1}(:,1),'b','LineWidth',1.25) ;
%% 
S = regionprops(~bw,'Perimeter','MajoraxisLength','MinoraxisLength','Orientation','Centroid') ;

a = S.MajorAxisLength/2 ;
b = S.MinorAxisLength/2 ;

%% Show
Theta = 0:0.01:2*pi ;

x = a * cos(Theta) ;
y = b * sin(Theta) ;

X = x * sind(90 + S.Orientation) + y * cosd(90 + S.Orientation) ;
Y = x * cosd(90 + S.Orientation) - y * sind(90 + S.Orientation) ;

X = X + S.Centroid(1) ;
Y = Y + S.Centroid(2) ;

plot(Ax7,X,Y,'r','LineWidth',1.25)

%% 
PE = pi*(a+b)*(3*(((a-b)^2)/(((a+b)^2)*(sqrt(((-3*((a-b)^2))/((a+b)^2))+4)+10)))+1) ;

EllipticSmoothnessFactor = S.Perimeter / PE 

%% 
Ti = title(Ax7,{'$Elliptic Smoothness = \frac{P}{P_{Ellipse}}$';['$Elliptic Smoothness = ' num2str(EllipticSmoothnessFactor) '$']},'interpreter','latex','fontsize',16) ;
Ti.Units = 'normalized' ;
Ti.Position = Ti.Position + [0 -0.1 0] ;

legend(Ax7,{['$P = $' num2str(S.Perimeter)] ; ['$P_{ellipse} = $' num2str(PE)]},'Interpreter','latex','FontSize',11,'Location','northeastoutside') ;





