clear 'all';
close 'all';

%read image
%Image = imread('skeleton.png');
Image = [
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 1 1 1 1 1 0 0
0 0 1 1 1 1 1 0 0
0 0 1 1 1 1 1 0 0
0 0 1 1 1 0 0 0 0
0 0 1 1 1 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0];

%initialize the thinning
ImageIn = Image;
ImageOut = DoThinning(ImageIn);
figure(1);
imshow(ImageOut, []);
title('Hit Miss');

%start the recursion
while mean2(ImageIn ~= ImageOut) > 0 %we have a difference
    ImageIn = ImageOut;
    ImageOut = DoThinning(ImageIn);
    imshow(ImageOut, []);
    title('Hit Miss');  
    pause(1);
end

imwrite(ImageOut, 'own.png');
