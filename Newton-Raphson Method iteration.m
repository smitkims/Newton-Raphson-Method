clear all; clc;

%Ybus elements
Y11 = 30; Y12 = 20; Y13 = 10; Y14 = 0;
Y21 = 20; Y22 = 60; Y23 = 0; Y24 = 40;
Y31 = 10; Y32 = 0; Y33 = 20; Y34 = 20;
Y41 = 0; Y42 = 40; Y43 = 20; Y44 = 60;
t11 = -pi/2; t12 = pi/2; t13 = pi/2; t14 = pi/2;
t21 = pi/2; t22 = -pi/2; t23 = pi/2; t24 = pi/2;
t31 = pi/2; t32 = pi/2; t33 = -pi/2; t34 = pi/2;
t41 = pi/2; t42 = pi/2; t43 = pi/2; t44 = -pi/2;

%initial values
v1 = 1.05; v2 = 1.02; v3 = 1.0; v4 = 1.0;
p2 = 0.7; p3 = -0.5; q3 = -0.1; p4 = -0.7; q4 = -0.2;
d1 = 0; d2 = 0; d3 = 0; d4 = 0;
N = [d2; d3; d4; v3; v4];

%iteration process
for m = 1:3
    fp2 = Y21*v1*v2*cos(t21 + d1 - d2) + Y22*v2*v2*cos(t22)...
        + Y23*v3*v2*cos(t23 + d3 - d2) + Y24*v4*v2*cos(t24 + d4 - d2) - p2;
    
    fp3 = Y31*v1*v3*cos(t31 + d1 - d3) + Y32*v2*v3*cos(t32 + d2 - d3)...
        + Y33*v3*v3*cos(t33) + Y34*v4*v3*cos(t34 + d4 - d3) - p3;
    
    fp4 = Y41*v1*v4*cos(t41 + d1 - d4) + Y42*v2*v4*cos(t42 + d2 - d4)...
        + Y43*v3*v4*cos(t43 + d3 - d4) + Y44*v4*v4*cos(t44) - p4;
    
    fq3 = -Y31*v1*v3*sin(t31 + d1 - d3) - Y32*v2*v3*sin(t32 + d2 - d3)...
        - Y33*v3*v3*sin(t33) - Y34*v4*v3*sin(t34 + d4 - d3) - q3;
    
    fq4 = -Y41*v1*v4*sin(t41 + d1 - d4) - Y42*v2*v4*sin(t42 + d2 - d4)...
        - Y43*v3*v4*sin(t43 + d3 - d4) - Y44*v4*v4*sin(t44) - q4;
    
    J11 = Y21*v1*v2*sin(t21 + d1 - d2) + Y23*v3*v2*sin(t23 + d3 - d2)... 
    + Y24*v4*v2*sin(t24 + d4 - d2);
    J12 = -Y23*v3*v2*sin(t23 + d3 - d2);
    J13 = -Y24*v4*v2*sin(t24 + d4 - d2);
    J14 = Y23*v2*cos(t23 + d3 - d2);
    J15 = Y24*v2*cos(t24 + d4 - d2);
    
    J21 = -Y32*v2*v3*sin(t32 + d3 - d2);
    J22 = Y31*v1*v3*sin(t31 + d1 - d3) + Y32*v2*v3*sin(t32 + d3 - d2)...
        + Y34*v4*v3*sin(t34 + d4 - d3);
    J23 = -Y34*v4*v3*sin(t34 + d4 - d3);
    J24 = Y31*v1*cos(t31 + d1 - d3) + Y32*v2*cos(t32 + d3 - d2)...
        + Y33*v3*cos(t33) + 2*Y34*v4*cos(t34 + d4 - d3);
    J25 = Y34*v3*cos(t34 + d4 - d3);
    
    J31 = -Y42*v2*v4*sin(t42 + d2 - d4);
    J32 = -Y43*v3*v4*sin(t43 + d3 - d4);
    J33 = Y41*v1*v4*sin(t41 + d1 - d4) + Y42*v2*v4*sin(t42 + d2 - d4)...
        + Y43*v3*v4*sin(t43 + d3 - d4);
    J34 = Y43*v3*v4*cos(t43 + d3 - d4);
    J35 = Y41*v1*cos(t41 + d1 - d4) + Y42*v2*cos(t42 + d2 - d4)...
        + Y43*v3*cos(t43 + d3 - d4) + 2*Y44*v4*cos(t44);
    
    J41 = -Y32*v2*v3*cos(t32 + d2 - d3);
    J42 = Y31*v1*v3*cos(t31 + d1 - d3) + Y32*v2*v3*cos(t32 + d2 - d3)...
        + Y34*v4*v3*cos(t34 + d4 - d3);
    J43 = -Y34*v4*v3*cos(t34 + d4 - d3);
    J44 = -Y31*v1*sin(t31 + d1 - d3) - Y32*v2*sin(t32 + d2 - d3)...
        - 2*Y33*v3*sin(t33) - Y34*v4*sin(t34 + d4 - d3);
    J45 = - Y34*v3*sin(t34 + d4 - d3);
    
    J51 = - Y42*v2*v4*cos(t42 + d2 - d4);
    J52 = - Y43*v3*v4*cos(t43 + d3 - d4);
    J53 = Y41*v1*v4*cos(t41 + d1 - d4) + Y42*v2*v4*cos(t42 + d2 - d4)...
        + Y43*v3*v4*cos(t43 + d3 - d4);
    J54 = - Y43*v4*sin(t43 + d3 - d4);
    J55 = -Y41*v1*sin(t41 + d1 - d4) - Y42*v2*sin(t42 + d2 - d4)...
        - Y43*v3*sin(t43 + d3 - d4) - 2*Y44*v4*sin(t44);
    
    fx = [fp2; fp3; fp4; fq3; fq4];
    J = [J11 J12 J13 J14 J15; J21 J22 J23 J24 J25;
        J31 J32 J33 J34 J35; J41 J42 J43 J44 J45; J51 J52 J53 J54 J55];
    
    N = N - J\fx;
    d2 = N(1); d3 = N(2); d4 = N(3); v3 = N(4); v4 = N(5);
    
    disp(N)
    disp(' ')
    
end
disp('v3')
disp(N(4))
disp('v4')
disp(N(5))
disp('delta2')
disp(N(1)*180/pi)
disp('delta3')
disp(N(2)*180/pi)
disp('delta4')
disp(N(3)*180/pi)