function [pading_image] = zero_padding(filename,filter_size)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
I=imread(filename);
[row,col]=size(I);
%filter_size=size(filter);
pading_image=padarray(I,[(filter_size-1)/2,(filter_size-1)/2],'both');
figure();
imshow(pading_image);
end

