function I = CreateCircle2(width, height,radius)


% Create image:
%   - imageSize x imageSize pixels
%   - black central circle, radius "radius"


% Go through the entire image
for m=1:height
    for n=1:width

        if (m-height/2)^2 + (n-width/2)^2 <= radius^2
            I(m,n) = 1;%255;
        else
            I(m,n) = 0;
        end

    end
end
