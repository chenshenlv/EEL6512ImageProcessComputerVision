function [ histeq_norm ] = myhisteq( image_name )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
%% Generate normalized histgram
p1=imread(image_name);
hist=zeros(256,1);%creat a vector to store histgram
for i=1:size(p1,1)
    for j=1:size(p1,2)
        for inten_val=0:255
            if p1(i,j)==inten_val
                hist(inten_val)=hist(inten_val)+1;
                break
            end
        end
    end
end 
figure();
hist_norm=hist/(size(p1,1)*size(p1,2));
bar(1:1:256,hist_norm,0.4)
xlabel('Intensity level')
ylabel('Probability')
title('Normalized Histogram')
%% Generate normalized equalized histgram
histeq_temp=zeros(size(hist_norm,1),1);
histeq=zeros(size(hist_norm,1),1);
temp=0;
for i=1:size(histeq_temp,1) %computer the transform function
    temp=temp+hist_norm(i);
    histeq_temp(i)=(size(histeq_temp,1)-1)*temp;
end

for i=1:size(histeq_temp,1) %round the transform function 
    histeq_temp(i)=round(histeq_temp(i));
end

histeq_temp=[histeq_temp;histeq_temp(size(histeq_temp,1))+1];
temparr=zeros(size(hist_norm,1),1);

for i=2:size(histeq_temp,1) %computer equalized histgram
    if histeq_temp(i-1)==histeq_temp(i)
        temparr(i-1)=hist(i-1);
        temparr(i)=hist(i);
    end
    if  histeq_temp(i-1)~= histeq_temp(i) 
         histeq(histeq_temp(i-1)+1)=sum(temparr);
         temparr=0*temparr;
    end
end
for i=2:size(histeq_temp,1)-1 %computer equalized histgram
    if histeq_temp(i-1)~= histeq_temp(i) && histeq_temp(i)~= histeq_temp(i+1)
        histeq(histeq_temp(i)+1)=hist(i);
    end
end

histeq_norm=histeq/(size(p1,1)*size(p1,2));
figure();
bar(1:1:256,histeq_norm)
xlabel('sk')
ylabel('Probability of sk')
title('Normalized Equalized Histogram')



