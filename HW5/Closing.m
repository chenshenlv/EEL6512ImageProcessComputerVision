function [ output_im ] = Closing( input_im,se )
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
I=input_im;
Dil=Dilation(I,se);
output_im=Erosion(Dil,se);
figure,imshow(output_im);

end

