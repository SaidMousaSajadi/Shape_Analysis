[Bound,Lab,~,~] = bwboundaries(bw) ;
bw = Lab == 1 ;

X = Bound{2,:}(:,2) ;
Y = Bound{2,:}(:,1) ;

% plot(Ax10,X,Y,'b')
%%
S = regionprops(~bw,'Centroid') ;
for i = 1:length(X)
    DMCC(i,1) = pdist([S(1).Centroid(1) S(1).Centroid(2) ; X(i) Y(i)]) ;
end

% Smooth
[xData , yData] = prepareCurveData([],DMCC) ;
ft = fittype('smoothingspline') ;
opts = fitoptions('Method','SmoothingSpline') ;
opts.SmoothingParam = 0.9 ;
[Fit,~] = fit(xData,yData,ft,opts) ;
DMCC = Fit(xData) ;

% relocate
base_ind = find(DMCC == min(DMCC)) ;
XX = [X(base_ind(1)+1:end) ; X(1:base_ind(1))] ;
YY = [Y(base_ind(1)+1:end) ; Y(1:base_ind(1))] ;
DD = [DMCC(base_ind(1)+1:end) ; DMCC(1:base_ind(1))] ;
X = XX ; Y = YY ; DMCC = DD ;






