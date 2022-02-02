function [sys,x0,str,ts]=multi_step(t,x,u,flag,tTime,yStep)
switch flag,
   case 0 % ���ó�ʼ������
       [sys,x0,str,ts] = mdlInitializeSizes;
   case 3  % ��������źţ����ɶ��Ծ�ź�
       sys = mdlOutputs(t,tTime,yStep);
   case {1, 2, 4, 9} % δʹ�õ� flag ֵ
       sys = [];
   otherwise % ������Ϣ����
       error(['Unhandled flag = ',num2str(flag)]);
end;
% when flag=0 ʱ�����г�ʼ������
function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes; % �����ʼ����ģ��
sizes.NumContStates = 0; sizes.NumDiscStates = 0; % ����������ɢ״̬
sizes.NumOutputs = 1; sizes.NumInputs = 0; % ϵͳ����������·��
sizes.DirFeedthrough = 0;% �����źŲ�ֱ�Ӵ��䵽���
sizes.NumSampleTimes = 1;% ������������
sys = simsizes(sizes); % ��ʼ��
x0 = []; str = []; % ϵͳ�ĳ�ʼ״̬Ϊ������
ts = [0 0]; % ����ģ��Ϊ����ģ��
%  flag=3 ʱ����������ź�
function sys = mdlOutputs(t,tTime,yStep)
i=find(tTime<=t); sys=yStep(i(end));
