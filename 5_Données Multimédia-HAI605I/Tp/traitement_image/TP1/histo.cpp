#include <iostream>
#include <fstream>
#include <stdio.h>
#include <string>
#include "image_ppm.h"

int main(int argc, char* argv[])
{
  char cNomImgLue[250];
  int nH, nW, nTaille;
  int hist[256];
  
  if (argc != 2) 
     {
       printf("Usage: ImageIn.pgm \n"); 
       exit (1) ;
     }

  for (int i=0; i<256; ++i)
    hist[i] = 0; 
   
   sscanf (argv[1],"%s",cNomImgLue);

   OCTET *ImgIn;

   lire_nb_lignes_colonnes_image_pgm(cNomImgLue, &nH, &nW);
   nTaille = nH * nW;

   allocation_tableau(ImgIn, OCTET, nTaille);
   lire_image_pgm(cNomImgLue, ImgIn, nH * nW);
   
   for (int i=0; i < nH; i++){
     for (int j=0; j < nW; j++){
         hist[ImgIn[i*nW+j]]++;
      }
    }

    std::ofstream outfile("histo.dat");

    for (int i = 0; i < 256; i++)
        outfile<<i<<" "<<hist[i]<<" "<<std::endl;

    free(ImgIn);

   return 1;
}