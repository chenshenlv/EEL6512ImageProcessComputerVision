function [output_image] = Otsu(input_image)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
I=input_image;
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
%threshold the pic and turn into binary image
bw=im2bw(I(:,:,3),threshold/255);
output_image=bw;
end

