function D=pilot_insertion(d,par_N_FFT,par_N_block,switch_graph)
D2=reshape(d,par_N_FFT,par_N_block); 
P=ones(par_N_FFT,1)*3*(1+1j); %pilot data of 1024
D=[P,D2]; %concatination of pilot data and data
% D11=D1';
% %%D = matintrlv(D11,11,2)'; % Interleave.
% D=randintrlv(D11,2)'; % 
if switch_graph==1
    figure;
    plot(D,'r*');
end