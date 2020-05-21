clear all;
K = [ 1 1 1];
Ti = [ 1 1 1];
Td = [ 1 1 1];

%inicjalizacja
%Punkt Pracy
Upp=0;
Ypp=0;

%Ograniczenia
% u_min=-1;
% u_max=1;
% u_max=u_max-Upp;
% u_min=u_min-Upp;

kk=400; %d³ugoœæ symulacji

%deklaracja wektorów sygna³ów oraz b³êdów
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

% yzad(round(1*kk/7):round(2*kk/7))=4;
% yzad(round(2*kk/7):round(3*kk/7))=0;
% yzad(round(3*kk/7):round(4*kk/7))=0.2;
% yzad(round(4*kk/7):round(5*kk/7))=1.1;
% yzad(round(5*kk/7):round(7*kk/7))=3;
yzad{1}(1:kk/2)=1;
yzad{2}(1:kk/2)=1;
yzad{3}(1:kk/2)=1;
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

for k=5:kk %g³ówna pêtla symulacyjna
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
    
    %sygna³ steruj¹cy regulatora PID
    %u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
    for i=1:3
        delta_u{i}=r2(i)*e{i}(k-2)+r1(i)*e{i}(k-1)+r0(i)*e{i}(k);
    end
    
    for i=1:3
    	u{i}(k)=delta_u{i}+u{i}(k-1);
    end
    
%     if u(k)>u_max
%         u(k)=u_max;
%     elseif u(k)<u_min
%         u(k)=u_min;
%     end
    for i=1:3
        U{i}(k)=u{i}(k)+Upp;
    end
end

for i=1:3
    wskaznik_jakosci{i}=sum(e{i}.^2);
end   


