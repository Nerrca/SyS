function rtotalescalon(a,b,t0)
% a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
% b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]

close all
tam=size(a);
tami=size(b);

syms y(t) Y(s) x(t) X(s) Yy fp;
syms edd edi
edd=0;
edi=0;
xi=heaviside(t);

for i=1:tam(2)
   edd=edd+a(i)*s^(i-1)*Y(s);
   for k=1:i-1
       edd=edd-a(i)*(s^(i-1-k)*0*(k));
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

mensaje('Ruespuesta total al escalon')
disp('y(t)=')
y(t)=ilaplace(edd);
pretty(y(t))
fplot(y(t),[0,t0],'c','LineWidth',2)
title('Respuesta Total al Escalon')
xlabel('tiempo','FontWeight','bold','FontSize',16)
grid on

end

function mensaje(texto)
disp( ' ')
disp(texto)
disp( ' ')
end

