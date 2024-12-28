
#include <stdio.h>
#include "image_ppm.h"


int main(int argc, char* argv[])
{
  char cNomImgLue[250], cNomImgEcrite[250];
  int nH, nW, nTaille;
  double hist[256];
  double F[256];
  double ddp[256];
  
  if (argc != 3) 
     {
       printf("Usage: ImageIn.pgm ImageOut.pgm \n"); 
       exit (1) ;
     }
   
  for (int i=0; i<256; ++i){
    hist[i] = 0; 
    F[i] = 0;
    ddp[i] = 0;
  }

   sscanf (argv[1],"%s",cNomImgLue) ;
   sscanf (argv[2],"%s",cNomImgEcrite);

   OCTET *ImgIn, *ImgOut;
   
   lire_nb_lignes_colonnes_image_pgm(cNomImgLue, &nH, &nW);
   nTaille = nH * nW;
  
   allocation_tableau(ImgIn, OCTET, nTaille);
   lire_image_pgm(cNomImgLue, ImgIn, nH * nW);
   allocation_tableau(ImgOut, OCTET, nTaille);


   for (int i=0; i < nH; i++){
     for (int j=0; j < nW; j++){
         hist[ImgIn[i*nW+j]]++;
      }
    }

    for (int i=0; i< 256; ++i){
        ddp[i] = hist[i] / nTaille;
    }

    F[0] = ddp[0];
    for (int i=1; i< 256; ++i){
        F[i] = F[i-1] + ddp[i];
    }

    printf("som = %f \n", F[255]);
	

  for (int i=0; i < nTaille; i++){
    ImgOut[i] = (int)(F[ImgIn[i]] * 255);
  }

   ecrire_image_pgm(cNomImgEcrite, ImgOut,  nH, nW);
   free(ImgIn); free(ImgOut);

   return 1;
}


