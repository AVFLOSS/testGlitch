//----------EJEMPLO MAXIMO VALOR ---------------//

import ddf.minim.analysis.*;
 import ddf.minim.*;

 float vmax=0; 
   int imax=0;

 Minim minim; //Declara minim
 AudioInput input; //Declara input, entrada de micro
 FFT fft; //Declara fft

 void setup(){
     colorMode(HSB, 100); // modo de color Hu, Saturación, Brillo de 0 a 100
   size(512, 320); //ancho del canvas a 512 para coincidir cada posicion en ejeX a una muestra (sample) del sonido
   noCursor(); //sin cursor en el canvas
   minim = new Minim(this); //Inicia minim
   input = minim.getLineIn(); //Inicia el micro
   fft = new FFT(input.bufferSize(), input.sampleRate()); //Inicia Análisis FFT en base al tamaño de buffer y a la tasa de muestreo
 }

 void draw(){
 
   
 
   float hue = map(imax, 0, 63, 0, 100); // mapeamos el valor de amplitud al rando de color
   color c = color(hue, 100, 100);
   background(0); //fondo negro
   fill(c);
   vmax=0;
   imax=0;
   noStroke(); //elipse sin trazo
   fft.forward(input.mix);//perform a forward FFT on the samples in input's mix buffer, which contains the mix of both the left and right channels of the file
  
   for(int i = 0; i < fft.specSize(); i++){ //specSize = 512 un for para itinerar por todas las muestras
     
      if (fft.getBand(i)>vmax) {
        imax = i;
        vmax=fft.getBand(i);
      }
  
     rect(i*2,200,7,-1*fft.getBand(i)*10); //getBand() Devuelve la amplitud de la banda de la muestra solicitada y la multiplica por 10 para escalarla un poco
   }
   println(imax);
 }
