clear all;
K = [ 0.13 0.46 0.63]; 
% [5.13025718870210,5.00005693573576,0.000206770721584062]
% [16.6637228561278,9.99507713207827,0.000188732555003929]
% [8.33667801082710,5.00009137228757,0.000206455484624513]
Ti = [ 5.0 10 5.00];
Td = [0.0002 0.0002 0.0002];

%inicjalizacja
%Punkt Pracy
Upp=0;
Ypp=0;

%Ograniczenia
% u_min=-1;
% u_max=1;
% u_max=u_max-Upp;
% u_min=u_min-Upp;

kk=400; %d�ugo�� symulacji

%deklaracja wektor�w sygna��w oraz b��d�w
U{1}=zeros(1, kk);
U{2}=zeros(1, kk);
U{3}=zeros(1, kk);
U{4}=zeros(1, kk);
U{1}(1:kk)=Upp;
U{2}(1:kk)=Upp;
U{3}(1:kk)=Upp;
U{4}(1:kk)=Upp;
Y{1}=zeros(1, kk);
Y{2}=zeros(1, kk);
Y{3}=zeros(1, kk);
Y{1}(1:11)=Ypp;
Y{2}(1:11)=Ypp;
Y{3}(1:11)=Ypp;

e{1}=zeros(1, kk);
e{2}=zeros(1, kk);
e{3}=zeros(1, kk);
yzad{1}=zeros(1, kk);
yzad{2}=zeros(1, kk);
yzad{3}=zeros(1, kk);
u{1}=zeros(1,kk);
u{2}=zeros(1,kk);
u{3}=zeros(1,kk);
u{4}=zeros(1,kk);

% yzad(round(1*kk/7):round(2*kk/7))=4;
% yzad(round(2*kk/7):round(3*kk/7))=0;
% yzad(round(3*kk/7):round(4*kk/7))=0.2;
% yzad(round(4*kk/7):round(5*kk/7))=1.1;
% yzad(round(5*kk/7):round(7*kk/7))=3;
yzad{1}(2*kk/5:3*kk/5)=1;
yzad{1}(4*kk/5:5*kk/5)=2;
yzad{2}(2*kk/5:3*kk/5)=3;
yzad{2}(4*kk/5:5*kk/5)=4;
yzad{3}(1*kk/5:2*kk/5)=-1;
yzad{3}(3*kk/5:5*kk/5)=-2;

yzad{1}=yzad{1}-Ypp;
yzad{2}=yzad{2}-Ypp;
yzad{3}=yzad{3}-Ypp;

T=0.5;
r0=[0; 0; 0;]; r1=[0; 0; 0;]; r2=[0; 0; 0;];

for i=1:3
    r2(i)=K(i)*Td(i)/T;
    r1(i)=K(i)*(T/(2*Ti(i))-2*Td(i)/T-1);
    r0(i)=K(i)*(1+T/(2*Ti(i))+Td(i)/T);
end

for k=5:kk %g��wna p�tla symulacyjna
    %symulacja obiektu    
            [Y{1}(k),Y{2}(k),Y{3}(k)] = symulacja_obiektu5( ...
            U{1}(k-1),U{1}(k-2),U{1}(k-3),U{1}(k-4),...
            U{2}(k-1),U{2}(k-2),U{2}(k-3),U{2}(k-4),...
            U{3}(k-1),U{3}(k-2),U{3}(k-3),U{3}(k-4),...
            U{4}(k-1),U{4}(k-2),U{4}(k-3),U{4}(k-4),...
            Y{1}(k-1),Y{1}(k-2),Y{1}(k-3),Y{1}(k-4),...
            Y{2}(k-1),Y{2}(k-2),Y{2}(k-3),Y{2}(k-4),...
            Y{3}(k-1),Y{3}(k-2),Y{3}(k-3),Y{3}(k-4));  
    
    for i=1:3
        y{i}(k)=Y{i}(k)-Ypp;
    end
    
    %uchyb regulacji
    for i=1:3
        e{i}(k)=yzad{i}(k)-y{i}(k);
    end
    
    %sygna� steruj�cy regulatora PID
    %u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
    for i=1:3
        delta_u{i}= r2(i)*e{i}(k-2)+r1(i)*e{i}(k-1)+r0(i)*e{i}(k);
    end
    
   
    u{1}(k)=delta_u{1}+u{1}(k-1);
    u{2}(k)=delta_u{2}+u{2}(k-1);
    u{4}(k)=delta_u{3}+u{4}(k-1);
   
    
%     if u(k)>u_max
%         u(k)=u_max;
%     elseif u(k)<u_min
%         u(k)=u_min;
%     end
    
%     U{1}(k)=u{1}(k)+Upp;
%     U{2}(k)=u{2}(k)+Upp;
%     U{4}(k)=u{4}(k)+Upp;
    U{1}(k)=u{1}(k)+Upp;
    U{2}(k)=u{2}(k)+Upp;
    U{4}(k)=u{4}(k)+Upp;
    
    
end

for i=1:3
    wskaznik_jakosci{i}=sum(e{i}.^2);
end   

% figure 
hold on;
for i=1:3
    subplot(7,1,i); stairs(Y{i});title(sprintf('Warto�� wyj�cia Y%d(k)',i));xlabel('k');ylabel('warto�� sygna�u');ylim([-5,5]);
    hold on;plot(yzad{i});
end
for i=1:4
    subplot(7,1,i+3); stairs(U{i});title(sprintf('Warto�� wej�cia U%d(k)',i));xlabel('k');ylabel('warto�� sygna�u');ylim([-5,5]);
end
hold off