Ax8 = axes ;
hold(Ax8,'on') ;
%%
[~,Lab,~,~] = bwboundaries(BW) ;
bw = Lab == 1 ;
[Bound,~,~,~] = bwboundaries(bw) ;

imshow(bw,'Parent',Ax8) ;

X = Bound{2,1}(:,2) ;
Y = Bound{2,1}(:,1) ;

plot(Ax8,X,Y,'b','LineWidth',1.25) ;

%%
S = regionprops(~bw,'MajoraxisLength','MinoraxisLength','Orientation','Centroid','MaxFeretProperties','MinFeretProperties') ;

%% Method
Coord = [X' ; Y'] ;
DistMatrix = squareform(pdist(Coord')) ;
[r,c] = find(DistMatrix == max(DistMatrix(:))) ;
r_index = r(1) ;
c_index = c(1) ;
% Major 
Loc_major = [r_index c_index] ;
plot(Ax8,[X(Loc_major(1)) X(Loc_major(2))] , [Y(Loc_major(1)) Y(Loc_major(2))],'g','LineWidth',1.25)

Major = sqrt((X(Loc_major(1))-X(Loc_major(2)))^2 + (Y(Loc_major(1))-Y(Loc_major(2)))^2) ;
% Major = DistMatrix(r(1),r(2)) ;

%%
Minor_slope = -1 / ((Y(r_index)-Y(c_index))/(X(r_index)-X(c_index))) ;

Xcent = mean([X(r_index) X(c_index)]) ;
Ycent = mean([Y(r_index) Y(c_index)]) ;

% plot(Ax8,Xcent,Ycent,'*r')

f_minor = @(x) (Minor_slope*(x-Xcent) + Ycent) ; 
x_minor = X ;
y_minor = f_minor(x_minor) ;

D_minor = abs(Y-y_minor) ;
D = max(D_minor)-D_minor ;
[Peak , Loc_minor] = findpeaks(D,'MinPeakDistance',10,'MinPeakHeight',max(D)-1,'MinPeakProminence',1,'MinPeakWidth',5) ;


% plot(Ax8,X(55),Y(55),'*r')
% plot(Ax8,X(358),Y(358),'*r')

plot(Ax8,[X(Loc_minor(1)) X(Loc_minor(2))],[Y(Loc_minor(1)) Y(Loc_minor(2))],'m','LineWidth',1.25) ;
    
Minor = sqrt((X(Loc_minor(1))-X(Loc_minor(2)))^2 + (Y(Loc_minor(1))-Y(Loc_minor(2)))^2) ;


AspectRatioFactor = Minor/Major ;
%%
T1 = title(Ax8,{['$Aspect Ratio = \frac{Diameter_{Minor}}{Diameter_{Major}}$' ],['$Aspect Ratio = ' num2str(AspectRatioFactor) '$']},'interpreter','latex','fontsize',16) ;

T1.Units = 'normalized' ;
T1.Position = T1.Position + [0 -0.1 0] ;








