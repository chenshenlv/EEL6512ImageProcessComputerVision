%display odd channel
storedStructure_odd = load('odd_rows.mat');
imageArray_odd = storedStructure_odd.odd_channel;
figure(1);
imshow(imageArray_Odd, []);