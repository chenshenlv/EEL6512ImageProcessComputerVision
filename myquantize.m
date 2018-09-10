function [quant_output] = myquantize(image_name,quant_num)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
p1=imread(image_name)
figure();
imshow(image_name);
row=size(p1,1);
col=size(p1,2);

quant_output=zeros(row,col);

for i=1:row
    for j=1:col
        quant_output(i,j)=mod(p1(i,j),quant_num);
    end 
end
I= mat2gray(quant_output);
figure();
%q=imread(quant_output);
imshow(I)

end

