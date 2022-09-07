function varargout = CheckCircleInGrain(bw,xc,yc,r,ThresholdFactor)
[Bound,~,~,~] = bwboundaries(bw) ;
x = Bound{2,1}(:,2) ;
y = Bound{2,1}(:,1) ;

Factor = nnz(r < sqrt((x-xc).^2 + (y-yc).^2))/length(x) ;

varargout{1} = false ;
varargout{2} = Factor ;
if Factor >= ThresholdFactor
    varargout{1} = true ;
end

end % function