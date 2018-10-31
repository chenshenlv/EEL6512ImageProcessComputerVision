function [ output_im ] = Erosion( input_im,se )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
halfwidth=floor(0.5*size(se,1));
I_pad=padarray(input_im,[halfwidth halfwidth],'both');
%Intialize the matrix D of size A with zeros
D=false(size(input_im));
for row=halfwidth+1:size(I_pad,1)-halfwidth
    for col=halfwidth+1:size(I_pad,2)-halfwidth
        L=I_pad(row-halfwidth:row+halfwidth,col-halfwidth:col+halfwidth);
%Find the position of ones in the structuring element
        K=find(se==1);
       if(L(K)==1)
        D(row-halfwidth,col-halfwidth)=1;
        end
    end
end

% figure,imshow(D);
output_im=D;
end

