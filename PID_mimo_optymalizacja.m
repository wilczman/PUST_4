x0 = [1, 1, 1];
lb = [0.0001 0.0001 0.0001];
nr=4;
[nastawy_PID_fmincon,E]=fmincon((@(parameters) PID_mimo_fun(parameters,nr)),x0,[],[],[],[],lb,[]);
%[nastawy_PID_ga, ~, ~] = ga((@(parameters) PID_fun(parameters)), 3, [], [], [], [], [0 0.1 0], []);
save('optymalne_parametry_PID_zad3.mat', 'nastawy_PID_fmincon');

