x0 = [2, 22, 5];
lb = [0.001 0.001 0.001];

[nastawy_PID_fmincon,E]=fmincon((@(parameters) PID_mimo_fun(parameters)),x0,[],[],[],[],lb,[]);
%[nastawy_PID_ga, ~, ~] = ga((@(parameters) PID_fun(parameters)), 3, [], [], [], [], [0 0.1 0], []);
save('optymalne_parametry_PID_zad3.mat', 'nastawy_PID_fmincon');

