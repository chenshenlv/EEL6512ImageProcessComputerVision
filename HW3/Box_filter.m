function [filtered_image] = Box_filter(filter_size,input_image)
%define a square Box filter. filter_size is the size of filter, if a filter
%is 3X3 then the filter_size is 3. 
I=input_image;
m=filter_size;
filter=ones(m); %define filter element
[row,col]=size(I);
for i=1+(m-1)/2:row-(m-1)/2 %scan image row
    for j=1+(m-1)/2:col-(m-1)/2 %scan image column
        sum=0;
        for a=-(m-1)/2:(m-1)/2 %scan kernel row
            for b=-(m-1)/2:(m-1)/2 %scan kernel column
                sum=sum+(filter(a+(m+1)/2,b+(m+1)/2))*uint16(I(i+a,j+b)); %sum up all image pixel value under kernel
            end
        filtered_image(i-1,j-1)=round(sum/m.^2); %dived by coeff. as output value
        end
    end
end
figure()
imshow(uint8(filtered_image));            
title(['Box filter with ',num2str(filter_size),'x',num2str(filter_size),' kernel'])  
end

