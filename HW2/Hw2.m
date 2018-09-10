% [hist_norm,hist]=myhist('flower.pgm');
[ histeq_norm ] = myhisteq( 'flower.pgm' );
  [quant_output] = myquantize( 'flower.pgm',256 );
          

% as=[1 1 3 3 5 5 8 8];
% bhis=[2 1 6 4 3 8 7 9];
% q=zeros(1,8);
% temp=zeros(1,8);
% as=[as,0];
% for i= 2:9
%     if as(i-1)==as(i)
%         temp(i-1)=bhis(i-1);
%         temp(i)=bhis(i);
%     end
%     if as(i-1)~=as(i)
%         q(as(i-1))=sum(temp);
%         temp=0*temp;
%     end
% end
% q
          