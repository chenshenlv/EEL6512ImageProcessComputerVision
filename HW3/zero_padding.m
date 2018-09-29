function [pading_image] = zero_padding(input_image,filter_size)
% define the function does zero padding, filter_size is the size of filter
% will applied to the orginal image later, the Padding function will do the
% padding according the filter size.
I=input_image;
[row,col]=size(I);
%filter_size=size(filter);
pading_image=padarray(I,[(filter_size-1)/2,(filter_size-1)/2],'both');
figure();
imshow(pading_image);
title('Padding image')
end

