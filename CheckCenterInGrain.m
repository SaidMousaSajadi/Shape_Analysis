function L = CheckCenterInGrain(bw,xc,yc)
    if any(~isnan([xc yc]))
        xc = round(xc) ;
        yc = round(yc) ;
        try
            if bw(xc,yc) == 0
                L = true ;
            else
                L = false ;
            end
        catch
            L = false ;
        end
    else
        L = false ;
    end
end % function