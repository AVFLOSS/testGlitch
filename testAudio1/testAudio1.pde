//--------------------Ejemplo básico de análisis de sonido--------------//

//resource1: youtu.be/XS62cBK9E7w
//resource2: youtu.be/LcX36OxgZgg
//fft.getBand(): code.compartmental.net/minim/fft_method_getband.html
//fft.forward(): code.compartmental.net/minim/fft_method_forward.html

//Importar librerias "Sound" y "Minim"
import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim; //Declara minim
AudioInput input; //Declara input, entrada de micro
FFT fft; //Declara fft

void setup(){
  size(512, 320); //ancho del canvas a 512 para coincidir cada posicion en ejeX a una muestra (sample) del sonido
  noCursor(); //sin cursor en el canvas
  minim = new Minim(this); //Inicia minim
  input = minim.getLineIn(); //Inicia el micro
  fft = new FFT(input.bufferSize(), input.sampleRate()); //Inicia Análisis FFT en base al tamaño de buffer y a la tasa de muestreo
}

void draw(){
  colorMode(HSB, 100); // modo de color Hu, Saturación, Brillo de 0 a 100
  float hue = map(fft.getBand(25), 0, 16, 0, 100); // mapeamos el valor de amplitud al rando de color
  color c = color(hue, 100, 100);
  background(c); //fondo negro
  noStroke(); //elipse sin trazo
  fft.forward(input.mix);//perform a forward FFT on the samples in input's mix buffer, which contains the mix of both the left and right channels of the file
  for(int i = 0; i < fft.specSize(); i++){ //specSize = 512 un for para itinerar por todas las muestras
    ellipse(i,200,7,fft.getBand(i)); //getBand() Devuelve la amplitud de la banda de la muestra solicitada y la multiplica por 10 para escalarla un poco
  }
  println(fft.getBand(25));
}
