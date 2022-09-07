function Out = cornerMyMethod(bw)
[Bound,~,~,~] = bwboundaries(bw) ;
if length(Bound) == 2
    Y = Bound{2,1}(:,2) ;
    X = Bound{2,1}(:,1) ;
    
    S = regionprops(bw) ;
    
    for i = 1:length(X)
        D(i,1) = pdist([S(1).Centroid(1) S(1).Centroid(2) ; X(i) Y(i)]) ;
    end
    
    
    [xData, yData] = prepareCurveData( [], D );
    ft = fittype( 'smoothingspline' );
    opts = fitoptions( 'Method', 'SmoothingSpline' );
    opts.SmoothingParam = 0.5;
    [Fit, ~] = fit(xData,yData,ft,opts);
    D = Fit(xData) ;
    
    base_ind = find(D==min(D)) ;
    XX = [X(base_ind(1)+1:end) ; X(1:base_ind(1))] ;
    YY = [Y(base_ind(1)+1:end) ; Y(1:base_ind(1))] ;
    DD = [D(base_ind(1)+1:end) ; D(1:base_ind(1))] ;
    X = XX ; Y = YY ; D = DD ;
    
    [P,Loc] = findpeaks(D,'MinPeakDistance',15,'MinPeakHeight',60,'MinPeakProminence',0.25,'MinPeakWidth',1) ;
%     figure ; AxD = axes ; plot(D) ; text(Loc,P,'max') ; hold on ;
%     plot(Ax12,Y(Loc),X(Loc),'*y') ;
   
    dD = [0 ; diff(D)] ; % 1st order
    d2D = [0 ; diff(dD)] ; % 2st order
    
    [xData, yData] = prepareCurveData( [], d2D );
    ft = fittype( 'smoothingspline' );
    opts = fitoptions( 'Method', 'SmoothingSpline' );
    opts.SmoothingParam = 0.2;
    [Fit, ~] = fit(xData,yData,ft,opts);
    d2D = Fit(xData) ;
    
    [~,dLoc] = findpeaks(d2D,'MinPeakDistance',1,'MinPeakHeight',min(d2D),'MinPeakProminence',0.00125,'MinPeakWidth',0.01) ;
    d_Loc = find((d2D < 0.015 & d2D > -0.015) == 1) ;
    DLoc = intersect(dLoc , d_Loc) ;

%     figure ; plot(d2D) ; text(DLoc,d2D(DLoc),'max') ;
%     plot(AxD,DLoc,D(DLoc),'ro','MarkerEdgeColor','none','MarkerFaceColor','r') ;
%     plot(Ax12,Y(DLoc),X(DLoc),'*r') ;
    
    LOC = unique([Loc ; DLoc]) ;
    XCON = Y(LOC) ;
    YCON = X(LOC) ;
    
    Out = [XCON , YCON] ;    
    
end % end of process