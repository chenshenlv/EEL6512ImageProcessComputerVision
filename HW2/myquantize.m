function [quant_output] = myquantize(image_name,quant_num)
%UNTITLED2 Quantilized the image with the scale value quant_num
%
quan_lev=8;
p1=imread(image_name);
row=size(p1,1);
col=size(p1,2);
quant_output=zeros(row,col);
%% Quantilize image
% a) scan every pixel in original image 
% b) group every pixel into the grayscale group;eg when quant_num=8;
% i(x,y)=30, then i(x,y) should be group 1; 
% c) The quantilized gray intensity of each pixel is the pixel's grayscale group
% number multiply the maximmun gray intensity of it's group. e.g. apply
% example in b) the quantilized gray intensity is group number(1)*32, as we
% have 8 gray scale, each 32 gray intensity makes up on group.
for i=1:row 
    for j=1:col
        quant_output(i,j)=round(p1(i,j)/(256/quant_num))*(256/quant_num);
    end 
end
quant_output=uint8(quant_output);
%% display quantilized image
figure();
imshow(quant_output)
title([image_name,' gray level ',num2str(quant_num)])
end

