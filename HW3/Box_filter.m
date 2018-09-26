function [filtered_image] = Box_filter(filter_size,input_image)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
I=input_image;
m=filter_size;
filter=ones(m);
[row,col]=size(I)
for i=1+(m-1)/2:row-(m-1)/2
    for j=1+(m-1)/2:col-(m-1)/2
        sum=0;
        for a=-(m-1)/2:(m-1)/2
            for b=-(m-1)/2:(m-1)/2
                sum=sum+(filter(a+(m+1)/2,b+(m+1)/2))*uint16(I(i+a,j+b));
            end
        filtered_image(i-1,j-1)=round(sum/m.^2);
        end
    end
end
figure()
imshow(uint8(filtered_image));            
                
end

