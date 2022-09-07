% Need 3 points to fit
N = 3 ;
% Number of neighborhood
M = 3 ;

% Process
while true
    [K , ~] = kmeans([X,Y],N) ;
    C = {'*r' , '*b' , '*m'} ;
    for i = 1:N
        plot(Ax10,X(K==i),Y(K==i),C{i}) ;
    end
    MCCPoints = [] ;
    for i = 1:N
        ind = find(DMCC == max(DMCC(K == i))) ;
        MCPoints(i,:) = [X(ind(1)) Y(ind(1))] ;
        for j = 1:M
            Lside(j,:) = [X(ind(1)-j) Y(ind(1)-j)] ;
        end
        for j = 1:M
            Rside(j,:) = [X(ind(1)+j) Y(ind(1)+j)] ;
        end
        MCCPoints = [MCCPoints ; MCPoints ; Lside ; Rside] ;
    end % outer
    
    plot(Ax10,MCPoints(:,1),MCPoints(:,2),'*y')
    CentMCC = CircleFitByLandau(MCCPoints) ;
    XMCC = round(CentMCC(1)) ;
    YMCC = round(CentMCC(2)) ;
    RMCC = CentMCC(3) ;
%     plot(Ax10,XMCC,YMCC,'*y')
    LMCC = CheckCenterInGrain(bw,XMCC,YMCC) ;
%     LCMCC = CheckGrainInCircle(bw,XMCC,YMCC,RMCC,0.9) ; 
    
    if LMCC == true | N == 2 % (LMCC == true & LCMCC == true)
        break 
    else
        N = N-1 ;
    end
    
end % end of while