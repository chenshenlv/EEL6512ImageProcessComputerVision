input_image=imread('Noisy.pgm');
figure();
imshow(input_image); %display the input image
[pading_image] = zero_padding(input_image,3); %padding
[Box_filtered] = Box_filter(3,pading_image);%Box filter-average filter
[median_filtered] = Median(3,pading_image);%median filter

