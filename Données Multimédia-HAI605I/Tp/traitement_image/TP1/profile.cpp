#include <iostream>
#include <fstream>
#include <stdio.h>
#include <string>
#include "image_ppm.h"

int main(int argc, char* argv[])
{
  char cNomImgLue[250];
  int nH, nW, nTaille;
  int *profil;
  char indication;
  int indice;
  
  if (argc != 4) 
     {
       printf("Usage: ImageIn.pgm, (l pour ligne c pour colonne), une inice \n"); 
       exit (1) ;
     }

   
   sscanf (argv[1],"%s",cNomImgLue);
   sscanf (argv[2],"%s", &indication);
   sscanf (argv[3],"%d", &indice);

   OCTET *ImgIn;

   lire_nb_lignes_colonnes_image_pgm(cNomImgLue, &nH, &nW);
   nTaille = nH * nW;

   allocation_tableau(ImgIn, OCTET, nTaille);
   lire_image_pgm(cNomImgLue, ImgIn, nH * nW);  

   if ((indication == 'l' && indice > nW) || (indication == 'c' && indice > nH))
    std::cerr<<" Erreur indice hors de la taille !!!\n";
   
   int size = 0;
   if (indication == 'l')
   {
     size = nW;
     profil = new int[nW];
     for (int i = 0; i < nW; ++i)
      profil[i] = ImgIn[indice*nW+i];
   }
   else if (indication == 'c')
   {
     size = nH;
     profil = new int[nH];
     for (int i = 0; i < nH; ++i)
      profil[i] = ImgIn[i*nW+indice];
   }
   else {
    std::cerr<<"  Indication pas reconnu hors de 'l' ou 'c' !!! \n";
   }

    std::ofstream outfile("profile.dat");

    for (int i = 0; i < size; i++)
        outfile<<i<<" "<<profil[i]<<" "<<std::endl;

    free(ImgIn);

   return 1;
}