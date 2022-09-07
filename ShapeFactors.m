Ax13 = axes ;
hold(Ax13,'on') ;

[~,Lab,~,~] = bwboundaries(BW) ;

bw = Lab==1 ;
imshow(bw,'Parent',Ax13) ;

[Bound,~,~,~] = bwboundaries(bw) ;

X = Bound{2,1}(:,2) ;
Y = Bound{2,1}(:,1) ;

Coord = [X' ; Y'] ;
DistMatrix = squareform(pdist(Coord')) ;

while true
    [rD , cD] = find(max(DistMatrix(:)) == DistMatrix) ;
    [Index , ~ , ~ , ~] = BinaryLine(bw,[X(rD(1)) X(cD(1))] , [Y(rD(1)) Y(cD(1))]) ;
    
    QualityFraction = nnz(~bw(Index))/length(Index) ;
    
    if QualityFraction >= 0.98
        L = DistMatrix(rD(1),cD(1)) ;
        break
    else
        DistMatrix(rD(1),cD(1)) = 0 ;
    end
end

plot(Ax13,[X(rD(1)) X(cD(1))] , [Y(rD(1)) Y(cD(1))],'r')

%%
% bl = bw ; bl(Index) = true ; figure ; imshow(bl)

% figure ; imshow(Binary)

% plot(Ax13, c , r ,'*b')
%%
S = regionprops(~bw,'Centroid','Perimeter','Area') ;

ShapeFactor1 = (4*pi*S.Area) / (S.Perimeter^2) 

ShapeFactor1 = (4*S.Area) / (pi*(L^2)) 






