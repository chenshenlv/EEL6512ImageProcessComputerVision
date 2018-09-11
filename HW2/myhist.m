function [ hist_norm,hist ] = myhist( image_name )
%hist_norm returns normalized histgram
%hist returns histgram
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
bar((0:1:255),hist_norm)
xlabel('Intensity level')
ylabel('Probability')
title('Normalized Histogram')
end

