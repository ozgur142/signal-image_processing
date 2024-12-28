pkg load image

%%
aquitaine = imread("aquitaine.png");

figure;
subplot(1, 2, 1);
imshow(aquitaine);
subplot(1, 2, 2);
imhist(aquitaine);
figure;
imagesc(aquitaine);
figure;
imagesc(aquitaine); colormap(gray);


%% additionner 100 à l’intensité de chaque pixel
aquitaineP100 = aquitaine+100;

figure;
subplot(1, 2, 1);
imshow(aquitaineP100);
% l'image est devenu plus claire
subplot(1, 2, 2);
imhist(aquitaineP100);


%% 8 l’intensité
lena = imread("lena.png");

figure;
subplot(1, 2, 1);
imshow(lena);
subplot(1, 2, 2);
imhist(lena);

newlena = lena / 8;
figure;
subplot(1, 2, 1);
imshow(newlena);
subplot(1, 2, 2);
imhist(newlena);


%% micro1.png  
micro = imread("micro1.png");

figure;
subplot(1, 2, 1);
imshow(micro);
subplot(1, 2, 2);
imhist(micro);

maxi = max(micro(:));
mini = min(micro(:));

% normalisation : exploiter toute la dynamique
micro_normalized = (255 / (maxi-mini)) * (micro - mini);

figure;
subplot(1, 2, 1);
imshow(micro_normalized);
subplot(1, 2, 2);
imhist(micro_normalized);

% egalisation : equilibrer la dynamique et ameliorer le constraste

micro_egalise = histeq(micro);

figure;
subplot(1, 2, 1);
imshow(micro_egalise);
subplot(1, 2, 2);
imhist(micro_egalise);










