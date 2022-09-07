function Para = CircleFitByKasa(XY) 
P = [XY ones(size(XY,1),1)] \ [XY(:,1).^2+XY(:,2).^2] ;
Para = [P(1)/2 , P(2)/2 , sqrt((P(1)^2+P(2)^2)/4 + P(3))] ;  
end