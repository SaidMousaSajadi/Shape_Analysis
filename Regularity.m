Ax3 = axes ;
hold(Ax3,'on') ;
%% 
[~,Lab,~,~] = bwboundaries(BW) ;
bw = Lab == 1 ;

[Bound,Lab,~,~] = bwboundaries(bw) ;

%%
S = regionprops(~bw,'Perimeter','ConvexHull','ConvexImage') ; % Shape
s = regionprops(S.ConvexImage,'Perimeter') ; % Convex

%% Show
imshow(bw,'Parent',Ax3)
plot(Ax3,Bound{2,1}(:,2),Bound{2,1}(:,1),'b','LineWidth',1.25)
plot(Ax3,S.ConvexHull(:,1),S.ConvexHull(:,2),'r','LineWidth',1.25)

RegularityFactor = log(S.Perimeter/(S.Perimeter-s.Perimeter))
%%
Ti = title(Ax3,{['$Regularity = Ln(\frac{P}{P-P_{convex}})$'] , ['$Regularity = ' num2str(RegularityFactor) '$']},'Interpreter','latex','fontsize',16) ;
Ti.Units = 'normalized' ;
Ti.Position = Ti.Position + [0 -0.1 0] ;

Li = legend(Ax3,{['$P = $' num2str(S.Perimeter,'%4.2f')] ; ['$P_{convex} = $' num2str(s.Perimeter,'%4.2f')]},'Interpreter','latex','FontSize',11,'Location','northeastoutside') ;



