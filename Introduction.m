clear all ; clc ; close all

%% import image png
[IM , M] = imread('Shape10.png') ;
IM = imresize(IM,[300 NaN]) ; % for decrease compute process
G = rgb2gray(IM) ; % rgb to grayscale image
BW = imbinarize(G) ; % grayscale image to binary image
BW = imerode(BW,strel('disk',1)) ; % Improve Binary image
%% Public Figure
% F = figure('Color','w') ;
%% Main Algorithm
% run('Elongation')
% run('Convexity')
% run('Regularity')
% run('Compactness')
% run('Solidity')
% run('Eccentricity')
% run('EllipticSmoothness') 
% run('AspectRatio')
% run('Angularity') % Maximum Inscribed Circle(MIC)
% run('Sphercity') % Minimum Circumscribed Circle(MCC)
% run('Circularity')
% run('Roundness')
% run('ShapeFactors')




