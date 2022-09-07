if length(XCON) <= 50
    Range = [1:length(XCON)] ;
else
    Range = [1:round(length(XCON)/2)] ;
end

myfunc = @(X,K) kmeans(X,K,'EmptyAction','singleton','Replicates',5) ;
eva = evalclusters(out,myfunc,'gap','klist',Range,'Distance','sqEuclidean') ;
K = eva.OptimalK ;
IND = kmeans(out,K) ;

%% 
% for i = 1:K
%     plot(Ax12,XCON(IND==i),YCON(IND==i),'*','Color',rand(1,3)) ;
% end
%% 
for i = 1:K
    Dist = squareform(pdist([mean(XCON(IND==i)) , mean(YCON(IND==i)) ; XCON(IND==i) YCON(IND==i)])) ;
    subindex = find(min(Dist(2:end,1)) == Dist(2:end,1)) ;
    XClust = XCON(IND == i) ; YClust = YCON(IND == i) ;
    xcon(i) = XClust(subindex(1)) ;
    ycon(i) = YClust(subindex(1)) ;
    plot(Ax12,xcon(i),ycon(i),'MarkerFaceColor',rand(1,3),'Marker','o','MarkerEdgeColor','none') ;
end

XCON = xcon' ;
YCON = ycon' ;





