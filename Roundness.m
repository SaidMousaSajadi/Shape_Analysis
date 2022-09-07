Ax12 = axes ;
hold(Ax12,'on')
[~,Lab,~,~] = bwboundaries(BW) ;
bw = Lab == 1 ;
imshow(bw,'Parent',Ax12)

%%

% out = corner(bw,'QualityLevel',0.1) ;

% Corner_2D = cornermetric(bw) ;
% Corner_Loc = imregionalmax(Corner_2D) ;
% [A B] = find(Corner_Loc == true) ;
% out(:,2) = A ; out(:,1) = B ;

% Out = detectHarrisFeatures(bw,'MinQuality',0.37) ;
% out = double(Out.Location) ;

% Out = detectMinEigenFeatures(bw,'MinQuality',0.37) ;
% out = double(Out.Location) ;

out = cornerMyMethod(bw) ;

XCON = out(:,1) ;
YCON = out(:,2) ;
plot(Ax12,XCON,YCON,'*b')
%% With Clustering
% run('With_Clustering_Roundness')
%% Without Clustering
run('Without_Clustering_Roundness')
%% Show 
Theta = 0:0.01:2*pi ;
for i = 1:length(r)
    xcirc = xcent(i) + r(i)*cos(Theta) ;
    ycirc = ycent(i) + r(i)*sin(Theta) ;
    plot(Ax12,xcirc,ycirc,'g','LineWidth',1.5) ;
end
%% MIC - 2Tip
run('MIC_withCentroid')
% run('MIC_withSkeleton')
%% Show 
Theta = 0:0.01:2*pi ;
xcircMIC = XMIC + RMIC*cos(Theta) ;
ycircMIC = YMIC + RMIC*sin(Theta) ;
plot(Ax12,xcircMIC,ycircMIC,'b','LineWidth',2) ;

%% Result
RoundnessFactor = sum(r)/(length(r)*RMIC)

