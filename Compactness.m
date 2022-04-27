Ax4 = axes ; 
hold(Ax4,'on') ;
%% 
[~,Lab,~,~] = bwboundaries(BW) ;
bw = Lab == 1 ;
[Bound,~,~,~] = bwboundaries(bw) ;

%% 
S = regionprops(bw,'Perimeter','Area','Centroid') ;

imshow(bw,'Parent',Ax4)
h1 = plot(Ax4,S.Centroid(1),S.Centroid(2),'Marker','s','MarkerFaceColor','black','MarkerEdgeColor','none','MarkerSize',10,'LineStyle','none')
text(Ax4,S.Centroid(1),S.Centroid(2),'$\Omega$','Color','w','Interpreter','latex','FontSize',11) ;

h2 = plot(Ax4,Bound{2,1}(:,2),Bound{2,1}(:,1),'b','LineWidth',1.25) ;

CompactnessFactor = (S.Perimeter)^2/S.Area 

%%
Ti = title(Ax4,{['$Compactness = \frac{P^{2}}{Area}$'] ; ['$Compactness = $' num2str(CompactnessFactor)]},'Interpreter','latex','Fontsize',16) ;
Ti.Units = 'normalized' ;
Ti.Position = Ti.Position + [0 -0.1 0] ;

Li = legend(Ax4,[h1 ; h2],{['$Area(\Omega)=' num2str(S.Area) '$'],['$Perimeter=' num2str(S.Perimeter) '$']},'Interpreter','latex','Location','northeastoutside','FontSize',11) ;
