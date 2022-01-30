%PID controller all methodes
%--------------------------------
%order reduction functions
s=tf('s');
G_main=10/(s+1)/(s+2)/(s+3)/(s+4);
%G_main=1/(s+1)^4;G1_main=G_main/s;%for FOIPDT models

nr=0;%orders of numerator
nd=1;%orders of denominator
key_delay=1;%key_delay= 0:NO delay , 1:with delay
G_opt=opt_app(G_main,nr,nd,key_delay);
[n,d]=tfdata(G_opt,'v');
K_opt =dcgain(G_main);T_opt=d(1)/d(2);L_opt=G_opt.ioDelay;

[K_fr,L_fr,T_fr]=get_fod(G_main);%frequency method
G_fr=tf(K_fr,[T_fr,1]);
G_fr.ioDelay=L_fr;

[K_tf,L_tf,T_tf]=get_fod(G_main,1);%transfer function method
G_tf=tf(K_tf,[T_tf,1]);
G_tf.ioDelay=L_tf;

figure(1)
step(G_main,G_opt,G_fr,G_tf);
legend show

[Kc,pp,Wpc,Wgc]=margin(G_main);
Tc=2*pi/Wpc;
N=10;

%get IDT
%[K,L] = get_ipd(G_main);G_IDT=K*exp(-L*s)/s;


%% PID design
%choosing the valid model
%valid_model= 1:opt_app , 2:get_fod frequency , 3:get_fod tf
valid_model=1;
switch valid_model
    case 1
        K=K_opt;L=L_opt;T=T_opt;
    case 2
        K=K_fr;L=L_fr;T=T_fr;
    case 3
        K=K_tf;L=L_tf;T=T_tf;
end
N=10;
figure(2)
hold on;
legend show;
%----------------------------------------------------------------------------
%Ziegler Nichols
%method_ZN = 1:frequency , 2:FOPDT , 3:modified 
%key_ZN= 1:P , 2:PI , 3:PID , 4:PI-D
%If you are obtaining a PI-D, be careful about Gc & H
%If you are using Modified ZN, you should initialize pb in degrees
%If you are using Modified ZN,you should use 2,3,4 for key

method_ZN = 2;
key_ZN= 2;
switch method_ZN
    case 1,%frequency
        vars_ZN = [Kc,Tc,N];
        switch key_ZN
            case 1,[Gc_ZN1_P,~,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN1_P = feedback(Gc_ZN1_P*G_main,1);Gcl_ZN1_P.name = 'frequency ZN P';step(Gcl_ZN1_P);
            case 2,[Gc_ZN1_PI,~,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN1_PI = feedback(Gc_ZN1_PI*G_main,1);Gcl_ZN1_PI.name = 'frequency ZN PI';step(Gcl_ZN1_PI);
            case 3,[Gc_ZN1_PID,~,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN1_PID = feedback(Gc_ZN1_PID*G_main,1);Gcl_ZN1_PID.name = 'frequency ZN PID'; step(Gcl_ZN1_PID);  
            case 4,[Gc_ZN1_PI_D,H_ZN1_PI_D,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN1_PI_D = feedback(Gc_ZN1_PI_D*G_main,H_ZN1_PI_D);Gcl_ZN1_PI_D.name = 'frequency ZN PI-D';step(Gcl_ZN1_PI_D);
        end  
        
    case 2,%FOPDT 
        vars_ZN = [K,L,T,N];
        switch key_ZN
            case 1,[Gc_ZN2_P,~,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN2_P = feedback(Gc_ZN2_P*G_main,1);Gcl_ZN2_P.name = 'FOPDT ZN P';step(Gcl_ZN2_P);
            case 2,[Gc_ZN2_PI,~,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN2_PI = feedback(Gc_ZN2_PI*G_main,1);Gcl_ZN2_PI.name = 'FOPDT ZN PI';step(Gcl_ZN2_PI);
            case 3,[Gc_ZN2_PID,~,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN2_PID = feedback(Gc_ZN2_PID*G_main,1);Gcl_ZN2_PID.name = 'FOPDT ZN PID';step(Gcl_ZN2_PID);   
            case 4,[Gc_ZN2_PI_D,H_ZN2_PI_D,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN2_PI_D = feedback(Gc_ZN2_PI_D*G_main,H_ZN2_PI_D);Gcl_ZN2_PI_D.name = 'FOPDT ZN PI-D';step(Gcl_ZN2_PI_D);
        end
    case 3,%modified
        vars_ZN = [Kc,Tc,rb,pb,N];
        switch key_ZN
            case 2,[Gc_ZN3_PI,~,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN3_PI = feedback(Gc_ZN3_PI*G_main,1);Gcl_ZN3_PI.name = 'modified ZN PI';step(Gcl_ZN3_PI);
            case 3,[Gc_ZN3_PID,~,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN3_PID = feedback(Gc_ZN3_PID*G_main,1);Gcl_ZN3_PID.name = 'modified ZN PID'; step(Gcl_ZN3_PID);  
            case 4,[Gc_ZN3_PI_D,H_ZN3_PI_D,~,~,~]=ziegler_nic(key_ZN,vars_ZN);Gcl_ZN3_PI_D = feedback(Gc_ZN3_PI_D*G_main,H_ZN3_PI_D);Gcl_ZN3_PI_D.name = 'modified ZN PI-D';step(Gcl_ZN3_PI_D);
        end
end

%------------------------------------------------------------------------
%Refined ZN
%If you are using Refined ZN, be careful about Gc & H !
vars_rZN=[K,L,T,N,Kc,Tc];
[Gc_rZN_PID,H_rZN_PID,~,~,~,~]=rziegler_nic(vars_rZN);
Gcl_rZN_PID = feedback(Gc_rZN_PID*G_main,H_rZN_PID);
Gcl_rZN_PID.name = 'Refined ZN PID'; step(Gcl_rZN_PID);

%-----------------------------------------------------------------------
%CC (Cohen-Coon)
%method_CC = 1:CC , 2:CC revisited
%key_CC= 1:P , 2:PI , 3:PID , 4:PI-D , 5:PD(just for CC revisited)
%If you are obtaining a PI-D, be careful about Gc & H
method_CC = 2;
key_CC= 2;
vars_CC = [K,L,T,N];
switch method_CC
    case 1,%CC
        switch key_CC
            case 1,[Gc_CC_P,~,~,~,~]=cohen_pid(key_CC,method_CC,vars_CC);Gcl_CC_P = feedback(Gc_CC_P*G_main,1);Gcl_CC_P.name = 'CC P';step(Gcl_CC_P);
            case 2,[Gc_CC_PI,~,~,~,~]=cohen_pid(key_CC,method_CC,vars_CC);Gcl_CC_PI = feedback(Gc_CC_PI*G_main,1);Gcl_CC_PI.name = 'CC PI';step(Gcl_CC_PI);
            case 3,[Gc_CC_PID,~,~,~,~]=cohen_pid(key_CC,method_CC,vars_CC);Gcl_CC_PID = feedback(Gc_CC_PID*G_main,1);Gcl_CC_PID.name = 'CC PID'; step(Gcl_CC_PID);  
            case 4,[Gc_CC_PI_D,H_CC_PI_D,~,~,~]=cohen_pid(key_CC,method_CC,vars_CC);Gcl_CC_PI_D = feedback(Gc_CC_PI_D*G_main,H_CC_PI_D);Gcl_CC_PI_D.name = 'CC PI-D';step(Gcl_CC_PI_D);
        end  
        
    case 2,%CC revisited
        switch key_CC
            case 1,[Gc_CC_rev_P,~,~,~,~]=cohen_pid(key_CC,method_CC,vars_CC);Gcl_CC_rev_P = feedback(Gc_CC_rev_P*G_main,1);Gcl_CC_rev_P.name = 'CC rev P';step(Gcl_CC_rev_P);
            case 2,[Gc_CC_rev_PI,~,~,~,~]=cohen_pid(key_CC,method_CC,vars_CC);Gcl_CC_rev_PI = feedback(Gc_CC_rev_PI*G_main,1);Gcl_CC_rev_PI.name = 'CC rev PI';step(Gcl_CC_rev_PI);
            case 3,[Gc_CC_rev_PID,~,~,~,~]=cohen_pid(key_CC,method_CC,vars_CC);Gcl_CC_rev_PID = feedback(Gc_CC_rev_PID*G_main,1);Gcl_CC_rev_PID.name = 'CC rev PID';step(Gcl_CC_rev_PID);   
            case 4,[Gc_CC_rev_PI_D,H_CC_rev_PI_D,~,~,~]=cohen_pid(key_CC,method_CC,vars_CC);Gcl_CC_rev_PI_D = feedback(Gc_CC_rev_PI_D*G_main,H_CC_rev_PI_D);Gcl_CC_rev_PI_D.name = 'CC rev PI-D';step(Gcl_CC_rev_PI_D);
            case 5,[Gc_CC_rev_PD,~,~,~,~]=cohen_pid(key_CC,method_CC,vars_CC);Gcl_CC_rev_PD = feedback(Gc_CC_rev_PD*G_main,1);Gcl_CC_rev_PD.name = 'CC rev PD';step(Gcl_CC_rev_PD);
        end
end
        
%-------------------------------------------------------------------------
%AH (Astrom-Hagglund)
%method_AH = 1:FOPDT , 2:frequency
%key_AH= 1:PI , 2:PID 
method_AH = 2;
key_AH= 2;
switch method_AH
    case 1,%FOPDT
        vars_AH = [K,L,T,N];
        switch key_AH
            case 1,[Gc_AH_FOPDT_PI,~,~,~,~]=astrom_hagglund(key_AH,method_AH,vars_AH);Gcl_AH_FOPDT_PI = feedback(Gc_AH_FOPDT_PI*G_main,1);Gcl_AH_FOPDT_PI.name = 'AH FOPDT PI';step(Gcl_AH_FOPDT_PI);
            case 2,[Gc_AH_FOPDT_PID,~,~,~,~]=astrom_hagglund(key_AH,method_AH,vars_AH);Gcl_AH_FOPDT_PID = feedback(Gc_AH_FOPDT_PID*G_main,1);Gcl_AH_FOPDT_PID.name = 'AH FOPDT PID'; step(Gcl_AH_FOPDT_PID);  
        end  
        
    case 2,%AH frequency
        vars_AH = [K,Kc,Tc,N];
        switch key_AH
            case 1,[Gc_AH_fre_PI,~,~,~,~]=astrom_hagglund(key_AH,method_AH,vars_AH);Gcl_AH_fre_PI = feedback(Gc_AH_fre_PI*G_main,1);Gcl_AH_fre_PI.name = 'AH frequency PI';step(Gcl_AH_fre_PI);
            case 2,[Gc_AH_fre_PID,~,~,~,~]=astrom_hagglund(key_AH,method_AH,vars_AH);Gcl_AH_fre_PID = feedback(Gc_AH_fre_PID*G_main,1);Gcl_AH_fre_PID.name = 'AH frequency PID';step(Gcl_AH_fre_PID);   
        end
end

%------------------------------------------------------------------------
%CHR
%method_CHR = 1:set point following , 2:disturbance rejection
%output from disturbance : G_cl_y_di=G_main/(1+G_main*Gc)
%key_CHR= 1:P , 2:PI , 3:PID , 4:PI-D 
%ov=  0:0% overshoot , othervalues : 20%overshoot
%If you are obtaining a PI-D, be careful about Gc & H
method_CHR = 2;
key_CHR= 2;
ov=0;
vars_CHR = [K,L,T,N,ov];
switch method_CHR
    case 1,%set point following
        switch key_CHR
            case 1,[Gc_CHR_set_P,~,~,~,~]=chr_pid(key_CHR,method_CHR,vars_CHR);Gcl_CHR_set_P = feedback(Gc_CHR_set_P*G_main,1);Gcl_CHR_set_P.name = 'CHR setpoint P';step(Gcl_CHR_set_P);
            case 2,[Gc_CHR_set_PI,~,~,~,~]=chr_pid(key_CHR,method_CHR,vars_CHR);Gcl_CHR_set_PI = feedback(Gc_CHR_set_PI*G_main,1);Gcl_CHR_set_PI.name = 'CHR setpoint PI';step(Gcl_CHR_set_PI);
            case 3,[Gc_CHR_set_PID,~,~,~,~]=chr_pid(key_CHR,method_CHR,vars_CHR);Gcl_CHR_set_PID = feedback(Gc_CHR_set_PID*G_main,1);Gcl_CHR_set_PID.name = 'CHR setpoint PID'; step(Gcl_CHR_set_PID);  
            case 4,[Gc_CHR_set_PI_D,H_CHR_set_PI_D,~,~,~]=chr_pid(key_CHR,method_CHR,vars_CHR);Gcl_CHR_set_PI_D = feedback(Gc_CHR_set_PI_D*G_main,H_CHR_set_PI_D);Gcl_CHR_set_PI_D.name = 'CHR setpoint PI-D';step(Gcl_CHR_set_PI_D);
        end  
        
    case 2,%disturbance rejection
        switch key_CHR
            case 1,[Gc_CHR_dis_P,~,~,~,~]=chr_pid(key_CHR,method_CHR,vars_CHR);Gcl_CHR_dis_P = feedback(Gc_CHR_dis_P*G_main,1);Gcl_CHR_dis_P.name = 'CHR dis rej P';step(Gcl_CHR_dis_P);
            case 2,[Gc_CHR_dis_PI,~,~,~,~]=chr_pid(key_CHR,method_CHR,vars_CHR);Gcl_CHR_dis_PI = feedback(Gc_CHR_dis_PI*G_main,1);Gcl_CHR_dis_PI.name = 'CHR dis rej PI';step(Gcl_CHR_dis_PI);
            case 3,[Gc_CHR_dis_PID,~,~,~,~]=chr_pid(key_CHR,method_CHR,vars_CHR);Gcl_CHR_dis_PID = feedback(Gc_CHR_dis_PID*G_main,1);Gcl_CHR_dis_PID.name = 'CHR dis rej PID';step(Gcl_CHR_dis_PID);   
            case 4,[Gc_CHR_dis_PI_D,H_CHR_dis_PI_D,~,~,~]=chr_pid(key_CHR,method_CHR,vars_CHR);Gcl_CHR_dis_PI_D = feedback(Gc_CHR_dis_PI_D*G_main,H_CHR_dis_PI_D);Gcl_CHR_dis_PI_D.name = 'CHR dis rej PI-D';step(Gcl_CHR_dis_PI_D);
        end
end

%-----------------------------------------------------------------------
% WJC (ITAE optimization) Wang-Juang-Chan
vars_WJC=[K,L,T,N];
[Gc_WJC_PID,~,~,~]=wjcpid(vars_WJC);
Gcl_WJC_PID = feedback(Gc_WJC_PID*G_main,1);
Gcl_WJC_PID.name = 'WJC PID'; step(Gcl_WJC_PID);

%-----------------------------------------------------------------------
% Optimum PID: Zhuang-Atherton
%method_opt = 1:FOPDT  , 2:Frequency
%type_opt= 1:set point , 2:disturbance rejection
%key_opt= 2:PI , 3:PID , 4:PI-D(not available for FOPDT & disturbance rejection)
%opt_way= 1 : ISE ,, 2 : ISTE ,, 3 : IST^2E (just for FOPDT)
%If you are obtaining a PI-D, be careful about Gc & H

method_opt = 2;
type_opt=1;
key_opt= 2;
opt_way=1;
switch method_opt
    case 1,%FOPDT 
        vars_opt =[K,L,T,N,opt_way] ;
        switch key_opt
            case 1,[Gc_opt_FOPDT_P,~,~,~,~]=opt_pid(key_opt,type_opt,vars_opt);Gcl_opt_FOPDT_P = feedback(Gc_opt_FOPDT_P*G_main,1);Gcl_opt_FOPDT_P.name = 'opt FOPDT P';step(Gcl_opt_FOPDT_P);
            case 2,[Gc_opt_FOPDT_PI,~,~,~,~]=opt_pid(key_opt,type_opt,vars_opt);Gcl_opt_FOPDT_PI = feedback(Gc_opt_FOPDT_PI*G_main,1);Gcl_opt_FOPDT_PI.name = 'opt FOPDT PI';step(Gcl_opt_FOPDT_PI);
            case 3,[Gc_opt_FOPDT_PID,~,~,~,~]=opt_pid(key_opt,type_opt,vars_opt);Gcl_opt_FOPDT_PID = feedback(Gc_opt_FOPDT_PID*G_main,1);Gcl_opt_FOPDT_PID.name = 'opt FOPDT PID'; step(Gcl_opt_FOPDT_PID);  
            case 4,[Gc_opt_FOPDT_PI_D,H_opt_FOPDT_PI_D,~,~,~]=opt_pid(key_opt,type_opt,vars_opt);Gcl_opt_FOPDT_PI_D = feedback(Gc_opt_FOPDT_PI_D*G_main,H_opt_FOPDT_PI_D);Gcl_opt_FOPDT_PI_D.name = 'opt FOPDT PI-D';step(Gcl_opt_FOPDT_PI_D);
        end  
        
    case 2,%frequency
        vars_opt =[Kc,Tc,Kc*K,N] ;
        switch key_opt
            case 1,[Gc_opt_Freq_P,~,~,~,~]=opt_pid(key_opt,type_opt,vars_opt);Gcl_opt_Freq_P = feedback(Gc_opt_Freq_P*G_main,1);Gcl_opt_Freq_P.name = 'opt Freq P';step(Gcl_opt_Freq_P);
            case 2,[Gc_opt_Freq_PI,~,~,~,~]=opt_pid(key_opt,type_opt,vars_opt);Gcl_opt_Freq_PI = feedback(Gc_opt_Freq_PI*G_main,1);Gcl_opt_Freq_PI.name = 'opt Freq PI';step(Gcl_opt_Freq_PI);
            case 3,[Gc_opt_Freq_PID,~,~,~,~]=opt_pid(key_opt,type_opt,vars_opt);Gcl_opt_Freq_PID = feedback(Gc_opt_Freq_PID*G_main,1);Gcl_opt_Freq_PID.name = 'opt Freq PID'; step(Gcl_opt_Freq_PID);  
            case 4,[Gc_opt_Freq_PI_D,H_opt_Freq_PI_D,~,~,~]=opt_pid(key_opt,type_opt,vars_opt);Gcl_opt_Freq_PI_D = feedback(Gc_opt_Freq_PI_D*G_main,H_opt_Freq_PI_D);Gcl_opt_Freq_PI_D.name = 'opt Freq PI-D';step(Gcl_opt_Freq_PI_D);
        end
    
end

%------------------------------------------------------------------
% ipdtctrl
%key_ipdt= 1:PD ,, 2:PID
%key1_ipdt=1 : ISE ,, 2 : ITSE ,, 3 : ISTSE
key_ipdt=2;
key1_ipdt=2;
switch key_ipdt
    case 1,
        [Gc_ipdt_PD,~,~,~]=ipdtctrl(key_ipdt,key1_ipdt,K,L,N);
        Gcl_ipdt_PD = feedback(Gc_ipdt_PD*G_main,1);Gcl_ipdt_PD.name = 'ipdt PD';step(Gcl_ipdt_PD);
    case 2,
        [Gc_ipdt_PID,~,~,~]=ipdtctrl(key_ipdt,key1_ipdt,K,L,N);
        Gcl_ipdt_PID = feedback(Gc_ipdt_PID*G_main,1);Gcl_ipdt_PID.name = 'ipdt PID';step(Gcl_ipdt_PID);
end

%-----------------------------------------------------------------------
% foipdt
%key_foipdt= 1:PD ,, 2:PID
key_foipdt=2;

switch key_foipdt
    case 1,
        [Gc_foipdt_PD,~,~,~]=foipdt(key_foipdt,K,L,T,N);
        Gcl_foipdt_PD = feedback(Gc_foipdt_PD*G1_main,1);Gcl_foipdt_PD.name = 'foipdt PD';step(Gcl_foipdt_PD);
    case 2,
        [Gc_foipdt_PID,~,~,~]=foipdt(key_foipdt,K,L,T,N);
        Gcl_foipdt_PID = feedback(Gc_foipdt_PID*G1_main,1);Gcl_foipdt_PID.name = 'foipdt PID';step(Gcl_foipdt_PID);
end




