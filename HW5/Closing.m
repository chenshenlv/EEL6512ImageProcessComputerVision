function [ output_im ] = Closing( input_im,se )
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明
I=input_im;
Dil=Dilation(I,se);
output_im=Erosion(Dil,se);
figure,imshow(output_im);

end

