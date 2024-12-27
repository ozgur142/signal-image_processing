pkg load image

clear;

%% Créez une image de carré

carre = zeros(100,100);
sz = 50;
for i = 0:sz-1
    for j = 0:sz-1
        carre(i+sz/2,j+sz/2) = 255;
    end
end

figure;
imshow(carre);

%% convolution

gradientx = [0 0 0; -1 0 1; 0 0 0];
gradienty = gradientx.';
gradximg = convolution(carre, gradientx);
gradyimg = convolution(carre, gradienty);
testx = conv2(carre, gradientx);
testy = conv2(carre, gradienty);
figure;
subplot(1, 2, 1);
imshow(gradximg);
subplot(1, 2, 2);
imshow(testx);

figure;
subplot(1, 2, 1);
imshow(gradyimg);
subplot(1, 2, 2);
imshow(testy);

camera = double(imread("cameraman.pgm"));
gradcamx = convolution(camera, gradientx);
gradcamy = convolution(camera, gradienty);
figure;
imagesc(gradcamx); colormap(gray);
figure;
imagesc(gradcamy); colormap(gray);


%% 2.2 Robustesse au bruit

camera = imread("cameraman.pgm");
bruit = randn(256) .* 20;

figure;
imshow(bruit);

cameramanBruit = camera + bruit;

figure;
subplot(1, 2, 1);
imshow(camera);
subplot(1, 2, 2);
imshow(cameramanBruit);

%% le filtre de Sobel
camera = double(imread("cameraman.pgm"));
sobelx = [-1 0 1; -2 0 2; -1 0 1];
sobely = sobelx.';

cameraSobelX = convolution(camera, sobelx);
cameraSobelY = convolution(camera, sobely);

figure;
subplot(1, 3, 1);
imagesc(camera); colormap(gray);
subplot(1, 3, 2);
imshow(cameraSobelX);
subplot(1, 3, 3);
imshow(cameraSobelY);

cameraBruitSobelX = convolution(cameramanBruit, sobelx);
cameraBruitSobelY = convolution(cameramanBruit, sobely);

figure;
subplot(1, 3, 1);
imshow(cameramanBruit);
subplot(1, 3, 2);
imshow(cameraBruitSobelX); 
subplot(1, 3, 3);
imshow(cameraBruitSobelY);

%% 2.3 Détection de contours

seuil = 128;
[l c]=size(cameraSobelX);
cameraContour = zeros(size(cameraSobelX));
for i=1:l
  for j=1:c
    if cameraSobelX(i,j) > seuil
      cameraContour(i,j) = 1;
    end
  end
end

figure;
imshow(cameraContour);

