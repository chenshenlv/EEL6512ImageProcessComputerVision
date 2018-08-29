% %display odd channel
% storedStructure_odd = load('odd_channel.mat');
% imageArray_odd = storedStructure_odd.odd_channel;
% figure(1);
% imshow(imageArray_odd, []);
% %display even channel
% storedStructure_even = load('even_corrupted_channel.mat');
% imageArray_even = storedStructure_even.even_corrupted_channel;
% figure(2);
% imshow(imageArray_even, []);
% 
% %correct the even channel
% avg=sum(storedStructure_odd.odd_channel,2)/size(storedStructure_odd.odd_channel,2);
% storedStructure_even.even_correct_channel=storedStructure_even.even_corrupted_channel(:,1:end)+avg;
% figure(3);
% imshow(imageArray_even, []);
% 
% %merge odd and even channels
% fullimage=storedStructure_even.even_correct_channel([1;1]*(1:size(storedStructure_even.even_correct_channel,1)),:);
% fullimage(1:2:end,:)=storedStructure_odd.odd_channel;
% figure(4);
% imshow(fullimage, []);

A = [1,2,3;4,5,6;7,8,9;19,20,21]
B = [10,11,12;13,14,15;16,17,18;22,23,24]
% avg=sum(A,2)/size(A,2)
% A=A(:,1:end)+avg
 C = B([1;1]*(1:size(B,1)),:)
 C(1:2:end,:) = A
 D=(reshape([A';B'],[],size(B,2)))
