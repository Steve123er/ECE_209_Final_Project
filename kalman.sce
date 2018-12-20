//Adapted from Stack Exchange
// Signal Model
DeltaT = 0.1;
F = [1 DeltaT; 0 1];
G = [DeltaT^2; DeltaT];
H = [1 0];

x0 = [0;0];
sigma_a = 75;

Q = sigma_a^2;
R = 75;

N = 1000;

a = rand(1,N,"normal")*sigma_a;


// Kalman Filter
p0 = 100*eye(2,2);

xx(:,1) = x0;
pp = p0;
pp_norm(1) = norm(pp);
for t=1:1001,
    [x1,p1,x,p] = kalm(unnamed0(t),xx(:,t),pp,F,G,H,Q,R);//unnamed is the data set that I had
    xx(:,t+1) = x1;
    pp = p1;
    pp_norm(t+1) = norm(pp);
end


plot(unnamed0(:,1),"b")

plot(xx(1,1:1001),"r")
