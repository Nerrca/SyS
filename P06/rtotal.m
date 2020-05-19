function rtotal(a,b,ciy,xi,t0)
% a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
% b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
% ciy condiciones iniciales de la salida de  menor a mayor [y(0), y(0)^(n-1)]
% xi función de entrada en terminos de la variable simbolica t previamente
% declarada en el command window 
close all
tam=size(a);
tami=size(b);
syms y(t) Y(s) x(t) X(s) Yy fp;
syms edd edi
edd=0;
edi=0;

for i=1:tam(2)
   edd=edd+a(i)*s^(i-1)*Y(s);
   for k=1:i-1
       edd=edd-a(i)*(s^(i-1-k)*ciy(k));
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


mensaje('La respuesta total es')
disp('y(t)=')
y(t)=ilaplace(edd);
pretty(y(t))
fplot(y(t),[0,t0],'b','LineWidth',2)
title('Respuesta Total')
xlabel('tiempo','FontWeight','bold','FontSize',16)
grid on
end

function mensaje(texto)
disp( ' ')
disp(texto)
disp( ' ')
end