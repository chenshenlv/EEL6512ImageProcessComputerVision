function [rho,theta,Accumulator] = hough(Imbinary,rho_step,theta_step,thresh)                          
rlimit=sqrt((size(Imbinary,1))^2+(size(Imbinary,2))^2);
r = -rlimit:rho_step:rlimit;
teta = -90:theta_step:90-theta_step;
%Voting
Accumulator = zeros(length(r),length(teta)); % initialize the accumulator
[yIndex,xIndex] = find(Imbinary>0); % find x,y of edge pixels
for cnt = 1:numel(xIndex)
    Indteta = 0;
    for tetai = teta*pi/180qY2
        Indteta = Indteta+1;
        roi = xIndex(cnt)*cos(tetai)+yIndex(cnt)*sin(tetai);
        if roi >= -rlimit && roi <= r(end)
            if roi<0
                Indp = floor(rlimit+roi);
            end
            Accumulator(Indp,Indteta) = Accumulator(Indp,Indteta)+1;
        end
    end
end
% Finding local maxima in Accumulator
AccumulatorbinaryMax = imregionalmax(Accumulator);
[Potential_rho,Potential_theta] = find(AccumulatorbinaryMax == 1);
Accumulatortemp = Accumulator - thresh;
rho = [];theta = [];
for cnt = 1:numel(Potential_rho)
    if Accumulatortemp(Potential_rho(cnt),Potential_theta(cnt)) >= 0
        rho = [rho;Potential_rho(cnt)];
        theta = [theta;Potential_theta(cnt)];
    end
end
% Calculation of detected lines parameters(Radius & Angle).
rho = rho * rho_step;
theta = theta *theta_step - theta_step-90;


end

