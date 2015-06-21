 
%perform thinning with various structuring elements
function [RetImage] = DoThinning(Image)




NumElem = 8;%define 8 structuring elements for thinning
StrucElem = zeros(3,3,NumElem);
%the main elements

SE1 = [-1 -1 -1; 0 1 0; 1 1 1];
SE2 = [1 0 -1; 1 1 -1; 1 0 -1];
SE3 = [-1 -1 0; -1 1 1; 0 1 0];
SE4 = [0 -1 -1 ; 1 1 -1; 0 1 0];
SE5 = [1 1 1;0 1 0; -1 -1 -1];
SE6 = [-1 0 1; -1 1 1; -1 0 1];
SE7 = [0 1 0; -1 1 1; -1 -1 0];
SE8 = [0 1 0; 1 1 -1; 0 -1 -1];



StrucElem(:,:,1) = SE1;
StrucElem(:,:,2) = SE2;
StrucElem(:,:,3) = SE3;
StrucElem(:,:,4) = SE4;
StrucElem(:,:,5) = SE5;
StrucElem(:,:,6) = SE6;
StrucElem(:,:,7) = SE7;
StrucElem(:,:,8) = SE8;
RetImage = Image > 0;
for Ind = 1:NumElem
    %apply hit miss operation
    HMImage = bwhitmiss(RetImage,StrucElem(:,:,Ind));
    % figure(5);
    % imshow(HMImage, [0 1]);
    %set the resuls of hit miss to 0
    RetImage(HMImage ~= 0) = 0;
    % figure(6);
    % imshow(RetImage, [0 1]);
end

end