function restadocero(a,b,xi,t0)
% a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
% b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
% xi función de entrada en terminos de la variable simbolica t previamente
% declarada en el command window
% t0 tiempo final para graficar la solucion, la derivada, y la segunda 
close all
tam=size(a);
tami=size(b);
syms y(t) Y(s) x(t) X(s) Yy fp;
syms edd edi P(s) Q(s)
edd=0;
edi=0;

for i=1:tam(2)
   edd=edd+a(i)*s^(i-1)*Y(s);
   for k=1:i-1
       edd=edd-a(i)*(s^(i-1-k)*0);
   end
end

for i=1:tami(2)
   edi=edi+b(i)*s^(i-1)*X(s);
end

edi=subs(edi,X(s), laplace(xi));

edd=collect(edd,Y(s));
edd=subs(edd,Y(s),Yy);
eq1=edd==edi;
edd=solve(eq1, Yy);

mensaje('La respuesta a estado cero es')
disp('y(t)=')
y(t)=ilaplace(edd);
pretty(y(t))
fplot(xi,[0, t0],'b','LineWidth',2)
hold on
fplot(y,[0,t0],'r','LineWidth',2)
title('Respuesta a Estado Cero')
xlabel('tiempo','FontWeight','bold','FontSize',16)
grid on
    
end

function mensaje(texto)
disp( ' ')
disp(texto)
disp( ' ')
end

