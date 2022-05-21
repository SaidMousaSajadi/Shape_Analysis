Ax6 = axes ;
hold(Ax6,'on') ;
%% 
[~,Lab,~,~] = bwboundaries(BW) ;
bw = Lab==1 ;
[Bound,Lab,~,~] = bwboundaries(bw) ;

imshow(bw,'Parent',Ax6)
plot(Ax6,Bound{2,1}(:,2),Bound{2,1}(:,1),'b','LineWidth',1.25) ;

%% 
S = regionprops(~bw,'Eccentricity','MajoraxisLength','MinoraxisLength','Orientation','Centroid') ;

a = S.MajorAxisLength/2 ;
b = S.MinorAxisLength/2 ;
c = sqrt(a^2 - b^2) ;

%% Show 
Theta = 0:0.01:2*pi ;

% step 1st :
x = a * cos(Theta) ;
y = b * sin(Theta) ;
% step 2nd :
X = x*sind(90 + S.Orientation) + y*cosd(90 + S.Orientation) ;
Y = x*cosd(90 + S.Orientation) - y*sind(90 + S.Orientation) ;
% step 3th :
X = X + S.Centroid(1) ;
Y = Y + S.Centroid(2) ;

plot(Ax6,X,Y,'r','LineWidth',1.25) ;

%%
X1 = S.Centroid(1) + a*cosd(S.Orientation) ;
Y1 = S.Centroid(2) - a*sind(S.Orientation) ;
X2 = S.Centroid(1) - a*cosd(S.Orientation) ;
Y2 = S.Centroid(2) + a*sind(S.Orientation) ;

plot(Ax6,[X1 X2],[Y1 Y2],'g','LineWidth',0.25) ;


x1 = S.Centroid(1) + b*cosd(90+S.Orientation) ;
y1 = S.Centroid(2) - b*sind(90+S.Orientation) ;
x2 = S.Centroid(1) - b*cosd(90+S.Orientation) ;
y2 = S.Centroid(2) + b*sind(90+S.Orientation) ;

plot(Ax6,[x1 x2],[y1 y2],'m','LineWidth',0.25) ;

%% 
cx = S.Centroid(1) + c * cosd(S.Orientation) ;
cy = S.Centroid(2) - c * sind(S.Orientation) ;
plot(Ax6,[S.Centroid(1) cx] , [S.Centroid(2) cy],'g','LineWidth',2.25)

bx = S.Centroid(1) + b * cosd(90+S.Orientation) ;
by = S.Centroid(2) - b * sind(90+S.Orientation) ;
plot(Ax6,[S.Centroid(1) bx] , [S.Centroid(2) by],'m','LineWidth',2.25) 

plot(Ax6,[bx cx],[by cy],'c','LineWidth',2.25) 

EccentricityFactor = c/a 
%% 
Ti = title(Ax6,{'$Eccentricity = \frac{c}{a}$' ; ['$Eccentricity = ' num2str(EccentricityFactor) '$']},'interpreter','latex','fontsize',16) ;
Ti.Units = 'normalized' ;
Ti.Position = Ti.Position + [0 -0.1 0] ;

% legend(Ax6,{['$Outer Border$'];['$Major Axis$'];['$Minor Axis$'];['$c = $' num2str(c)];['$b = $' num2str(b)];['$a = $' num2str(a)]},'Interpreter','latex','FontSize',11,'Location','northeastoutside') ;



















