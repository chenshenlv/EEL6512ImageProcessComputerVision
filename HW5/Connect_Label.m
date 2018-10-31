function [outputArg1,outputArg2] = Connect_Label(input_im)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%initial the labels image
labels=false(size(input_im));
next_label=1;
linked=[];
%initial 8-connect element
se=[1 1 1;
    1 1 1;
    1 1 1];
for row=1:size(labels,1)
    for col=1:size (labels,2)
        if input_im(row,col)~=0
            neighbor=se.*labels(row-1:row+1,col-1:col+1);
            
            if sum(neighbor,'all')==0
                linked{next_label}=next_labell;
                labels(row,col)=next_label;
                next_label=next_label+1;
            else
                L=unique(neighbor(neighbor>0));
                labels(row,col)=min(L);
                for label=1:size(L)
                    linked{lable}=union(linked{lable},L)
                end
                    
                
            end
        end
    end
end

end


se=[1 1 1;
    1 1 1;
    1 1 1];
b=[3 2 0;
    4 5 6;
    2 0 9];
nei=se.*b
k=unique(nei(nei>0))
