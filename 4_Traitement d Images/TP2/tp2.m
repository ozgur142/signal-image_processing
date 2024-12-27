pkg load image;

clear;

%% 2.1Calcul de TF
%% Cercle
rayon = [16:16:64];
figure;
for i = [1:length(rayon)]
    disque = CreateCircle(128, rayon(i));
    subplot(2, 4, i);
    imshow(disque);
    subplot(2, 4, i + length(rayon));
    imshow(fftshift(fft2(disque)));
end

%% Sinus
%{
Une image sinusoïdale de fréquence (u0,v0) a comme représentation spectrale 
deux pics de Dirac aux positions (u0,v0) et (−u0,−v0) : cette image ne contenant 
qu'une seule fréquence, son spectre ne contient que 2 valeurs non nulles.
%}
%{
Dans la figure ci-dessus, pour chaque image, 
on voit 2 coefficients non nuls dans le spectre : les deux coefficients qui
 correspondent à la fréquence de la sinusoïde. le coefficient central,
 qui correspond à la fréquence (0,0) Ce coefficient correspond 
 à la valeur moyenne de l'image. Il est nul ici, 
car les images sinusoïdales ont des valeurs entre 0 et 255 et non entre -1 et 1.
https://openclassrooms.com/en/courses/5060661-initiez-vous-aux-traitements-de-base-des-images-numeriques/5217221-decouvrez-les-frequences-spatiales-et-la-representation-spectrale
%}
frequences = [4:10:34];
figure;
for i = [1:length(frequences)]
    sinusoide = CreateSinus(128, frequences(i));
    subplot(2, 4, i);
    imshow(sinusoide);
    subplot(2, 4, i + length(frequences));
    imshow(fftshift(fft2(sinusoide)));
    %imshow(arg(fftshift(fft2(sinusoide))));
end


figure;
for i = [1:length(frequences)]
    sinusoide = CreateSinus(128, frequences(i));
    subplot(2, 4, i);
    imshow(sinusoide.');
    subplot(2, 4, i + length(frequences));
    imshow(fftshift(fft2(sinusoide.')));
end


%% Gaussienne
variances = [0.1, 1, 10, 0.0001];
figure;
for i = [1:length(variances)]
    gaussienne = CreateGauss(32, variances(i));
    subplot(2, length(variances), i);
    imshow(gaussienne);
    subplot(2, length(variances), i + length(variances));
    imshow(fftshift(fft2(gaussienne)));
end

%% barbara.png
barbara = imread("barbara.pgm");
figure;
subplot(1,2,1);
imshow(barbara);
subplot(1,2,2);
imshow(fftshift(fft2(barbara)));


%% 2.2 Influence du bruit
disque = CreateCircle(128, 40);
bruit = randn(128);              %% ca ou??????
%bruit = CreateGauss(128, 0.0001);  %% ca????
disqueBruit = disque + bruit;

figure;
subplot(1,4,1);
imshow(disque);
subplot(1,4,2);
imshow(bruit);
subplot(1,4,3);
imshow(disqueBruit);
subplot(1,4,4);
imshow(fftshift(fft2(disqueBruit)));

% 2.3 Filtrage dans le domaine fréquentiel
rayon = [16:16:64];
for i = [1:length(rayon)]
    figure;
    masque = abs(CreateCircle(128, rayon(i)) - 1);
    subplot(2, 4, i);
    tf_masque = fftshift(fft2(disque)) .* masque;
    imshow(abs(tf_masque));
    subplot(2, 4, i + length(rayon));
    imagesc(abs(ifft2(tf_masque))); colormap(gray);
end

%%
facade = imread("facade.png");
rayon = [64:32:160];
for i = [1:length(rayon)]
    figure(1)
    masque = abs(CreateCircle2(620, 406, rayon(i)) - 1);
    subplot(1, 4, i);
    tff_masque = fftshift(fft2(facade)) .* masque;
    imshow(abs(tff_masque));
    figure;
    set(gca,'XTick',[]) % Remove the ticks in the x axis!
    set(gca,'YTick',[]) % Remove the ticks in the y axis
    set(gca,'Position',[0 0 1 1]) % Make the axes occupy the hole figure
    set(gcf,'Position',[100 100 620 406]);
    imagesc(abs(ifft2(tff_masque))); colormap(gray);
end

%%%% On peut voir sur les briques de chaque tf-1 des details qui
%%%% disparaissent plus le rayon masque augmente -> le 1er garde plus de
%%%% basses freq que les autres



%%  Importance de la phase

barbara = imread("barbara.pgm");
lena = imread("lena.pgm");

moduleBarbara = abs(fft2(barbara));
phaseBarbara = arg(fft2(barbara));
moduleLena = abs(fft2(lena));
phaseLena = arg(fft2(lena));

figure;
subplot(2,2,1);
imagesc(log(1+moduleBarbara)); colormap(gray);
subplot(2,2,2);
imshow(phaseBarbara);
subplot(2,2,3);
imagesc(log(1+moduleLena)); colormap(gray);
subplot(2,2,4);
imshow(phaseLena);


moduleBarbaraphaseLena = moduleBarbara .* exp(j*phaseLena);
itfmoduleBarbaraphaseLena = ifft2(moduleBarbaraphaseLena);

moduleLenaphaseBarbara = moduleLena .* exp(j*phaseBarbara);
itfmoduleLenaphaseBarbara = ifft2(moduleLenaphaseBarbara);

figure;
subplot(2,2,1);
imshow(moduleBarbaraphaseLena); 
subplot(2,2,2);
imagesc(abs(itfmoduleBarbaraphaseLena)); colormap(gray);
subplot(2,2,3);
imshow(moduleLenaphaseBarbara); 
subplot(2,2,4);
imagesc(abs(itfmoduleLenaphaseBarbara)); colormap(gray);




