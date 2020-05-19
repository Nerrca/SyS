function ftransferencia(a,b)
% a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
% b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]    
close all
tam=size(a);
tami=size(b);
syms H(s) P(s) Q(s);
H(s)=0;
P(s) = 0;
Q(s) = 0;

for i=1:tam(2)
   Q(s)=Q(s)+a(i)*(s)^(i-1);
end

for i=1:tami(2)
   P(s)=P(s)+b(i)*(s)^(i-1);
end

mensaje('Funcion de Transferencia')
H(s) =  P(s)/Q(s);
disp('H(s)=')
pretty(H(s))

end

function mensaje(texto)
disp( ' ')
disp(texto)
disp( ' ')
end
