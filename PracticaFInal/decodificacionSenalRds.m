clear all, close all

%---Decodificacion de la señal RDS
load IQ_data_FM; I=double(I); Q=double(Q);

R= complex(I, Q);
prod= 0*R(1:end-1);
n= length(R);
for k=2:n
    prod(k-1)=R(k)*conj(R(k-1));
end
fase2= angle(prod);
x= diff(fase2);

w1=(57000-2500)/(fs/2);
w2= (57000+2500)/(fs/2);
wc=[w1 w2];B = fir1(192,wc);
fvtool(B,1,'fs', fs);% llamamos a fvtool 

%señal filtrada
x_rds = filter(B,1,x);
figure(2)
ver_tf(x_rds,fs,'r','semi');
figure(3)
ver_tf(x_rds(2050:3100),fs,'r','semi');

%Limpiar bits
t=(0:1/fs:9.684205)';
f=  56999.5;%f= 57000;%!!!!!Frecuencia nominal
oscilacion= cos(2*pi*f*t);
nuevaSen= oscilacion.*x_rds;
figure(4)
ver_tf(nuevaSen(2050:3100), fs,'r','semi');

%filtrado paso bajo
fcorte= 2500;%hz
wc=fcorte/(fs/2); B = fir1(192,wc);
x_rds2 = filter(B,1,nuevaSen);
figure(5)
ver_tf(x_rds2(2050:3100),fs,'r','semi');

%Eye Diargrams(Determinacion de la posicion de los bits)
Nbits=11500;%columnas
BIT_SIZE=208;%filas 
x_rds2=[x_rds2; 0];
M=reshape(x_rds2,BIT_SIZE,Nbits);
figure(6)
plot(M)

%-- Decodificación del mensaje RDS

