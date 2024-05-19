sets
i Producto i /i1,i2/
j Componente j/j1*j4/
k Planta k /k1*k3/
l Bodega l /l1*l4/
n Cd norte /n1*n3/
s Cd sur  /s1*s3/
es Cd este /es1*es3/
oc Cd occidente /oc1*oc3/
sn supermercado norte /sn1*sn3/
ss supermercado sur /ss1*ss3/
ses supermercado este /ses1*ses3/
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
Costo_Fijo_Planta /500/;


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
b(l,es) numero de productos transportadas de la bodega l al CD este
c(l,oc) numero de productos transportadas de la bodega l al CD occidente
d(n,sn) numero de productos transportadas del cd norte a los supermercados norte
e(s,ss) numero de productos transportadas del cd sur a los supermercados sur
f(or,ses) numero de productos transportadas del cd oriente a los supermercados este
g(oc,soc) numero de productos transportadas del cd occidente a los supermercados occidente

;

Equations
    FO funcion objetivo
    R1(j) disponibilidad de componentes
    R2(l) capacidad de bodega
    R3(n) capacidad de CD norte
    R4(s) capacidad de CD sur
    R5(es) capacidad de CD este
    R6(oc) capacidad de CD occidente
    R7(sn) demanda de supermercados norte
    R8(ss) demanda de supermercados sur
    R9(ses) demanda de supermercados este
    R10(soc) demanda de supermercados occidente
    R11(k) capacidad de plantas
    Balance_Planta(k)
    Balance_Bodega(l)
    Balance_CD_Norte(n)
    Balance_CD_Sur(s)
    Balance_CD_Oriente(or)
    Balance_CD_Occidente(oc)
    Restriccion_Producto1_Componente1
    Restriccion_Producto1_Componente2
    Restriccion_Producto1_Componente3
    Restriccion_Producto1_Componente4
    Restriccion_Producto2_Componente1
    Restriccion_Producto2_Componente2
    Restriccion_Producto2_Componente3
    Restriccion_Producto2_Componente4
    ;

FO..z1 =e= sum((i,j), x(i,j)*Costo_Comp(j)+ x(i,j)*Costo_Fijo_Planta)) 
         + sum((k,l), y(k,l)*Planta_Bod(k,l)) 
         + sum((l,n), z(l,n)*Bod_CD_Norte(l,n)) 
         + sum((l,s), a(l,s)*Bod_CD_Sur(l,s)) 
         + sum((l,es), b(l,es)*Bod_CD_Oriente(l,es)) 
         + sum((l,oc), c(l,oc)*Bod_CD_Occidente(l,oc))
         + sum((n,sn), d(n,sn)*Demanda_Super(sn))
         + sum((s,ss), e(s,ss)*Demanda_Super(ss))
         + sum((es,ses), f(es,ses)*Demanda_Super(ses))
         + sum((oc,soc), g(oc,soc)*Demanda_Super(soc));
         
* Restricciones de disponibilidad de componentes
R1(j)..
    sum(i, x(i,j)) =l= Disp_Comp(j);

* Restricciones de capacidad de bodegas
R2(l)..
    sum(k, y(k,l)) =l= Cap_Bodega(l);

* Restricciones de capacidad de CD norte
R3(n)..
    sum(l, z(l,n)) =l= Cap_CD(n);

* Restricciones de capacidad de CD sur
R4(s)..
    sum(l, a(l,s)) =l= Cap_CD(s);

* Restricciones de capacidad de CD este
R5(es)..
    sum(l, b(l,es)) =l= Cap_CD(es);

* Restricciones de capacidad de CD occidente
R6(oc)..
    sum(l, c(l,oc)) =l= Cap_CD(oc);

* Restricciones de demanda de supermercados norte
R7(sn)..
    sum(n, d(n,sn)) =g= Demanda_Super(sn);

* Restricciones de demanda de supermercados sur
R8(ss)..
    sum(s, e(s,ss)) =g= Demanda_Super(ss);

* Restricciones de demanda de supermercados este
R9(ses)..
    sum(es, f(es,ses)) =g= Demanda_Super(ses);

* Restricciones de demanda de supermercados occidente
R10(soc)..
    sum(oc, g(oc,soc)) =g= Demanda_Super(soc);

* Restricciones de capacidad de plantas
R11(k)..
    sum(i, x(i,j)) =l= Cap_Planta(k);

* Restricción para el producto de tipo 1 con el componente 1
Restriccion_Producto1_Componente1 ..
    x('i1', 'j1') =l= 0.4 * sum(j, x('i1', j));

* Restricción para el producto de tipo 1 con el componente 2
Restriccion_Producto1_Componente2 ..
    x('i1', 'j2') =l= 0.2 * sum(j, x('i1', j));

* Restricción para el producto de tipo 1 con el componente 3
Restriccion_Producto1_Componente3 ..
    x('i1', 'j3') =l= 0.2 * sum(j, x('i1', j));

* Restricción para el producto de tipo 1 con el componente 4
Restriccion_Producto1_Componente4 ..
    x('i1', 'j4') =g= 1 - 0.4 - 0.2 - 0.2 * sum(j, x('i1', j));

* Restricción para el producto de tipo 2 con el componente 1
Restriccion_Producto2_Componente1 ..
    x('i2', 'j1') =l= 0.3 * sum(j, x('i2', j));
    
* Restricción para el producto de tipo 2 con el componente 2
Restriccion_Producto2_Componente2 ..
    x('i2','j2')=L=0.25*sum((j,x('i2',j));)
    
* Restricción para el producto de tipo 2 con el componente 3
Restriccion_Producto2_Componente3 ..
    x('i2','j3')=L=0.2*sum((j,x('i2',j));)
    
* Restricción para el producto de tipo 2 con el componente 4
Restriccion_Producto2_Componente4 ..
    x('i2','j4')=L=0.25*sum((j,x('i2',j));)
    
model tallerfinal /all/;
solve tallerfinal using MIP minimizing z1;


