sets
i Producto i /i1,i2/
j Componente j/j1*j4/
k Planta k /k1*k3/
l Bodega l /l1*l4/
n Cd norte /n1*n3/
s Cd sur  /s1*s3/
or Cd oriente /or1*or3/
oc Cd occidente /oc1*oc3/
sn supermercado norte /sn1*sn3/
ss supermercado sur /ss1*ss3/
sor supermercado oriente /sor1*sor3/
soc supermercado occidente /soc1*soc3/

;

parameters
Costo_Producto costo de elbaroacion de producto i /i1 4000, i2 3500/
Costo_Comp costo del componente j/j1 10, j2 700, j3 1600, j4 1100/
Disp_Comp disponibilidad de componente j /j1 100000000, j2 20000000, j3 16000000, j4 24000000/
Cap_Planta capacidad de las plantas /k1 150000, k2 250000, k3 450000/
Cap_Bodega capacidad de las bodegas/l1 355000, l2 250000, l3 350000, l4 325000/
Cap_CD capacidades de los CD /m1 325000, m2 450000, m3 350000/
Demanda_Super demanda de los supermercados /n1 420000, n2 520000, n3 150000/


;

table Planta_bod(k,l) Mariz de costos de planta a bodega

    l1  l2  l3  l4
k1  15  48  45  35
k2  10  15  25  40
k3  5   20  10  25;

table Bod_cd_norte(l,n)

    n1  n2  n3
l1  25  30  35  
l2  150 200 250
l3  75  90  105
l4  75  90  105;

table Bod_cd_sur(l,s)

    s1  s2  s2
l1  150 200 250
l2  25  30  35
l3  75  90  105
l4  75  90  105;

table Bod_cd_oriente(l,or)

    or1 or2 or3
l1  75  90  105
l2  75  90  105
l3  25  30  35
l4  150 200 250;

table Bod_cd_occidente(l,oc)

    oc1 oc2 oc3
l1  75  90  105
l2  75  90  105 
l3  150 200 250
l4  25  30  35;

Variable
z1 FO;

Integer variable
x(i,j) numero tipo de producto i con el componente j
y(k,l) numero de productos transportadas de la planta k a la bodega l
z(l,n) numero de productos transportadas de la bodega l al CD norte
a(l,s) numero de productos transportadas de la bodega l al CD sur
b(l,or) numero de productos transportadas de la bodega l al CD oriente
c(l,oc) numero de productos transportadas de la bodega l al CD occidente
d(n,sn) numero de productos transportadas del cd norte a los supermercados norte
e(s,ss) numero de productos transportadas del cd sur a los supermercados sur
f(or,sor) numero de productos transportadas del cd oriente a los supermercados oriente
g(oc,soc) numero de productos transportadas del cd occidente a los supermercados occidente

;

Equation

R1 disponibilidad componentes
R2 cap bodega
R3 cap cd
R4 demanda cliente 1
R5 demanda cliente 2
R6 demanda cliente 3
R7 balance fabrica a bodega
R8 balance bodega a cliente
R9 Resriccion envio fabrica.cliente
R10
R11
R12
R13
R14

FO funcion objetivo;

*Restricciones de capacidad

R1..sum((i,j),x(i,j))=L=Disp_Comp;
R2(j)..sum(i,x(i,j))=L=cap_bodega(j);
R3(k)..sum(j,y(j,k))=L=cap_cd(k);

*Restricciones de demanda de clientes

R4..sum(k,z(k,"l1"))+sum(i,w(i,"l1"))=G=demanda_clientes("l1");
R5..sum(k,z(k,"l2"))+sum(i,w(i,"l2")) =G= demanda_clientes("l2") + C23;
R6..sum(k,z(k,"l3"))+sum(i,w(i,"l3"))+C23 =G= demanda_clientes("l3");

*Restricciones de balance

R7(j)..sum(i,x(i,j))=E=sum(k,y(j,k));
R8(k)..sum(j,y(j,k))=E=sum(l,z(k,l));

* Restriccion de envio fabrica-cliente
R9..w("i2","l1")=E=0;
R10..w("i1","l2")=E=0;
R11..w("i2","l2")=E=0;
R12..w("i1","l3")=E=0;
R13..z("k2","l1")=E=0;
R14..z("k1","l3")=E=0;

*Funcion objetivo

FO..z1=E=sum((i,j),x(i,j)*Fab_bod(i,j))+sum((j,k),y(j,k)*Bod_cd(j,k))+sum((k,l),z(k,l)*cd_cli(k,l))+sum((i,l),w(i,l)*Fab_cli(i,l))+(2*C23);

model taller1corte3 /all/;
solve taller1corte3 using MIP minimizing z1;