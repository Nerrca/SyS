function rentradacero(a,ciy,t0)
% a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
% b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
% t0 tiempo final para graficar la solucion, la derivada, y la segunda
% derivada
close all
tam=size(a);

syms y(t) Y(s) x(t) X(s) Yy fp;
syms edd edi P(s) Q(s)
edd=0;
edi=0;

for i=1:tam(2)
   edd=edd+a(i)*s^(i-1)*Y(s);
   for k=1:i-1
       edd=edd-a(i)*(s^(i-1-k)*ciy(k));
   end
end
   
edd=collect(edd,Y(s));
edd=subs(edd,Y(s),Yy);
eq1=edd==edi;

edd=solve(eq1, Yy);

mensaje('La respuesta a entrada cero es')
disp('y(t)=')
y(t)=ilaplace(edd);
pretty(y(t))
fplot(y,[0,t0],'g','LineWidth',2)
title('Respuesta a Entrada Cero')
xlabel('tiempo','FontWeight','bold','FontSize',16)
grid on

end

function mensaje(texto)
disp( ' ')
disp(texto)
disp( ' ')
end