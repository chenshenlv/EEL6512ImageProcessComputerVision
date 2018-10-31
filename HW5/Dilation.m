function [ output_im ] = Dilation( input_im,se )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
halfwidth=floor(0.5*size(se,1));
I_pad=padarray(input_im,[halfwidth halfwidth],'both');
D=false(size(input_im));
for row=halfwidth+1:size(I_pad,1)-halfwidth
    for col=halfwidth+1:size(I_pad,2)-halfwidth
        D(row-halfwidth,col-halfwidth)=sum(sum(se&I_pad(row-halfwidth:row+halfwidth,col-halfwidth:col+halfwidth)));
        
    end
end
% figure,imshow(D);
output_im=D;

end

