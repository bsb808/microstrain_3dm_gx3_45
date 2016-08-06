rosinit;


% Setup publisher/subscriber
N = 1000;
tt = zeros(N,1);
nt = zeros(N,1);
poseSub = rossubscriber('/imu_3dm_node/imu/data');
xx = zeros(N,1);
for ii = 1:N
    poseMsg = receive(poseSub);
    tt(ii)=poseMsg.Header.Stamp.Sec;
    nt(ii)=poseMsg.Header.Stamp.Nsec;
    xx(ii)=poseMsg.AngularVelocity.X;
end

TT = tt+double(nt)/1.0e9;

avgdt = N/(TT(end)-TT(1))

figure(1);
clf();
subplot(211)
plot(TT,'.')
subplot(212)
plot(diff(TT),'.')

figure(2)
clf();
subplot(211)
plot(xx,'.')
subplot(212)
plot(diff(xx),'r.')

rosshutdown

