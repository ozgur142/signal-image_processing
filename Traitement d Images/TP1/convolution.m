function res = convolution(img, mask)
    nH = size(img, 1);
    nW = size(img, 2);
    coeff = sum(sum(mask));
    if coeff == 0
      coeff = 1;
    end
    res = img;
    for i = 2:nH-1
        for j = 2:nW-1
            x = 0;
            for k = -1:1
                for t = -1:1
                    x = x + img(i+k,j+t) * mask(k+2, t+2);
                end
            end
        
            res(i,j) = x / coeff;
        end
    end
end
