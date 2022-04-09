Ax2 = axes ;
hold(Ax2,'on')
%% find boundary
[~,Lab,~,~] = bwboundaries(BW) ; % 3 Lable
Bw = Lab == 1 ;

[Bound,Lab,~,~] = bwboundaries(Bw) ; % 2 Lable

imshow(Bw,'Parent',Ax2)
plot(Ax2,Bound{2,1}(:,2),Bound{2,1}(:,1),'b','LineWidth',1.25)

%%
S = regionprops(~Bw,'Perimeter','ConvexHull','ConvexImage') ;
s = regionprops(S.ConvexImage,'Perimeter') ;

plot(Ax2,S.ConvexHull(:,1),S.ConvexHull(:,2),'r','LineWidth',1.25)

ConvexityFactor = s.Perimeter / S.Perimeter

Ti = title(Ax2,{'Convexity = \color{red}^{P_{convex}} \color{black}/ \color{blue}_{P}' ; ['\color{black}Convexity = ' num2str(ConvexityFactor)]},'Interpreter','tex','FontName','Times','FontSize',16) ;
Ti.Units = 'normalized' ;
Ti.Position = Ti.Position + [0 -0.1 0] ;

legend(Ax2,{['P{      } = ' num2str(S.Perimeter)] ; ['P_{convex} = ' num2str(s.Perimeter)]} , 'Interpreter', 'tex','Location','northeastoutside','FontName','Times','FontSize',12)





