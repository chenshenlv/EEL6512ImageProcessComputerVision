function  draw_lines( input_image,rho,theta )
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明
imgsize=size(input_image);
figure;
imshow(input_image)
hold on;
line = zeros(2,2);
lineprm=[rho,theta];
for k = 1 : size(lineprm, 1),
    if lineprm(k,2) > 45 && lineprm(k,2) < -75,
        line(1,1) = 0; 
        line(1,2) = -lineprm(k,1) / sind(lineprm(k,2));
        line(2,1) = imgsize(2);
        line(2,2) = -line(1,2) + line(2,1) / tand(lineprm(k,2));
    else
        line(1,2) = 0; %y0
        line(1,1) = lineprm(k,1) / cosd(lineprm(k,2)); %x0
        line(2,2) = imgsize(1); % y1
        line(2,1) = line(1,1) + line(2,2) * tan(lineprm(k,2)); %x1
    end
    
    % The image origin defined in function '[...] = Hough_Grd(...)' is
    % different from what is defined in Matlab, off by (0.5, 0.5).
    line = line + 0.5;
    % Draw lines using 'plot'
    if nargin > 2,
        plot(line(:,1), line(:,2), 'LineWidth',3,'Color','green');
    else
        plot(line(:,1), line(:,2),'LineWidth',3,'Color','green');
    end
end
hold off;

end

