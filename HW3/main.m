I=imread('Noisy.pgm')
figure();
imshow(I)
[pading_image] = zero_padding('Noisy.pgm',3);
[Box_filtered] = Box_filter(3,pading_image);
[median_filtered] = Median(3,pading_image);
% figure()
% imshow(filtered_image);