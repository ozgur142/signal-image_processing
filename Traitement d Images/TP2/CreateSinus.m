function I = CreateSinus(imageSize,f)


% Create image:
%   - imageSize x imageSize pixels
%   - Horizental Sinus image, frequency "f"


% Go through the entire image
I=zeros(imageSize);
for m=1:imageSize
    I(:,m)=sin(2*pi*f*m/imageSize);
end
