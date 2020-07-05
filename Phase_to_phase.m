clear all;
fprintf('\nEnter Line data:\n\n');
Line_length=input('Enter the Line length in km = ');
X1=input('Enter the Positive seq reactance reach of line in ohm/km, X1 = ');
R1=input('Enter the Positive seq resistance reach of line in ohm/km,R1 = ');
X0=input('Enter the Zero seq reactance reach of line in ohm/km, X0 = ');
R0=input('Enter the Zero seq resistance of line in ohm/km, R0 = ');
Arc_l=input('Enter the value of Arc length in meter for calculating Rarc = ');
Min_If=input('Enter the minimum Ph-Ph fault current for calc Rarc = ');
Fault_feed=input('Enter the fault feed= 1 or 2. 1 for sigle end, 2 for both end, = ');
CT_pri=input('Enter the Primary CT ratio current in A = ');
CT_sec=input('Enter the Secondary CT ratio current in A = ');
VT_pri=input('Enter the Primary VT ratio Voltage in kV = ');
VT_sec=input('Enter the Secondary VT ratio Voltage in V = ');
ArgDir=input('Enter the +ve angle of blinder in 4th quadrant for forward direction = ');
ArgNegDir=input('Enter the +ve angle of blinder in 2nd quadrant for forward direction = ');
Rf=input('Enter the Fault resistive reach in ohms, Rf = ');
Xf=input('Enter the Fault reactive reach in ohms, Xf = ');
VT_primary=VT_pri*10^3;
Rarc=(28707*Arc_l)/(Min_If^1.4);
RFPP=Rarc*Fault_feed;
QAng=(ArgNegDir-90);
% CTR/PTR ratio
CVR=(CT_pri/CT_sec)*(VT_sec/(VT_primary));
%calculation for Ph-Earth fault Zone-1 considering 80% of total length of the
%line ;
X1PP=Line_length*X1*0.8;
R1PP=Line_length*R1*0.8;
% for line impedance Phase to Phase loop
XPP=X1*Line_length;
RPP=R1*Line_length;
Zf=(Rf+i*Xf);
ZPP=RPP+i*XPP;
theta=(atan((XPP)/(RPP)));
Iinj=(VT_primary/(abs(Zf)));
Rb=Xf/tan(theta);
Zb=Rb+i*Xf;
Dis=Zb/ZPP;
fprintf('\n\nResult:\n\n');
fprintf('The L-N voltage in Primary is %6.2fkV at an angle %6.2fdeg \nThe fault current in Primary of each phase is %6.2fA \n',VT_pri/sqrt(3),angle(Zf)*180/pi,Iinj/2')
fprintf('The Distance to Fault is %5.3f km \n',Dis*Line_length)
%Test kit secondary value
fprintf('The value of Fault Impedance in Primary is Zf =%6.2f at an angle %6.2fdeg \n',abs(Zf),angle(Zf)*180/pi)
% For quadrant graph  ;
x11=RFPP/2;
x21=RFPP/2;
x31=RFPP/2+R1PP;
x41=-(tan(QAng*pi/180)*(X1PP));
y11=-(tan(ArgDir*pi/180) *(RFPP/2));
y21=0;
y31=X1PP;
y41=X1PP;
y51=0;
RD= [0, x11, x21, x31, x41,0];
XD= [0, y11, y21, y31, y41, y51];
line (RD, XD); hold on;
x111= [-x31*3, x31*3];
y111= [0,0];
line (x111, y111); hold on;
y112= [-x31*3, x31*3];
x112= [0,0];
line (x112, y112); hold on;
Zero=0;
A21=90;
A41=180;
fprintf ('The value of each Cartesian R for Test kit     R1 =%6.2f R2 =%6.2f R3 =%6.2f R4 =%6.2f R5 =%6.2f \n', Zero, x11, x11, Zero, Zero);
fprintf ('The value of each Cartesian X for Test kit     X1 =%6.2f X2 =%6.2f X3 =%6.2f X4 =%6.2f X5 =%6.2f \n', Zero, Zero, Zero, y41, Zero);
fprintf ('The value of each Cartesian Angle for Test kit Ang1=%6.2f Ang2=%6.2f Ang3=%6.2f Ang4=%6.2f Ang5=%6.2f \n', -ArgDir, A21, theta*180/pi, A41, (ArgNegDir-A41));
plot(Rf,Xf,'ro')



