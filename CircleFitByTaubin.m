function Para = CircleFitByTaubin(XY)
n = size(XY,1) ;
centroid = mean(XY) ;

Mxx = 0 ; Myy = 0 ; Mzz = 0 ; Mxy = 0 ; Mxz = 0 ; Myz = 0 ;
for i = 1:n
    Xi = XY(i,1) - centroid(1) ;
    Yi = XY(i,2) - centroid(2) ;
    Zi = Xi^2 + Yi^2 ;
    Mxx = Mxx + Xi*Xi ;
    Mxy = Mxy + Xi*Yi ;
    Mxz = Mxz + Xi*Zi ;
    Myy = Myy + Yi*Yi ;
    Myz = Myz + Yi*Zi ;
    Mzz = Mzz + Zi*Zi ;
end
Mxx = Mxx/n ;
Myy = Myy/n ;
Mzz = Mzz/n ;
Mxy = Mxy/n ;
Mxz = Mxz/n ;
Myz = Myz/n ;

Mz = Mxx + Myy ;
Cov_xy = Mxx*Myy - Mxy*Mxy ;

A0 = Mxz*Mxz*Myy + Myz*Myz*Mxx - Mzz*Cov_xy - 2*Mxx*Myz*Mxy + Mz*Mz*Cov_xy ;
A1 = Mzz*Mz + 4*Cov_xy*Mz - Mxz*Mxz - Mz*Mz*Mz ;
A2 = -3*Mz*Mz - Mzz ;
A3 = 4*Mz ;

A22 = A2 + A2 ;
A33 = A3 + A3 + A3 ;

% Newton Iter.
IterMax = 20 ;
epsilon = 1e-12 ;
xnew = 0 ; % inital guess
ynew = 1e+20 ; % inital guess
for iter = 1:IterMax
    yold = ynew ;
    ynew = A0 + xnew*(A1 + xnew*(A2 + xnew*A3)) ;
    if abs(ynew) > abs(yold)
        fprintf(1,'wrong direction: |ynew| < |yold|\n') ;
        xnew = 0 ; % reset x
        break ;
    end
    Dy = A1 + xnew*(A22 + xnew*A33) ;
    xold = xnew ;
    xnew = xold - ynew/Dy ;
    % cond1
    if abs((xnew-xold)/xnew) < epsilon
        break
    end
    % cond2 
    if iter >= IterMax
        fprintf(1,'Not Converge\n') ;
        xnew = 0 ;
    end
    % cond3 
    if xnew < 0
        fprintf(1,'Negative root\n') ;
        xnew = 0 ;
    end
        
end % for
Det = xnew*xnew - xnew*Mz + Cov_xy ;
Center = [Mxz*(Myy-xnew)-Myz*Mxy , Myz*(Mxx-xnew)-Mxz*Mxy] / (Det/2) ;
Para = [Center + centroid , sqrt((Center*Center')+Mz)] ;

end % function