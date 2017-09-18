%% Tymothy Anderson
% CEC 495a Assignment 02
% Tracking multiple differently-colored balls

clear all; clc; clf;
StartingFrame = 1;
EndingFrame = 489;

Xcentroid = [ ];
Ycentroid = [ ];

GXcentroid = [ ];
GYcentroid = [ ];

for k = StartingFrame : EndingFrame-1
    % Load and convert sequential test images
    pos1 = imread(['balls/img',sprintf('%2.3d',k),'.jpg']);
    pos1Orig = imread(['balls/img',sprintf('%2.3d',k),'.jpg']);
    
    [BW,masked] = bigBlueBallMask(pos1);
    [BWGrn,maskedGrn] = bigGreenBallMask(pos1);
    
    % Morphology to reduce noise
    
    SE = strel('disk',5,0);
    
    Iopen = imopen(BW,SE);
    IopenGrn = imopen(BWGrn,SE);
    
    SE = strel('disk',5,0);
    
    BW = imclose(BW,SE);
    BWGrn = imclose(BWGrn,SE);
        
    imshow(pos1Orig);

    % Count and label objects
    
    [labels,number] = bwlabel(BW,8);
    [GrnLabels,GrnNumber] = bwlabel(BWGrn,8);

    
     if number > 0
        % Extract Stats
        Istats = regionprops(labels,'basic','Centroid');
        [maxVal, maxIndex] = max([Istats.Area]);

        % Plot Centroid
        hold on;
        plot(Istats(maxIndex).Centroid(1), Istats(maxIndex).Centroid(2),'r*');
        
        
        Xcentroid = [Xcentroid Istats(maxIndex).Centroid(1)];
        Ycentroid = [Ycentroid Istats(maxIndex).Centroid(2)];
        
        
        
        plot(Xcentroid,Ycentroid,'bo');
        
     end
     
      if GrnNumber > 0
        % Extract Stats
        Istats = regionprops(GrnLabels,'basic','Centroid');
        [maxVal, maxIndex] = max([Istats.Area]);

        % Plot Centroid
        
        plot(Istats(maxIndex).Centroid(1), Istats(maxIndex).Centroid(2),'r*');
            
        GXcentroid = [GXcentroid Istats(maxIndex).Centroid(1)];
        GYcentroid = [GYcentroid Istats(maxIndex).Centroid(2)];
        

        plot(GXcentroid,GYcentroid,'go');
        
     end
    pause(0.0001);
end