customer= 1: 20;
AT= [0,700,880,600,650,300,922,30,310,480,160,290,390,390,610,690,860,105,93,493,530];
ST1=[23,34,17,46,76,80,30,6,25,99,85,44,31,70,64,14,2,39,9,7];
ST2=[88,5,75,32,40,91,1,9,17,72,12,48,4,11,90,98,97,93,3,68];
LastArrive=zeros(1,20);
arrivaltime=zeros(1,20);
begin1=zeros(1,20);
ServiceTime1=zeros(1,20);
ServiceTimeEnd1=zeros(1,20);
begin2=zeros(1,20);
ServiceTime2=zeros(1,20);
ServiceTimeEnd2=zeros(1,20);
QueueWaiting=zeros(1,20);
TimeInSystem1=zeros(1,20);
TimeInSystem2=zeros(1,20);
Idle=zeros(1,20);
for i=2:20
    if (AT(i)>=0) && (AT(i)<=125)
        LastArrive(1,i)=1;
    elseif (AT(i)>=126) &&(AT(i)<=250)
        LastArrive(1,i)=2;
    elseif (AT(i)>=251) &&(AT(i)<=375)
        LastArrive(1,i)=3;
    elseif (AT(i)>=376) &&(AT(i)<=500)
        LastArrive(1,i)=4;
    elseif (AT(i)>=501) &&(AT(i)<=625)
        LastArrive(1,i)=5;
    elseif (AT(i)>=626) &&(AT(i)<=750)
        LastArrive(1,i)=6;
    elseif (AT(i)>=751) &&(AT(i)<=875)
        LastArrive(1,i)=7;
    elseif (AT(i)>=876) &&(AT(i)<=1000)
        LastArrive(1,i)=8;
    end
end
for i=1:20
    if (ST1(i)>=0) && (ST1(i)<=10)
        ServiceTime1(1,i)=1;
    elseif (ST1(i)>=11) && (ST1(i)<=60)
        ServiceTime1(1,i)=2;
    elseif (ST1(i)>=61) && (ST1(i)<=100)
        ServiceTime1(1,i)=3;
    end
end

for i=1:20
    if (ST2(i)>=0) && (ST2(i)<=20)
        ServiceTime2(1,i)=1;
    elseif (ST2(i)>=21) && (ST2(i)<=90)
        ServiceTime2(1,i)=2;
    elseif (ST2(i)>=91) && (ST2(i)<=100)
        ServiceTime2(1,i)=3;
    end
end

x=0;
for i=2:20
    x=LastArrive(1,i)+x;
    arrivaltime(1,i)=x;
end

for i=2:20
    x=arrivaltime(1,i-1)+ServiceTime1(1,i-1);
    y=arrivaltime(1,i);
    if x>=y
        begin1(1,i)=x;
    else
        begin1(1,i)=y;
    end
end

for i=2:20
    x=arrivaltime(1,i-1)+ServiceTime2(1,i-1);
    y=arrivaltime(1,i);
    if x>=y
        begin2(1,i)=x;
    else
        begin2(1,i)=y;
    end
end

for i=2:20
    ServiceTimeEnd1(1,i)=begin1(1,i)+ST1(1,i);
    ServiceTimeEnd2(1,i)=begin2(1,i)+ST2(1,i);
end

for i =1:20
    if (ServiceTime1==0)
        ServiceBegin=begin2(i);
        ServiceTimeEnd=ServiceTimeEnd2;
    else
        ServiceBegin=begin1(i);
        ServiceTimeEnd=ServiceTimeEnd1;
    end
    QueueWaiting(1,i)=ServiceBegin-arrivaltime(1,i);
    %ServiceTimeEnd(1,i)=ServiceBegin(1,i)+ST1(1,i);
    %ServiceTimeEnd(1,i)=ServiceBegin(1,i)+ST2(1,i);
    TimeInSystem1(1,i)=QueueWaiting(1,i)+ST1(1,i);
    TimeInSystem2(1,i)=QueueWaiting(1,i)+ST2(1,i);
end

for i=2:20
    Idle(1,i)=ServiceBegin-ServiceTimeEnd(1,i);
    if Idle(1,i)<0
        Idle(1,i)=0;
    end
end

T=table(customer' ,LastArrive' ,arrivaltime', ST1' , begin1' ,ServiceTime1' ,ServiceTimeEnd1' ,ST2' ,begin2' ,ServiceTime2' ,ServiceTimeEnd2' ,QueueWaiting' ,TimeInSystem1' ,TimeInSystem2' ,Idle');
    