pkg load image;


image = imread("img/miniMorpho.png");
H = [1 1 1];
V = [1; 1; 1];
B1 = [1 1 1; 1 1 1; 1 1 1];
C1 = [0 1 0; 1 1 1; 0 1 0];

er_h = imerode(image, H);
er_v = imerode(image, V);
er_b = imerode(image, B1);
er_c = imerode(image, C1);
dil_h = imdilate(image, H);
dil_v = imdilate(image, V);
dil_b = imdilate(image, B1);
dil_c = imdilate(image, C1);

figure;
subplot(2, 4, 1);
imshow(er_h);
subplot(2, 4, 2);
imshow(er_v);
subplot(2, 4, 3);
imshow(er_b);
subplot(2, 4, 4);
imshow(er_c);
subplot(2, 4, 5);
imshow(dil_h);
subplot(2, 4, 6);
imshow(dil_v);
subplot(2, 4, 7);
imshow(dil_b);
subplot(2, 4, 8);
imshow(dil_c);

figure;
subplot(2, 4, 1);
imshow(dil_h - image);
subplot(2, 4, 2);
imshow(dil_v - image);
subplot(2, 4, 3);
imshow(dil_b - image);
subplot(2, 4, 4);
imshow(dil_c - image);
subplot(2, 4, 5);
imshow(image - er_h);
subplot(2, 4, 6);
imshow(image - er_v);
subplot(2, 4, 7);
imshow(image - er_b);
subplot(2, 4, 8);
imshow(image - er_c);

figure;
subplot(2, 2, 1);
imshow(imerode(imerode(image, H), V));
subplot(2, 2, 2);
imshow(imerode(image, B1));
subplot(2, 2, 3);
imshow(imdilate(imdilate(image, H), V));
subplot(2, 2, 4);
imshow(imdilate(image, B1));

% au lieu de appliquer une filtre plusieurs fois sur une image, 
% on fait la convolution entre ces filtres et on obtient une seule filtre
% on diminue la nombre d'operation à effectuer en parcourant une seul fois notre image
n = 2;

er_nB1 = image;
er_nC1 = image;
Bn = 1;
Cn = 1;
for i=1:n
  er_nB1 = imerode(er_nB1, B1);
  er_nC1 = imerode(er_nC1, C1);
  Bn = conv2(Bn, B1);
  Cn = conv2(Cn, C1);
end
Bn=Bn~=0; % transforme 1 les valeurs non nul de matrix
Cn=Cn~=0;
er_Bn = imerode(image, Bn);
er_Cn = imerode(image, Cn);

fprintf("%d\n", isequal(er_Bn, er_nB1));
fprintf("%d\n", isequal(er_Cn, er_nC1));


figure;
subplot(2, 2, 1);
imshow(er_nB1);
subplot(2, 2, 2);
imshow(er_Bn);
subplot(2, 2, 3);
imshow(er_nC1);
subplot(2, 2, 4);
imshow(er_Cn);

%% 1.2 Ouverture et fermeture

% ouverture =  une érosion suivie d'une dilatation
%de faire disparaître les petites particules (dont la taille est inférieure à celle de l'élément structurant)
%de séparer les grosses particules aux endroits où elles sont plus fines

%fermeture = une dilatation suivie d'une érosion
%de faire disparaître les trous de petite taille dans les structures
%de connecter les structures proches

% on voit que l'ordre dilatation et erosion font une difference 
% 3 dilatation puis 3 erosion n'est pas la meme que 3 ouverture

n = 3;

ouver_C1 = image;
ferme_C1 = image;
Cn = 1;
figure;
for i=1:n
  ouver_C1 = imdilate(imerode(ouver_C1, C1), C1);
  ferme_C1 = imerode(imdilate(ferme_C1, C1), C1);
  Cn = conv2(Cn, C1);
  subplot(2, n, i);
  imshow(ouver_C1);
  subplot(2, n, i + n);
  imshow(ferme_C1);
end
Cn=Cn~=0; % transforme 1 les valeurs non nul de matrix
ouver_Cn = imdilate(imerode(image, Cn), Cn);
ferme_Cn = imerode(imdilate(image, Cn), Cn);

fprintf("%d\n", isequal(ouver_Cn, ouver_C1));
fprintf("%d\n", isequal(ferme_Cn, ferme_C1));


figure;
subplot(2, 2, 1);
imshow(ouver_C1);
subplot(2, 2, 2);
imshow(ouver_Cn);
subplot(2, 2, 3);
imshow(ferme_C1);
subplot(2, 2, 4);
imshow(ferme_Cn);


%% 1.3 En niveaux de gris
camera = imread("img/cameraman.pgm");
disk5 = strel("disk", 5, 0);
cameraInverse = uint8(255) - camera;

figure;
subplot(2, 5, 1);
imshow(camera);
subplot(2, 5, 2);
imshow(imerode(camera, disk5));
subplot(2, 5, 3);
imshow(imdilate(camera, disk5));
subplot(2, 5, 4);
imshow(imdilate(imerode(camera, disk5), disk5));
subplot(2, 5, 5);
imshow(imerode(imdilate(camera, disk5), disk5));
subplot(2, 5, 6);
imshow(cameraInverse);
subplot(2, 5, 7);
imshow(imerode(cameraInverse, disk5));
subplot(2, 5, 8);
imshow(imdilate(cameraInverse, disk5));
subplot(2, 5, 9);
imshow(imdilate(imerode(cameraInverse, disk5), disk5));
subplot(2, 5, 10);
imshow(imerode(imdilate(cameraInverse, disk5), disk5));









