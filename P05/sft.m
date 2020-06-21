function sft(t0,tf,an,bn,a0,f,armo,a,b)
% t0 el valor inicial para calcular la serie
% tf el valor final donde calcular la serie
% dn función de la fórmula de los dn
% f función original
% armo número de armonicos a utilizar en la gráfica
% a, b intevalo para realizar la grafica de la serie

w0=2*pi/(tf-t0);

sf=a0;
t=a:0.0001:b;

for n=1:armo
    sf=sf+a0+an*cos(n*w0*t)+bn*sin(n*w0*t);
end
figure (1)
hFig = figure(1);
set(hFig, 'Position', [0 0 900 900])
subplot(4,4,[1,2])
plot(t,sf,'LineWidth',2)
legend('Serie de Fourier','Location','northoutside')
% xlabel('t','FontWeight','bold','FontSize',10)
axis auto
grid on

sf=d0;
t1=t0:0.0001:tf;

for n=1:armo
    sf=sf+a0+an*cos(n*w0*t)+bn*sin(n*w0*t);
end

subplot(4,4,[3,4])
plot(t1,f(t1),'r','LineWidth',2)
grid on
hold on
plot(t1,sf,'LineWidth',2)
legend('Función original','Serie de Fourier ','Location','northoutside')
xlabel('t','FontWeight','bold','FontSize',10)
nn=-armo:armo;
axis auto

subplot(4,4,[5,6])
e=f(t1)-sf;
plot(t1,e,'LineWidth',2)
title('Error','FontWeight','bold','FontSize',10)
xlabel('t','FontWeight','bold','FontSize',10)
axis auto
grid on

subplot(4,4,[7,8])
e=f(t1)-sf;
area(t1,e.^2)
legend('Energia del error','Location','northoutside')
xlabel('t','FontWeight','bold','FontSize',10)
axis auto
grid on

absdn=zeros(1,length(nn));
cont=1;
for i =-armo:armo
    if i==0
        absdn(cont)=a0;
    end
    
    absan(cont)=an(i);
    absbn(cont)=bn(i);
    cont=cont+1;
end

subplot(4,4,[9, 12])
stem(w0*nn,abs(absan),'LineWidth',2)
title('Espectro de magnitud D_n ','FontWeight','bold','FontSize',10)
% xlabel('\omega','FontWeight','bold','FontSize',10)
axis auto
grid on


subplot(4,4,[13,16]) 
stem(w0*nn,angle(absbn),'LineWidth',2) 
title('Espectro de fase, \angle de D_n ','FontWeight','bold','FontSize',10) 
xlabel('\omega','FontWeight','bold','FontSize',9)
axis auto
grid on

end