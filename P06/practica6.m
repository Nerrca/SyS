%% Práctica 6: Sistemas diferenciales
% Integrantes: Gómez Serrano Eric, Gómez García Carlos Eduardo
%
%%
% Se utilizará la siguiente ecuación diferencial para probar las funciones
% que se muestran a continuación. El código de cada función se encuentra en
% el apendice.
% $$\ddot{y}(t)+2\dot{y}(t)+3y(t)=\dot{x}(t)-x(t),\;\;y(0)=1,\;y'(0)=1,\;x(t)=cos(2t)u(t)$
% 
%% Función de transferencia del sistema
ftransferencia([3 2 1],[-1 1])
%% La respuesta al impulso
rimpulso([3 2 1],[-1 1],10)
%% Respuesta a entrada cero
syms t
rentradacero([3 2 1],[1 1],10)
%% Respuesta a estado cero
syms t
restadocero([3 2 1], [-1 1],cos(2*t)*heaviside(t),10)
%% Respuesta Total
syms t
rtotal([3 2 1],[-1 1],[1 1],cos(2*t)*heaviside(t),10)
%% respuesta total al escalon (con condiciones iniciales 0)
rtotalescalon([3 2 1],[-1 1],10)
%% Gráficas
graficador5G([3 2 1],[-1 1],[1 1],cos(2*t)*heaviside(t),10)

%% Apendice
% el códgio de esta publicación y de las funciones lo puede encontrar en el siguiente enlace <https://drive.matlab.com/sharing/cd85021f-5ffb-4d29-a5e2-55f500963f9e> 
%%
%  function ftransferencia(a,b)
%   %a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
%   %b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]    
%  close all
%  tam=size(a);
%  tami=size(b);
%  syms H(s) P(s) Q(s);
%  H(s)=0;
%  P(s) = 0;
%  Q(s) = 0;
% 
%  for i=1:tam(2)
%     Q(s)=Q(s)+a(i)*(s)^(i-1);
%  end
% 
%  for i=1:tami(2)
%     P(s)=P(s)+b(i)*(s)^(i-1);
%  end
% 
%  mensaje('Funcion de Transferencia')
%  H(s) =  P(s)/Q(s);
%  disp('H(s)=')
%  pretty(H(s))
% 
%  end
%
%
%
%  function rimpulso(a,b)
%  % a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
%  % b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
%  close all
%  tam=size(a);
%  tami=size(b);
%  syms H(s) P(s) Q(s) y(t);
%  H(s)=0;
%  P(s) = 0;
%  Q(s) = 0;
% 
%  for i=1:tam(2)
%     Q(s)=Q(s)+a(i)*(s)^(i-1);
%  end
% 
%  for i=1:tami(2)
%     P(s)=P(s)+b(i)*(s)^(i-1);
%  end
%  H(s) =  P(s)/Q(s);
%  pretty(partfrac(H(s)));
% 
%  mensaje('La Respuesta al impulso es')
%  disp('y(t)=')
%  y(t)=ilaplace(H(s));
%  pretty(y(t))
%  fplot(y,'r','LineWidth',2)
%  title('Respuesta al impulso')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
%  end
%
%  function mensaje(texto)
%  disp( ' ')
%  disp(texto)
%  disp( ' ')
%  end
%
%
%
%  function rentradacero(a,ciy,t0)
%  % a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
%  % b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
%  % t0 tiempo final para graficar la solucion, la derivada, y la segunda
%  % derivada
%  close all
%  tam=size(a);
% 
%  syms y(t) Y(s) x(t) X(s) Yy fp;
%  syms edd edi P(s) Q(s)
%  edd=0;
%  edi=0;
% 
%   for i=1:tam(2)
%     edd=edd+a(i)*s^(i-1)*Y(s);
%     for k=1:i-1
%         edd=edd-a(i)*(s^(i-1-k)*ciy(k));
%     end
%  end
%    
%  edd=collect(edd,Y(s));
%  edd=subs(edd,Y(s),Yy);
%  eq1=edd==edi;
% 
%  edd=solve(eq1, Yy);
% 
%  pretty(partfrac(edd));
% 
%  mensaje('La respuesta a entrada cero es')
%  disp('y(t)=')
%  y(t)=ilaplace(edd);
%  pretty(y(t))
%  fplot(y,[0,t0],'g','LineWidth',2)
%  title('Respuesta a Entrada Cero')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
% 
%  end
% 
%  function mensaje(texto)
%  disp( ' ')
%  disp(texto)
%  disp( ' ')
%  end
%
%
%
%  function restadocero(a,b,xi,t0)
%  % a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
%  % b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
%  % xi función de entrada en terminos de la variable simbolica t previamente
%  % declarada en el command window
%  % t0 tiempo final para graficar la solucion, la derivada, y la segunda 
%  close all
%  tam=size(a);
%  tami=size(b);
%  syms y(t) Y(s) x(t) X(s) Yy fp;
%  syms edd edi P(s) Q(s)
%  edd=0;
%  edi=0;
% 
%  for i=1:tam(2)
%     edd=edd+a(i)*s^(i-1)*Y(s);
%     for k=1:i-1
%         edd=edd-a(i)*(s^(i-1-k)*0);
%     end
%  end
% 
%  for i=1:tami(2)
%     edi=edi+b(i)*s^(i-1)*X(s);
%  end
% 
%  edi=subs(edi,X(s), laplace(xi));
% 
%  edd=collect(edd,Y(s));
%  edd=subs(edd,Y(s),Yy);
%  eq1=edd==edi;
%  edd=solve(eq1, Yy);
%  pretty(simplify(edd));
% 
%  pretty(partfrac(edd));
% 
%  mensaje('La respuesta a estado cero es')
%  disp('y(t)=')
%  y(t)=ilaplace(edd);
%  pretty(y(t))
%  fplot(xi,[0, t0],'b','LineWidth',2)
%  hold on
%  fplot(y,[0,t0],'r','LineWidth',2)
%  title('Respuesta a Estado Cero')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
%     
%  end
% 
%  function mensaje(texto)
%  disp( ' ')
%  disp(texto)
%  disp( ' ')
%  end
%
%
%
%  function restadocero(a,b,xi,t0)
%  % a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
%  % b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
%  % xi función de entrada en terminos de la variable simbolica t previamente
%  % declarada en el command window
%  % t0 tiempo final para graficar la solucion, la derivada, y la segunda 
%  close all
%  tam=size(a);
%  tami=size(b);
%  syms y(t) Y(s) x(t) X(s) Yy fp;
%  syms edd edi P(s) Q(s)
%  edd=0;
%  edi=0;
% 
%  for i=1:tam(2)
%     edd=edd+a(i)*s^(i-1)*Y(s);
%     for k=1:i-1
%         edd=edd-a(i)*(s^(i-1-k)*0);
%     end
%  end
% 
%  for i=1:tami(2)
%     edi=edi+b(i)*s^(i-1)*X(s);
%  end
% 
%  edi=subs(edi,X(s), laplace(xi));
% 
%  edd=collect(edd,Y(s));
%  edd=subs(edd,Y(s),Yy);
%  eq1=edd==edi;
%  edd=solve(eq1, Yy);
%  pretty(simplify(edd));
% 
%  pretty(partfrac(edd));
% 
%  mensaje('La respuesta a estado cero es')
%  disp('y(t)=')
%  y(t)=ilaplace(edd);
%  pretty(y(t))
%  fplot(xi,[0, t0],'b','LineWidth',2)
%  hold on
%  fplot(y,[0,t0],'r','LineWidth',2)
%  title('Respuesta a Estado Cero')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
%     
%  end
% 
%  function mensaje(texto)
%  disp( ' ')
%  disp(texto)
%  disp( ' ')
%  end
%
%
%
%  function rtotal(a,b,ciy,xi)
%  % a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
%  % b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
%  % ciy condiciones iniciales de la salida de  menor a mayor [y(0), y(0)^(n-1)]
%  % xi función de entrada en terminos de la variable simbolica t previamente
%  % declarada en el command window 
%  close all
%  tam=size(a);
%  tami=size(b);
%  syms y(t) Y(s) x(t) X(s) Yy fp;
%  syms edd edi
%  edd=0;
%  edi=0;
% 
%  for i=1:tam(2)
%     edd=edd+a(i)*s^(i-1)*Y(s);
%     for k=1:i-1
%         edd=edd-a(i)*(s^(i-1-k)*ciy(k));
%     end
%  end
% 
%  for i=1:tami(2)
%     edi=edi+b(i)*s^(i-1)*X(s);
%  end
% 
%  edi=subs(edi,X(s), laplace(xi));
% 
% 
%  edd=collect(edd,Y(s));
%  edd=subs(edd,Y(s),Yy);
%  eq1=edd==edi;
%  edd=solve(eq1, Yy);
% 
% 
%  mensaje('La respuesta total es')
%  disp('y(t)=')
%  y(t)=ilaplace(edd);
%  pretty(y(t))
%  fplot(y(t),'b','LineWidth',2)
%  title('Respuesta Total')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
%  end
% 
%  function mensaje(texto)
%  disp( ' ')
%  disp(texto)
%  disp( ' ')
%  end
%
%
%
%  function rtotalescalon(a,b)
%  % a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
%  % b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
% 
%  close all
%  tam=size(a);
%  tami=size(b);
% 
%  syms y(t) Y(s) x(t) X(s) Yy fp;
%  syms edd edi
%  edd=0;
%  edi=0;
%  xi=heaviside(t);
% 
%  for i=1:tam(2)
%    edd=edd+a(i)*s^(i-1)*Y(s);
%     for k=1:i-1
%         edd=edd-a(i)*(s^(i-1-k)*0*(k));
%     end
%  end
% 
%  for i=1:tami(2)
%     edi=edi+b(i)*s^(i-1)*X(s);
%  end
% 
%  edi=subs(edi,X(s), laplace(xi));
% 
% 
%  edd=collect(edd,Y(s));
%  edd=subs(edd,Y(s),Yy);
%  eq1=edd==edi;
% 
%  edd=solve(eq1, Yy);
%  pretty(simplify(edd));
% 
%  pretty(partfrac(edd));
% 
%  mensaje('Ruespuesta total al escalon')
%  disp('y(t)=')
%  y(t)=ilaplace(edd);
%  pretty(y(t))
%  fplot(y(t),'c','LineWidth',2)
%  title('Respuesta Total al Escalon')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
% 
%  end
% 
%  function mensaje(texto)
%  disp( ' ')
%  disp(texto)
%  disp( ' ')
%  end
%
%
%
%  function graficador5G(a,b,ciy,xi,t0)
%  % a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
%  % b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
%  % ciy condiciones iniciales de la salida de  menor a mayor [y(0), y(0)^(n-1)]
%  % xi función de entrada en terminos de la variable simbolica t previamente
%  % declarada en el command window
%  % t0 tiempo final para graficar la solucion, la derivada, y la segunda 
%  close all
%  tam=size(a);
%  tami=size(b);
%  syms H(s) P(s) Q(s) y(t);
%  H(s)=0;
%  P(s) = 0;
%  Q(s) = 0;
% 
%  for i=1:tam(2)
%     Q(s)=Q(s)+a(i)*(s)^(i-1);
%  end
% 
%  for i=1:tami(2)
%     P(s)=P(s)+b(i)*(s)^(i-1);
%  end
%  H(s) =  P(s)/Q(s);
%  %pretty(partfrac(H(s)));
% 
%  %mensaje('La Respuesta al impulso es')
%  %disp('y(t)=')
%  y(t)=ilaplace(H(s));
%  %pretty(y(t))
%  subplot(321)%--------------------
%  fplot(y,[0,t0],'r','LineWidth',2)
%  title('Respuesta al impulso')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
% 
% 
%  syms y(t) Y(s) x(t) X(s) Yy fp;
%  syms edd edi P(s) Q(s)
%  edd=0;
%  edi=0;
% 
%  for i=1:tam(2)
%     edd=edd+a(i)*s^(i-1)*Y(s);
%     for k=1:i-1
%         edd=edd-a(i)*(s^(i-1-k)*ciy(k));
%     end
%  end
%    
%  edd=collect(edd,Y(s));
%  edd=subs(edd,Y(s),Yy);
%  eq1=edd==edi;
% 
%  edd=solve(eq1, Yy);
% 
%  %pretty(partfrac(edd));
% 
%  %mensaje('La respuesta a entrada cero es')
%  %disp('y(t)=')
%  y(t)=ilaplace(edd);
%  %pretty(y(t))
%  subplot(322)%-------------------------
%  fplot(y,[0,t0],'g','LineWidth',2)
%  title('Respuesta a Entrada Cero')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
% 
% 
%  syms y(t) Y(s) x(t) X(s) Yy fp;
%  syms edd edi
%  edd=0;
%  edi=0;
%  xi_2=heaviside(t);
% 
%  for i=1:tam(2)
%     edd=edd+a(i)*s^(i-1)*Y(s);
%     for k=1:i-1
%         edd=edd-a(i)*(s^(i-1-k)*0*(k));
%     end
%  end
% 
%  for i=1:tami(2)
%     edi=edi+b(i)*s^(i-1)*X(s);
%  end
% 
%  edi=subs(edi,X(s), laplace(xi_2));
% 
% 
%  edd=collect(edd,Y(s));
%  edd=subs(edd,Y(s),Yy);
%  eq1=edd==edi;
% 
%  edd=solve(eq1, Yy);
%  %pretty(simplify(edd));
% 
%  %pretty(partfrac(edd));
% 
%  %mensaje('Ruespuesta total al escalon')
%  %disp('y(t)=')
%  y(t)=ilaplace(edd);
%  %pretty(y(t))
%  subplot(323)%-----------------------
%  fplot(y(t),[0,t0],'c','LineWidth',2)
%  title('Respuesta Total al Escalon')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
% 
% 
%  tam=size(a);
%  tami=size(b);
%  syms y(t) Y(s) x(t) X(s) Yy fp;
%  syms edd edi
%  edd=0;
%  edi=0;
% 
%  for i=1:tam(2)
%     edd=edd+a(i)*s^(i-1)*Y(s);
%     for k=1:i-1
%         edd=edd-a(i)*(s^(i-1-k)*ciy(k));
%     end
%  end
% 
%  for i=1:tami(2)
%     edi=edi+b(i)*s^(i-1)*X(s);
%  end
% 
%  edi=subs(edi,X(s), laplace(xi));
% 
% 
%  edd=collect(edd,Y(s));
%  edd=subs(edd,Y(s),Yy);
%  eq1=edd==edi;
%  edd=solve(eq1, Yy);
% 
% 
%  %mensaje('La respuesta total es')
%  %disp('y(t)=')
%  y(t)=ilaplace(edd);
%  %pretty(y(t))
%  subplot(324)
%  fplot(y(t),[0,t0],'b','LineWidth',2)
%  title('Respuesta Total')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
% 
% 
%  syms y(t) Y(s) x(t) X(s) Yy fp;
%  syms edd edi P(s) Q(s)
%  edd=0;
%  edi=0;
% 
%  for i=1:tam(2)
%     edd=edd+a(i)*s^(i-1)*Y(s);
%     for k=1:i-1
%         edd=edd-a(i)*(s^(i-1-k)*0);
%     end
%  end
% 
%  for i=1:tami(2)
%     edi=edi+b(i)*s^(i-1)*X(s);
%  end
% 
%  edi=subs(edi,X(s), laplace(xi));
% 
%  edd=collect(edd,Y(s));
%  edd=subs(edd,Y(s),Yy);
%  eq1=edd==edi;
%  edd=solve(eq1, Yy);
%  %pretty(simplify(edd));
% 
%  %pretty(partfrac(edd));
% 
%  %mensaje('La respuesta a estado cero es')
%  %disp('y(t)=')
%  y(t)=ilaplace(edd);
%  %pretty(y(t))
%  subplot(414)
%  fplot(xi,[0, t0],'b','LineWidth',2)
%  hold on
%  fplot(y,[0,t0],'r','LineWidth',2)
%  title('Respuesta a Estado Cero')
%  legend('Entrada x(t)','Salida y(t)','Location','Best')
%  xlabel('tiempo','FontWeight','bold','FontSize',16)
%  grid on
%  end