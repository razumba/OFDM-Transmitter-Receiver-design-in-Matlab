clc 
close all;
clear all;

par_H=[1,1,0,1;1,0,1,1;1,0,0,0;0,1,1,1;0,1,0,0;0,0,1,0;0,0,0,1;];
par_G=[1 0 1 0 1 0 1;0 1 1 0 0 1 1;0 0 0 1 1 1 1];
%-----------TRANSMITTER-----------------

% ----- digital source ----
par_no =49152;
switch_graph =0;
b=digital_source(par_no, switch_graph);
%b=digital_source(49152,0);

%------Channel coding------
switch_off=1;
par_N_zeros=0;
c=channel_coding(b,par_H,par_N_zeros,switch_off);
%c=channel_coding(b,par_H,0,1);

%-------Modulation------------
switch_mod =1;
M=4;
switch_graph =0;
%d=modulation(c,switch_mod,switch_graph);
[d,hDemod]=modulation(c,M,switch_graph); 
%d=modulation(c,0,0);

%-----Pilot insertion---------
par_N_FFT = 1024;
par_N_block=length(d)/1024;
switch_graph =0;
D=pilot_insertion(d,par_N_FFT,par_N_block,switch_graph);
%par_N_block=length(d)/1024;
%D=pilot_insertion(d,1024,par_N_block,0);

%------OFDM_TX------------
par_N_FFT = 1024;
par_N_CP= 256;
switch_graph = 0;

z=tx_ofdm_mod(D,par_N_FFT,par_N_CP,switch_graph);
%z=tx_ofdm_mod(D,1024,256,0);

%------Tx Filter------------
par_tx_w=20;
switch_graph = 0;
switch_off=1;
s=tx_filter(z,par_tx_w,switch_graph,switch_off);
%s=tx_filter(z,20,0,1);

%--------Non-Linear Hardware-------
par_txthresh=1;
switch_graph = 0;
[x]=tx_hardware(s,par_txthresh,switch_graph);
% [x]=tx_hardware(s,1,0);



 SNR = 0:10:60;
 N_iter = 10;
 BER = zeros(length(SNR),N_iter);
 for k = 1 : N_iter
 for i= 1 : length(SNR)

%------------CHANNEL-------------------

y=Channel(x,SNR(i),'FSBF');

%---------------------Reciever----------------------------------------

%------------------Non-Linear Hardware--------------------------------
par_rxthresh=1;
switch_graph = 0;
s_tilde=rx_hardware(y,par_rxthresh,switch_graph);
%s_tilde=rx_hardware(y,1,0);

%-------------------RX-Filter-----------------------------------------
par_rx_w=20;
switch_graph = 0;
switch_off=1;
z_tilde=rx_filter(s_tilde,par_rx_w,switch_graph,switch_off);
%[z_tilde]=rx_filter(s_tilde,20,0,1);


%-----------------OFDM-Demodulation------------------------------------

d_tilde=ofdm_demod(z_tilde,par_N_FFT,par_N_CP,switch_graph);
%d_tilde=ofdm_demod(z_tilde,1024,256,0);
DD=d_tilde';
DD1 = matdeintrlv(DD,11,2)'; % De-Interleave
%------------------Equalizer-------------------------------------------
switch_mod=1;
d_bar=equalizer(DD1,switch_mod,switch_graph);
%d_bar=equalizer(d_tilde,1,0);


%------------------Demodulation----------------------------------------
switch_mod = 1;
%c_hat=demodulation(d_bar,switch_mod,switch_graph);
c_hat=demodulation(d_bar,hDemod,switch_graph);
%c_hat=demodulation(d_bar,0,0);


%----------------- Channel Decoding -----------------------------------
switch_off=1;
b_hat=channel_decoding(c_hat,par_G,par_N_zeros,switch_off);
%b_hat=channel_decoding(c_hat,par_G,0,1);


%BER=digital_sink(b,b_hat);
e= abs(b-b_hat);
BER(i,k)=sum(e)/length(b);
 end
 end
 BER_loop = sum(BER,2)/N_iter;
 figure;
 semilogy(SNR,BER_loop);
 xlabel('SNR in DB');
 ylabel('BER');
 grid on
 