[Bound,~,~,~] = bwboundaries(bw) ;

X = Bound{2,1}(:,2) ;
Y = Bound{2,1}(:,1) ;

TFactor = 0.97 ;

NeighborPixel = [15 3] ;

for i = 1:length(XCON)
    NeighborP = NeighborPixel(1) ;
    while (NeighborP<=NeighborPixel(1) & NeighborP>=NeighborPixel(2))
        clc 
        disp([num2str((i/length(XCON))*100) '%'])
        disp(NeighborP)
        
        IND = find(X >= XCON(i)-NeighborP & X <= XCON(i)+NeighborP & Y >= YCON(i)-NeighborP & Y <= YCON(i)+NeighborP) ;
        
        CircleProp = CircleFitByLandau([X(IND),Y(IND)]) ;
        LCent(i) = CheckCenterInGrain(bw,CircleProp(1),CircleProp(2)) ;
        if LCent(i) == 1
            LCirc(i) = CheckCircleInGrain(bw,CircleProp(1),CircleProp(2),CircleProp(3),TFactor) ;
        end
        
        if (LCent(i) == 1 & LCirc(i) == 1)
            r(i) = CircleProp(3) ;
            xcent(i) = CircleProp(1) ;
            ycent(i) = CircleProp(2) ;
            break 
        end
        
        NeighborP = NeighborP-1 ;
    end % while inner loop
end % base loop 

MinPixel = 2 ; % Minimum acceptable radius
xcent(r<=MinPixel) = [] ;
ycent(r<=MinPixel) = [] ;
r(r<=MinPixel) = [] ;

