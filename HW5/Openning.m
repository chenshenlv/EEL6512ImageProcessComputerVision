function [ output_im ] = Openning( input_im,se )
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
I=input_im;
erod=Erosion(I,se);
output_im=Dilation(erod,se);
% figure,imshow(output_im);
end

