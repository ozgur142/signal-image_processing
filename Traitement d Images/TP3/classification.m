

%% 2.1 Pretraitement
% chaque type de graine a une taille et une forme distinctive
Seeds = imread("img/Seeds.png");
maxi = max(Seeds(:));
mini = min(Seeds(:));
% normalisation : exploiter toute la dynamique
normal = (255 / (maxi-mini)) * (Seeds - mini);
%binaire = imbinarize(normal); %% MatLab
binaire = im2bw(normal); %% Octave

figure;
subplot(1,3,1);
imshow(Seeds);
subplot(1,3,2);
imshow(normal);
imwrite(normal, "seeds_normal.png");
subplot(1,3,3);
imshow(binaire);
imwrite(normal, "seeds_bin.png");

disk = strel("disk", 3);
ouver = imdilate(imerode(binaire, disk), disk);
figure;
imshow(ouver);

img_zero = zeros(size(Seeds));
img_zero(:, 1) = 1;
img_zero(:, end) = 1;
img_zero(1, :) = 1;
img_zero(end, :) = 1;

graines_coupees = imreconstruct(img_zero, double(ouver));
imgF = ouver - graines_coupees;

figure;
subplot(1, 2, 1);
imshow(imgF);
subplot(1, 2, 2);
imshow(graines_coupees)

%% 2.2 Granulometrie
tailles = zeros(1, 20);
for i = 1:20
    disk = strel("disk", i);
    imgO = imdilate(imerode(imgF, disk), disk);
    %figure;
    %imshow(imgO);
    tailles(i) = length(PropSeed(imgO));
end

figure;
plot(1:20, tailles);
xlabel("Taille du disque"), ylabel("Nombre de graines");

%% Classif
m1 = strel("disk", 4); %% petite graines
m2 = strel("disk", 15); %% moyennes graines
m3 = strel("disk", 19); %% grandes graines

toutes = imdilate(imerode(imgF, m1), m1);
moyennes_grandes = imdilate(imerode(imgF, m2), m2);
grandes = imdilate(imerode(imgF, m3), m3);

figure;
subplot(1, 3, 1);
imshow(toutes);
subplot(1, 3, 2);
imshow(moyennes_grandes);
subplot(1, 3, 3);
imshow(grandes);

b = conv2([1 1 1; 1 1 1; 1 1 1], [1 1 1; 1 1 1; 1 1 1]);
b= conv2(b,b);
b= conv2(b,b);

figure;
subplot(2, 3, 1);
imshow(toutes - moyennes_grandes);
subplot(2, 3, 2);
imshow(moyennes_grandes - grandes);
subplot(2, 3, 3);
imshow(grandes);
subplot(2, 3, 4);
imshow(toutes - imdilate(moyennes_grandes, b));
subplot(2, 3, 5);
imshow(moyennes_grandes - imdilate(grandes, b));
subplot(2, 3, 6);
imshow(grandes);

% Comme l'ouverture diminue la taille des graines, les soustraction des
% images ont beaucoup de bruit, donc cette methode de classification est
% efficace mais les images doivent passer un traitement pour qu'elles sont
% meilleures

%% 2.3
T = PropSeed(imgF);
figure;
scatter(T(:, 1), T(:, 2));
xlabel("Aire de la graine (en pixels)"), ylabel("Excentricite");

% petites graines
% moyennes graines
% grandes graines

classes = zeros(1, length(T));
for i = 1:length(T)
    if T(i, 1) >= 500 && T(i, 1) < 1500 && T(i, 2) >= 0 && T(i, 2) < 0.6
        classes(i) = 2;
    elseif T(i, 1) > 2000 && T(i, 2) > 0.7
        classes(i) = 3;
    else
        classes(i) = 1;
    end
end

fprintf("petites graines: %d, moyennes graines: %d; grandes graines: %d\n", sum(classes(:) == 1), sum(classes(:) == 2), sum(classes(:) == 3));




