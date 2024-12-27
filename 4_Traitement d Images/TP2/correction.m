
lena2 = imread("lena2.png");
diagonale = imread("diagonale.png");

Slena2 = fft2(lena2);
Sdiagonale = fft2(diagonale);

figure;
subplot(2,3,1);
imshow(lena2);
subplot(2,3,2);
imagesc(log(1 + abs(fftshift(Slena2))));
subplot(2,3,3);
mesh(log(1 + abs(fftshift(Slena2))));
subplot(2,3,4);
imshow(diagonale);
subplot(2,3,5);
imagesc(log(1 + abs(fftshift(Sdiagonale))));
subplot(2,3,6);
mesh(log(1 + abs(fftshift(Sdiagonale))));


%%
k = 0.2;
Scomb = Slena2 + k * Sdiagonale;

figure;
subplot(1,2,1);
imagesc(log(1 + abs(fftshift(Scomb))));
subplot(1,2,2);
mesh(log(1 + abs(fftshift(Scomb))));


%%
itfScomb = ifft2(Scomb);

figure;
subplot(1,2,1);
imagesc(abs(itfScomb)); colormap(gray);
subplot(1,2,2);
mesh(log(1 + abs(fftshift(itfScomb))));


%%
figure;
masque = imread("masque.png");
scomb_mask = fftshift(Scomb) .* double(masque);
set(gca,'XTick',[]) % Remove the ticks in the x axis!
set(gca,'YTick',[]) % Remove the ticks in the y axis
set(gca,'Position',[0 0 1 1]) % Make the axes occupy the hole figure
set(gcf,'Position',[100 100 256 256]);
imagesc(log(1 + abs(scomb_mask)));
figure;
itfScombMask = ifft2(scomb_mask);
imagesc(abs(itfScombMask)); colormap(gray);




