function [ output_im ] = Openning( input_im,se )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
I=input_im;
erod=Erosion(I,se);
output_im=Dilation(erod,se);
% figure,imshow(output_im);
end

