clear 'all';
close 'all';

Path = '..\Images\img_';

%read image

Params = struct();
Params.Filtertype = 'Prewitt';%Sobel, Prewitt
Params.Sigma = 3;
Params.Border = 6;
Params.k = 0.04;
Params.nBest = 70;


Delta = 0;
%loop over required range, with step size Delta
for Index = Delta:1:3
    %read next image
    Params.Index=  Index;
    FileName = strcat(Path, sprintf('%04d', Index), '.jpg');
    Image = imread(FileName);
    
    %call the function
    EdgeDetector(Image,Params);
    
    pause(5);

end


