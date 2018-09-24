function [median_filtered] = Median(filter_size,input_image)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
I=input_image;
m=filter_size;
[row,col]=size(I);
for i=1+(m-1)/2:row-(m-1)/2
    for j=1+(m-1)/2:col-(m-1)/2
        pixel_array=[];
        for a=-(m-1)/2:(m-1)/2
            for b=-(m-1)/2:(m-1)/2
                pixel_array=[pixel_array,I(i+a,j+b)];
            end
        pixel_array=sort(pixel_array);
        median_filtered(i-1,j-1)=pixel_array((m+1)/2);
        end
    end
end
figure()
imshow(uint8(median_filtered));       end

