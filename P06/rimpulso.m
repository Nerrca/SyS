function rimpulso(a,b,t0)
% a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
% b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
close all
tam=size(a);
tami=size(b);
syms H(s) P(s) Q(s) y(t);
H(s)=0;
P(s) = 0;
Q(s) = 0;

for i=1:tam(2)
   Q(s)=Q(s)+a(i)*(s)^(i-1);
end

for i=1:tami(2)
   P(s)=P(s)+b(i)*(s)^(i-1);
end
H(s) =  P(s)/Q(s);

mensaje('La Respuesta al impulso es')
disp('y(t)=')
y(t)=ilaplace(H(s));
pretty(y(t))
fplot(y,[0,t0],'r','LineWidth',2)
title('Respuesta al impulso')
xlabel('tiempo','FontWeight','bold','FontSize',16)
grid on
end

function mensaje(texto)
disp( ' ')
disp(texto)
disp( ' ')
end
