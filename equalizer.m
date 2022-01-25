function d_bar=equalizer(d_tilde,switch_mod,switch_graph)
if switch_mod==1
    pilot_old = 3*(1+1i)*ones(1024,1);
    pilot=d_tilde(:,1)/pilot_old;
    Data_unequalized=d_tilde(:,2:end); % pilot seperated by taking only data from 2nd to end column
  
    [m,n]=size(Data_unequalized);
    Data_equalized=zeros(m,n);
    for i=1:m % to correct data if any changes
    for j=1:n
        Data_equalized(i,j)=(Data_unequalized(i,j))/pilot(i,1); % sometimes pilot might be multiplied
                                                                % with the data to remove that we are diving the dta with pilot
    end
    end
    d_bar=reshape(Data_equalized,m*n,1);    
    if switch_graph==1
        figure;
    plot(d_bar,'r*');
    title('Constellation diagram after Equalizer');
    xlabel('In-phase Amplitude');
    ylabel('Quadrature Amplitude');
    end
else 
    d_bar1=d_tilde(:,2:end); % if there is no change it data then after 
                            %removing the pilot we just take the data from 2nd column to set as o/p
    [m,n]=size(d_bar1);
    d_bar=reshape(d_bar1,m*n,1);
    
end
    
        
        
   
    