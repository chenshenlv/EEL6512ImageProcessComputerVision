I=importdata('pic1.ppm');
imshow (I(:,:,:));
I_hsv=rgb2hsv(I);
%compute the histogram
n_h=imhist(uint8(round(I_hsv(:,:,1).*255)));
n_s=imhist(uint8(round(I_hsv(:,:,2).*255)));
n_v=imhist(uint8(round(I_hsv(:,:,3).*255)));
n=[n_h,n_s,n_v];
%sum up all histogram value
N=sum(n_h);
%compute histogram component probability:
for i=1:256
    p(i,:)=n(i,:)/N;
end
max=[0,0,0]; %initiate max
% Through all thresholding:
for k=2:255
    P1=sum(p(1:k,:),1);%compute class 1 probability
    P2=sum(p(k+1:256,:),1);%compute class 2 probability
    m1=((0:k-1)*p(1:k,:))./P1; %compute class1 mean
    m2=((k:255)*p(k+1:256,:))./P2; %compute class1 mean
    m=((0:k-1)*p(1:k,:));     %compute thresholding mean
    mG=(0:255)*p(1:256,:); %compute class1 mean
    sig_b=P1.*P2.*((m1-m2).^2); %compute variance between class
%     sig_b=(mG.*P1-m).^2./P1.*([1,1,1]-P1); %compute variance between class
    if sig_b(1,1)>=max(1,1)
        max(1,1)=sig_b(1,1);
        threshold_h=k-1;
    end
    if sig_b(1,2)>=max(1,2)
        max(1,2)=sig_b(1,2);
        threshold_s=k-1;
    end
    if sig_b(1,3)>=max(1,3)
        max(1,3)=sig_b(1,3);
        threshold_v=k-1;
    end
end
I_bw=false(size(I,1),size(I,2));
for row=1:size(I,1)
    for col=1:size(I,2)
        if  (I_hsv(row,col,1))>threshold_h/255 && ...
            (I_hsv(row,col,2))>threshold_s/255 && ...
            (I_hsv(row,col,3))>threshold_v/255              
                I_bw(row,col,:)=1;
         
        end
    end
end
SE1=strel('disk',9);
SE2=strel('disk',6);
opening=Openning(I_bw,SE1.Neighborhood);
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
                
            

    