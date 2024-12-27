function I = CreateCircle(imageSize,radius)


% Create image:
%   - imageSize x imageSize pixels
%   - black central circle, radius "radius"


% Go through the entire image
for m=1:imageSize
    for n=1:imageSize
        
        if (m-imageSize/2)^2 + (n-imageSize/2)^2 <= radius^2
            I(m,n) = 1;%255;
        else
            I(m,n) = 0;
        end
        
    end
end