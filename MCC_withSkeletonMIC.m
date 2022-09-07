[Bound,~,~,~] = bwboundaries(bw) ;
%%
X = Bound{2,1}(:,2) ;
Y = Bound{2,1}(:,1) ;
% plot(Ax10,X,Y,'b','LineWidth',1.25) ;
%%
% bwsk = bwmorph(~bw,'skel',Inf) ;
% imshow(~bwsk == bw , 'Parent',Ax10)

bwth = bwmorph(~bw,'thin',Inf) ;
% imshow(~bwth == bw , 'Parent',Ax10)

%
filter = [1 1 1 ;
    1 0 1 ;
    1 1 1] ;
bwdisc1 = bwth & ~(bwth & conv2(double(bwth),filter,'same') > 1) ;
% figure ; imshow(bwdisc1)
bwdisc2 = bwth & ~(bwth & conv2(double(bwth),filter,'same') > 2) ;
% figure ; imshow(bwdisc2)

bwcc1 = bwconncomp(bwdisc1) ;
bwcc2 = bwconncomp(bwdisc2) ;

XC = [] ;
YC = [] ;

if bwcc2.NumObjects >= 2
    for j = 1:bwcc2.NumObjects
        LogicVar(j) = isempty(intersect(bwcc2.PixelIdxList{1,j},cell2mat(bwcc1.PixelIdxList(1,:)))) ;
    end
    if any(LogicVar) % more main branch
        indexi = find(LogicVar == true) ;
        for j = 1:length(indexi)
            [YCr,XCr] = ind2sub(size(bwdisc2),bwcc2.PixelIdxList{1,indexi(j)}) ;
            XC = [XC ; XCr] ;
            YC = [YC ; YCr] ;
        end
    else % one main branch
        for j = 1:bwcc2.NumObjects
            [YCr,XCr] = ind2sub(size(bwdisc2),bwcc2.PixelIdxList{1,indexi(j)}) ;
            XC = [XC ; XCr] ;
            YC = [YC ; YCr] ;
        end
    end
else
    [YC , XC] = ind2sub(size(bwdisc2),bwcc2.PixelIdxList{1,1}) ;
end

% plot(Ax10,XC,YC,'or')
%%
RMIC = nan(1,length(XC)) ;
XMIC = nan(1,length(XC)) ;
YMIC = nan(1,length(XC)) ;
EMIC = nan(1,length(XC)) ;

Tfactor = 0.96 ;
for k = 1:length(XC)
    N = 5 ; % Maximum Cluster
    M = 3 ; % Neigber
    while N>1
        r = 0 ;
        whileCond1 = true ;
        x = X ; y = Y ;
        %% Distance
        for i = 1:length(X)
            D(i,1) = pdist([XC(k) YC(k) ; x(i) y(i)]) ;
        end
        base_ind = find(D == max(D)) ;
        XX = [x(base_ind(1)+1:end) ; x(1:base_ind(1))] ;
        YY = [y(base_ind(1)+1:end) ; y(1:base_ind(1))] ;
        DD = [D(base_ind(1)+1:end) ; D(1:base_ind(1))] ;
        x = XX ; y = YY ; D = DD ;
        %% Optional
        [xData, yData] = prepareCurveData([],D) ;
        ft = fittype('smoothingspline') ;
        opts = fitoptions('Method','SmoothingSpline') ;
        opts.SmoothingParam = 0.9 ;
        [Fit,~] = fit(xData,yData,ft,opts) ;
        D = Fit(xData) ;
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
            disp([num2str((k/length(XC))*100,'%.2f') '%'])
            disp(k)
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
                    D(i,1) = pdist([XC(k) YC(k) ; x(i) y(i)]) ;
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
    end 
    
    w1 = 1 ; w2 = 3 ;
    Ne = normalize(w2*eMIC,'range') ;
    Nr = normalize(w1*rMIC,'range') ;
    Nc = normalize(Nr .*Ne,'range') ;
    MIC_index = find(Nc == max(Nc)) ; % best
    
    RrMIC(k) = rMIC(MIC_index(1)) ;
    EeMIC(k) = eMIC(MIC_index(1)) ;
    XxMIC(k) = xMIC(MIC_index(1)) ;
    YyMIC(k) = yMIC(MIC_index(1)) ;
end % Main Loop
w1 = 1 ; w2 = 3 ;
NE = normalize(w2*EeMIC,'range') ;
NR = normalize(w1*RrMIC,'range') ;
NC = normalize(NR .*NE,'range') ;
MIC_INDEX = find(NC == max(NC)) ; % best

RMIC = RrMIC(MIC_INDEX(1)) ;
EMIC = EeMIC(MIC_INDEX(1)) ;
XMIC = XxMIC(MIC_INDEX(1)) ;
YMIC = YyMIC(MIC_INDEX(1)) ;

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



