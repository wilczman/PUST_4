function wskaznik_jakosci=PID_mimo_fun(parameters)
    nr=3;    
    K = [ 0; 0; 0;]; %K = [ 0.1765 0.282 1.1302];
    Ti = [ 1; 1; 1;];
    Td = [ 1; 1; 1;];
    K(nr)   =   parameters(1);
    Ti(nr)  =   parameters(2);
    Td(nr)  =   parameters(3);

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
    
ny=3;
nu=4;
yzad=[1 1 1];

load('rw_odp_skok_aproks.mat', 'GT_aproksym')

D=150; N=50; Nu=35; lambda=20;
Upp=[0 0];
Ypp=[0  0];

S=cell(N+D-1,1);
for i=1:N+D-1
    S{i}=[GT_aproksym(i,1),   GT_aproksym(i,3);...
          GT_aproksym(i,2),   GT_aproksym(i,4)];
end

Mcell=cell(N, Nu);
for i=1:N
    for j=1:Nu
        Mcell{i,j}=zeros(2,2);
    end
end
i=0;
for j=1:Nu  %wypelnianie macierzy trojkatnej dolnej M
   Mcell(j:N,j)=S(1:N-i);  
   i=i+1;
end
M=cell2mat(Mcell);


Mpcell=cell(N,(D-1));     
for j=1:N %wypelnianie macierzy Mp
   for i=1:D-1
       Mpcell{j, i}=cell2mat(S(j+i))-cell2mat(S(i));    
   end
end
Mp=cell2mat(Mpcell);

psi=1;
bigPsi=eye(N*ny,N*ny)*psi;

bigLambda=eye(Nu*nu,Nu*nu)*lambda;
Yzad=zeros(N*ny,1);
Y_ptak=zeros(N*ny,1);
deltaU=zeros(Nu*nu,1);
deltaUP=zeros((D-1)*nu,1);
K=inv(M'*bigPsi*M+bigLambda)*M'*bigPsi;
K1=K(1:nu,:);

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
    
        yzad(k,:)=yzad(k,:)-Ypp; 
        y=Y(k,:)-Ypp;
        %e=yzad(k,:)-y(k,:);
        Yzad=repmat(yzad(k,:)',N, 1);
        Y_wek=repmat(y',N,1);
        
        if k>2
            deltaUP(3:nu*(D-1), 1)=deltaUP(1:nu*(D-1)-nu, 1);
            deltaUP(1:2,1) = u(k-1,:)'-u(k-2,:)';
        elseif k==2
            deltaUP(1:2,1)=u(k-1,:)';
        end

        Y0=Y_wek+Mp*deltaUP;
        deltaU=K*(Yzad-Y0);
        deltaY=M*deltaU;
        
        Y_ptak=Y0+deltaY;
        
        delta_u=K1*(Yzad-Y_wek-Mp*deltaUP);
    
        u(k,:)=u(k-1,:)+delta_u';
    
    
end