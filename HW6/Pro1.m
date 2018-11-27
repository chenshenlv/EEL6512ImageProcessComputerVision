I=importdata('img2.pgm');
imsize=size(I);
I=imgaussfilt(I,2);
imshow(I)
Eg=edge(I,'Canny');
imshow(Eg)
[rho,theta,Accumulator] = hough(Eg,10,1,7);
draw_lines( I,rho,theta )