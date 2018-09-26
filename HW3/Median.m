function [median_filtered] = Median(filter_size,input_image)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
I=input_image;
m=filter_size; %filter size
[row,col]=size(I);
for i=1+(m-1)/2:row-(m-1)/2 %scan image row
    for j=1+(m-1)/2:col-(m-1)/2 %scan image column
        pixel_array=[];
        for a=-(m-1)/2:(m-1)/2 %scan kernel row
            for b=-(m-1)/2:(m-1)/2 %scan kernel column
                pixel_array=[pixel_array,I(i+a,j+b)]; %store pixel value
            end
        pixel_array=sort(pixel_array); %store the pixel value
        median_filtered(i-1,j-1)=pixel_array((m+1)/2); %pick the median value as target value
        end
    end
end
figure()
imshow(uint8(median_filtered));       
end

