I=importdata('pic1.ppm');
% imshow (I(:,:,:));
% I_hsi=rgb2gray(I);

%compute the histogram
n_b=imhist(I(:,:,3));
%sum up all histogram value
N=sum(n_b);
%compute histogram component probability:
for i=1:256
    p(i)=n_b(i)/N;
end
max=0; %initiate max
% Through all thresholding:

for k=2:255
    P1=sum(p(1:k));%compute class 1 probability
    P2=sum(p(k+1:256)); %compute class 2 probability
    m1=((0:k-1)*p(1:k)')/P1; %compute class1 mean
    m2=((k:255)*p(k+1:256)')/P2; %compute class1 mean
    m=((0:k-1)*p(1:k)');     %compute thresholding mean
    mG=(0:255)*p(1:256)'; %compute class1 mean
    sig_b=P1*P2*((m1-m2)^2); %compute variance between class
    if sig_b>=max
        max=sig_b;
        threshold=k-1;
    end
    
end
bw=im2bw(I(:,:,3),threshold/255);
SE1=strel('disk',11);
SE2=strel('disk',5);
opening=Openning(bw,SE1.Neighborhood);
erod=Erosion(opening,SE2.Neighborhood);

figure,imshow(erod);
%Boundary Extraction
Boundary=opening-(Erosion(opening,SE2.Neighborhood));
figure,imshow(Boundary);
%Contour on original Image:
[r,c]=find(Boundary==1);
for i=1:size(r,1)
    I(r(i),c(i),:)=uint8([255,255,255]);
end
figure();
imshow (I);
