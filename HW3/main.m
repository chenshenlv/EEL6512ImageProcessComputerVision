I=imread('Noisy.pgm');
figure();
imshow(I)
[pading_image] = zero_padding('Noisy.pgm',9); %padding
[Box_filtered] = Box_filter(9,pading_image);%Box filter-average filter
[median_filtered] = Median(9,pading_image);%median filter
% figure()
% imshow(filtered_image);
