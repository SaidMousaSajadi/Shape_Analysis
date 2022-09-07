function varargout = BinaryLine(bw,x,y) 
base = zeros(size(bw)) ;

eval(['f = @(x) ' num2str(diff(y)/diff(x)) ' * (x - ' num2str(x(1)) ') + ' num2str(y(1)) ';'])

c = [x(1):x(end)] ;
r = round(f(c)) ;

varargout{1} = sub2ind(size(bw),r,c) ; % main output
base(varargout{1}) = true ;
varargout{2} = ~base ;
varargout{3} = r ;
varargout{4} = c ;

end