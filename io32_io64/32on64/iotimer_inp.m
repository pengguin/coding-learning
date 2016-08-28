%iotimer_inp.m
%
%calculate average response latency for 1,000 successive
%reads from the LPT1: Status port using the io32 mex-file object

clear all;
config_io;     %install inpout32.dll port I/O driver
start_cogent;

global cogent;
%assure successful installation of inpout32.dll device driver
if ( cogent.io.status == 0 )
    disp(' ');
    disp('inpout32.dll successfully installed.')
else
    disp(' ');
    disp('inpout32.dll installation failed.')
    return
end
%read the LPT1 status port using inp(address)
status = hex2dec('379');  %LPT1 Status port addr
x=inp(status);

tstart=time;

disp('Collecting data from 1,000 consecutive LPT1 Status port reads')
data=zeros(1000,1);
tstart=time;
for i=1:1000
    %t1=time;
    x=inp(status);
    %t2=time;
    %data(i)=t2-t1;
end
tend=time;

%md=mean(data);
%sd=std(data);
%dmax=max(data);
elapsed=tend-tstart;
disp('BENCHMARK RESULTS FOR IOReadWrite I/O TEST');
disp(['Total elapsed time = ',num2str(elapsed),' msec'])
disp(['Mean latency = ',num2str(elapsed./1000),' msec'])
%disp(['Std latency = ',num2str(sd),' msec'])
%disp(['Max observed = ',num2str(dmax),' msec']);

stop_cogent;
clear all;