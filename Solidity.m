Ax5 = axes ;
hold(Ax5,'on') ;
%% 
[~,Lab,~,~] = bwboundaries(BW) ;
bw = Lab == 1 ;
[Bound,Lab,~,~] = bwboundaries(bw) ;

%% 
S = regionprops(~bw,'Area','ConvexArea','ConvexHull','Solidity') ;
h1 = patch(Ax5,S.ConvexHull(:,1),S.ConvexHull(:,2),'r','EdgeColor','r') ;
h2 = patch(Ax5,Bound{2,1}(:,2),Bound{2,1}(:,1),'k') ;

Ax5.YDir = 'reverse' ;
Ax5.XColor = 'none' ;
Ax5.YColor = 'none' ;
axis(Ax5,'equal') ;
axis(Ax5,[1 size(bw,2) 1 size(bw,1)])

SolidityFactor = S.Area/S.ConvexArea
FullnessFactor = sqrt(S.Area/S.ConvexArea)

%%
Ti = title(Ax5,{['$Solidity = \frac{Area}{Area_{Convex}} , Fullness = \sqrt\frac{Area}{Area_{Convex}}$'] ; ['$Solidity = ' num2str(SolidityFactor) ' , Fullness = ' num2str(FullnessFactor) '$']},'interpreter','latex','fontsize',17) ;
Ti.Units = 'normalized' ;
Ti.Position = Ti.Position + [0 -0.1 0] ;

Li = legend(Ax5,[h1 ; h2],{['$Area_{Convex} = $' num2str(S.ConvexArea,'%4.2f')] ; ['$Area = $' num2str(S.Area,'%4.2f')]},'Interpreter','latex','FontSize',11,'Location','northeastoutside') ;

