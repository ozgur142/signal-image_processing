
#include <stdio.h>
#include "image_ppm.h"

int main(int argc, char* argv[])
{
  char cNomImgLue[250], cNomImgEcrite[250];
  int nH, nW, nTaille;
  
  if (argc != 3) 
     {
       printf("Usage: ImageIn.pgm ImageOut.pgm \n"); 
       exit (1) ;
     }
   
   sscanf (argv[1],"%s",cNomImgLue) ;
   sscanf (argv[2],"%s",cNomImgEcrite);

   OCTET *ImgIn, *ImgOut;
   
   lire_nb_lignes_colonnes_image_pgm(cNomImgLue, &nH, &nW);
   nH = 256;
   nW = 256;
   nTaille = nH * nW;
  
   allocation_tableau(ImgIn, OCTET, nTaille);
   lire_image_pgm(cNomImgLue, ImgIn, nH * nW);
   allocation_tableau(ImgOut, OCTET, nTaille);
  
   //   for (int i=0; i < nTaille; i++)
   // {
   //  if ( ImgIn[i] < S) ImgOut[i]=0; else ImgOut[i]=255;
   //  }

   int coeff= 16;
   int mask[3][3] = {{1,2,1},{2,4,2},{1,2,1}};


 for (int i=0; i < nH; i++){
   for (int j=0; j < nW; j++)
     {
      if (i == 0 || j == 0 || i == nW-1 || i == nH-1)
        ImgOut[i*nW+j] = ImgIn[i*nW+j];
      else{
        int x = 0;
        for (int k = -1; k < 2; ++k)
        {
          for (int t = -1; t < 2; ++t)
          {
            x += ImgIn[(i+k)*nW + j+t] * mask[k+1][t+1];
          }
        }
        ImgOut[i*nW+j] = x/coeff;
      }
    }
  }

   ecrire_image_pgm(cNomImgEcrite, ImgOut,  nH, nW);
   free(ImgIn); free(ImgOut);

   return 1;
}
