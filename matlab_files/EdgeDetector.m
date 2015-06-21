function EdgeDetector(Image, Params)

%transform to double to once and for all
Image = double(Image);

%differentiate Image to Ix and Iy

%Params.Filtertype = 'Sobel';

switch Params.Filtertype
    case 'Sobel'
        DX = imfilter([-1 0 1],[1 2 1]','full');
        DY = imfilter([1 2 1],[-1 0 1]','full');
    case 'Prewitt'
        DX = imfilter([-1 0 1],ones(3,1),'full');
        DY = imfilter([-1 0 1]',ones(1,3),'full');
    otherwise
        % Error with Filter
        
end

%apply the DX and DY filter
Ix = imfilter(Image, DX);
Iy = imfilter(Image, DY);


% determine Ix^2,Iy^2 and Ix*Iy
IxSquare = Ix.^2;
IySquare = Iy.^2;
Ixy = Ix.*Iy; 

%Build mean values
%Params.Sigma = 2;
vector = [[1:3*Params.Sigma] [(Params.Sigma*3-1):-1:1]];
gaussian = imfilter(vector,vector','full');
IxSquareMean = imfilter(IxSquare,gaussian);
IySquareMean = imfilter(IySquare,gaussian);
IxyMean = imfilter(Ixy,gaussian);

%Calculate Mc for every pixel
%Params.k=0.04;

MC = ((IxSquareMean.*IySquareMean)-IxyMean.^2)-Params.k.*((IxSquareMean+IySquareMean).^2);

%Eliminate false borderpixels

%Params.Border = 6;
%MC = uint8(MC);

MC(:,end-Params.Border+1:end)=0;
MC(:,1:Params.Border)=0;
MC(end-Params.Border+1:end,:)=0;
MC(1:Params.Border,:)=0;


%Extrema Filterpad

Pad = ones(2*Params.Border+1);

ImageMin =  ordfilt2(MC,1,Pad);
ImageMax =  ordfilt2(MC,numel(Pad),Pad);

%Check

LOCMax = MC.*(MC==ImageMax);

%Mark

%plot min values
x = unique(LOCMax)';
sorted = sort(x,'descend');

LOCMax = (LOCMax >= sorted(Params.nBest));


imshow(uint8(Image));
title('local maxima');


%plot max values
[Rows, Cols] = find(LOCMax);
for i1 = 1:length(Rows)
   BBox = [Cols(i1)-5 Rows(i1)-5 10 10]; 
   rectangle('Position', BBox, 'EdgeColor',[1 0 0]);
   
end




