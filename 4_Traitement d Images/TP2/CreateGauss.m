function I = CreateGauss(imageSize,sigma2)


% Create image:
%   - imageSize x imageSize pixels
%   - black central circle, variance "sigma2"


% Go through the entire image
for m=1:imageSize
    for n=1:imageSize
        I(m,n) = 1/sqrt(2*pi*sigma2) * exp(-((m-imageSize/2)^2+(n-imageSize/2)^2)/sigma2);
    end
end