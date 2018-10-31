I=importdata('ex1.pgm');
figure,imshow(I);
%threshold the pic and turn into binary image
threshold=130;
bw=im2bw(I(:,:,1),threshold/255);
figure,imshow(bw)
SE1=strel('disk',1);
SE2=strel('disk',9);
% mophology the image to extract front
dilate=Dilation(bw,SE1.Neighborhood);
open=Openning(dilate,SE2.Neighborhood);
figure,imshow(open);


labels=zeros(size(open));
next_label=1;
linked=[];
%initial 8-connect element
se=[1 1 1;
    1 1 1;
    1 1 1];
for row=1:size(labels,1)
    for col=1:size (labels,2)
        if open(row,col)~=0
            neighbor=se.*labels(row-1:row+1,col-1:col+1);
            
            if sum(sum(int8(neighbor)))==0
                linked{next_label}=next_label;
                labels(row,col)=next_label;
                next_label=next_label+1;
            else
                L=unique(neighbor(neighbor>0));
                labels(row,col)=min(L);
                for k=1:length(L)
                    label=int32(L(k));
                    linked{label}=union(linked{label},L);
                end
                    
                
            end
        end
    end
end

% remove the previous expansion of the image
labels = labels(2:end,2:end-1);

% join linked areas
% for each link, look through the other links and look for common labels.
% if common labels exist they are linked -> replace both link with the 
% union of the two. Repeat until there is no change in the links.
change2 = 1;
while change2 == 1
    change = 0;
    for i = 1:length(linked)
        for j = 1:length(linked)
            if i ~= j
                if sum(ismember(linked{i},linked{j}))>0 && sum(ismember(linked{i},linked{j})) ~= length(linked{i})
                    change = 1;
                    linked{i} = union(linked{i},linked{j});
                    linked{j} = linked{i};
                end
            end
        end
    end
    
    if change == 0
        change2 = 0;
    end
    
end
% % removing redundat links
% linked = unique(cellfun(@num2str,linked,'UniformOutput',false));
% linked = cellfun(@str2num,linked,'UniformOutput',false);
% K = length(linked);
% templabels = labels;
% labels = zeros(size(labels));
% % label linked labels with a single label:
% for k = 1:K
%     for l = 1:length(linked{k})
%         labels(templabels == linked{k}(l)) = k;
%     end
% end