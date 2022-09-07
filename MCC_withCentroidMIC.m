S = regionprops(bw,'Centroid') ;
[Bound,~,~,~] = bwboundaries(bw) ;
%%
X = Bound{2,1}(:,2) ;
Y = Bound{2,1}(:,1) ;
% plot(Ax10,X,Y,'b','LineWidth',1.25) ;
%% Distance
for i = 1:length(X)
    D(i,1) = pdist([S.Centroid(1) S.Centroid(2) ; X(i) Y(i)]) ;
end
base_ind = find(D == max(D)) ;
XX = [X(base_ind(1)+1:end) ; X(1:base_ind(1))] ;
YY = [Y(base_ind(1)+1:end) ; Y(1:base_ind(1))] ;
DD = [D(base_ind(1)+1:end) ; D(1:base_ind(1))] ;
X = XX ; Y = YY ; D = DD ;
%% Optional
[xData, yData] = prepareCurveData([],D) ;
ft = fittype('smoothingspline') ;
opts = fitoptions('Method','SmoothingSpline') ;
opts.SmoothingParam = 0.9 ;
[Fit,~] = fit(xData,yData,ft,opts) ;
D = Fit(xData) ;
%% Main Algorithm
N = 5 ; % Maximum Cluster
M = 3 ; % Neigber
Tfactor = 0.94 ;

while N>1 
    r = 0 ;
    whileCond1 = true ;
    x = X ; y = Y ;
    while whileCond1
        [K,~] = kmeans([x,y],N) ;
        % Show
%         for i = 1:N
%             plot(Ax10,X(K==i),Y(K==i),'Marker','*','Color',rand(1,3),'LineStyle','none') ;
%             pause(0.1)        
%         end
        MICPoints = [] ;
        for i = 1:N
            indx = find(D == min(D(K == i))) ;
            MIPoints(i,:) = [x(indx(1)) y(indx(1))] ;
            for j = 1:M
                Lside(j,:) = [x(indx(1)-j) y(indx(1)-j)] ;
            end
            for j = 1:M
                Rside(j,:) = [x(indx(1)+j) y(indx(1)+j)] ;
            end
            % Show
%             MPoints = [MIPoints ; Lside ; Rside] ;
%             plot(Ax10,MPoints(:,1),MPoints(:,2),'*y') ;
            MICPoints = [MICPoints ; MIPoints ; Lside ; Rside] ;
        end
        CentMIC = CircleFitByLandau(MICPoints) ;
        r = r + 1 ;
        rmic(r) = CentMIC(3) ;
        xmic(r) = round(CentMIC(1)) ;
        ymic(r) = round(CentMIC(2)) ;
        
        clc
%         disp([num2str((((5-N)*r + r)/(5*15))*100,'%.2f') '%'])
        disp(N)
        disp(r)
        
        if ~isnan(rmic(r)) % Main Constraction
            LCentMIC(r) = CheckCenterInGrain(bw,xmic(r),ymic(r)) ;
            if LCentMIC(r) == true
                [LCircMIC(r) , emic(r)] = CheckCircleInGrain(bw,xmic(r),ymic(r),rmic(r),Tfactor) ;
            end
        else
            LCentMIC(r) = false ;
            LCircMIC(r) = false ;
            emic(r) = 0 ;
        end
        if r == 7 & all(emic < Tfactor)
            for i = 1:length(x)
                D(i,1) = pdist([S.Centroid(1) S.Centroid(2) ; X(i) Y(i)]) ;
            end
            base_ind = find(D == max(D)) ;
            XX = [x(base_ind(1)+1:end) ; x(1:base_ind(1))] ;
            YY = [y(base_ind(1)+1:end) ; y(1:base_ind(1))] ;
            DD = [D(base_ind(1)+1:end) ; D(1:base_ind(1))] ;
            x = XX ; y = YY ; D = DD ;
        end
        
        if r > 14
            whileCond1 = false ;
        end
    end % introier while
    All_rmic = rmic(LCircMIC) ;
    All_xmic = xmic(LCircMIC) ;
    All_ymic = ymic(LCircMIC) ;
    All_emic = emic(LCircMIC) ;
    if ~isempty(All_rmic)
        Nindex = find(max(All_rmic) == All_rmic) ;
        rMIC(N) = All_rmic(Nindex(1)) ;
        eMIC(N) = All_emic(Nindex(1)) ;
        xMIC(N) = All_xmic(Nindex(1)) ;
        yMIC(N) = All_ymic(Nindex(1)) ;
    else 
        rMIC(N) = nan ;
        xMIC(N) = nan ;
        yMIC(N) = nan ;
        eMIC(N) = nan ;
    end
    N = N-1 ;
end % Main Loop

%% 
w1 = 1 ; w2 = 3 ;
Ne = normalize(w2*eMIC,'range') ;
Nr = normalize(w1*rMIC,'range') ;
Nc = normalize(Nr .*Ne,'range') ;
MIC_index = find(Nc == max(Nc)) ; % best

RMIC = rMIC(MIC_index(1)) ;
EMIC = eMIC(MIC_index(1)) ;
XMIC = xMIC(MIC_index(1)) ;
YMIC = yMIC(MIC_index(1)) ;

%%
[Bound,Lab,~,~] = bwboundaries(bw) ;
bw = Lab == 1 ;

X = Bound{2,:}(:,2) ;
Y = Bound{2,:}(:,1) ;

S = regionprops(~bw,'Centroid') ;
for i = 1:length(X)
    DMCC(i,1) = pdist([XMIC YMIC ; X(i) Y(i)]) ;
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



