function d=modulation_kutub(c,switch_mod,switch_graph)
if switch_mod == 0                                                         % 4 QAM
    M = 2;  
elseif switch_mod == 1
        M=4;% two bits in one symbol
    else 
        M=6;
end
    rem = mod(length(c),M);                                        % to check if the length of c is the multiple of data length 
    if rem ~0                                                             % if no then we add some zeros
        c = [c; zeros(M-rem,1)];                                   % zero padding
    end
M1=2^M;
x=-sqrt(M1)+1;
y=x;
m1=[];
 QAM_point=[];
for i1=1:sqrt(M1)
    for j1=1:sqrt(M1)
        QAM_point=[QAM_point; x+y*1i];
        x=x+2;
    end
    x=-sqrt(M1)+1;

    y=y+2;
end
QAM_points=QAM_point/sqrt(10);
  % /sqrt(2); ;sqrt(42);                          % the above mentioned concept is being used for two other modulation schemes
  d = [];  
  for index = 1:M:length(c)
        modulated_index = bi2de(c(index:index+M-1)', 'left-msb');              % to define gray coding 
        d = [d; QAM_points(modulated_index+1)];
    end
if(switch_graph == 1)
    scatterplot(d)
    title('Modulation Output');
    grid on
    axis([-2 2 -2 2]);
end

end