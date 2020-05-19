function graficador5G(a,b,ciy,xi,t0)
% a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
% b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
% ciy condiciones iniciales de la salida de  menor a mayor [y(0), y(0)^(n-1)]
% xi función de entrada en terminos de la variable simbolica t previamente
% declarada en el command window
% t0 tiempo final para graficar la solucion, la derivada, y la segunda 
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
%pretty(partfrac(H(s)));

%mensaje('La Respuesta al impulso es')
%disp('y(t)=')
y(t)=ilaplace(H(s));
%pretty(y(t))
subplot(321)%--------------------
fplot(y,[0,t0],'r','LineWidth',2)
title('Respuesta al impulso')
xlabel('tiempo','FontWeight','bold','FontSize',16)
grid on


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

%pretty(partfrac(edd));

%mensaje('La respuesta a entrada cero es')
%disp('y(t)=')
y(t)=ilaplace(edd);
%pretty(y(t))
subplot(322)%-------------------------
fplot(y,[0,t0],'g','LineWidth',2)
title('Respuesta a Entrada Cero')
xlabel('tiempo','FontWeight','bold','FontSize',16)
grid on


syms y(t) Y(s) x(t) X(s) Yy fp;
syms edd edi
edd=0;
edi=0;
xi_2=heaviside(t);

for i=1:tam(2)
   edd=edd+a(i)*s^(i-1)*Y(s);
   for k=1:i-1
       edd=edd-a(i)*(s^(i-1-k)*0*(k));
   end
end

for i=1:tami(2)
   edi=edi+b(i)*s^(i-1)*X(s);
end

edi=subs(edi,X(s), laplace(xi_2));


edd=collect(edd,Y(s));
edd=subs(edd,Y(s),Yy);
eq1=edd==edi;

edd=solve(eq1, Yy);
%pretty(simplify(edd));

%pretty(partfrac(edd));

%mensaje('Ruespuesta total al escalon')
%disp('y(t)=')
y(t)=ilaplace(edd);
%pretty(y(t))
subplot(323)%-----------------------
fplot(y(t),[0,t0],'c','LineWidth',2)
title('Respuesta Total al Escalon')
xlabel('tiempo','FontWeight','bold','FontSize',16)
grid on


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


%mensaje('La respuesta total es')
%disp('y(t)=')
y(t)=ilaplace(edd);
%pretty(y(t))
subplot(324)
fplot(y(t),[0,t0],'b','LineWidth',2)
title('Respuesta Total')
xlabel('tiempo','FontWeight','bold','FontSize',16)
grid on


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
%pretty(simplify(edd));

%pretty(partfrac(edd));

%mensaje('La respuesta a estado cero es')
%disp('y(t)=')
y(t)=ilaplace(edd);
%pretty(y(t))
subplot(414)
fplot(xi,[0, t0],'b','LineWidth',2)
hold on
fplot(y,[0,t0],'r','LineWidth',2)
title('Respuesta a Estado Cero')
legend('Entrada x(t)','Salida y(t)','Location','Best')
xlabel('tiempo','FontWeight','bold','FontSize',16)
grid on
end