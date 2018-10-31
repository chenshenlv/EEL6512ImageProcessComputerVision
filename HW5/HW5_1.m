I=importdata('pic1.ppm');
%Otsu the imge for image segmentation
bw=Otsu(I);
%define SE
SE1=strel('disk',11);
SE2=strel('disk',5);
% mophology the image to extract front
opening=Openning(bw,SE1.Neighborhood);
erod=Erosion(opening,SE2.Neighborhood);
figure,imshow(erod);
%Boundary Extraction
Boundary=opening-(erod);
figure,imshow(Boundary);
%Contour on original Image:
[r,c]=find(Boundary==1);
for i=1:size(r,1)
    I(r(i),c(i),:)=uint8([255,255,255]);
end
figure();
imshow (I);
