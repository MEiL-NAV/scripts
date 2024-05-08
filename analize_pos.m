close all; clc; clear;

log_dirs = {'pos/pos_gyro_no_corr'; 'pos/all_without_accel'; 'pos/pos_with_const_3_01'; 'pos/all_no_const'; 'pos/all_const'; 'pos/simple_const_gyro'};
label = {'position provider + gyroscope'; 'position provider + gyroscope + accelerometer + constraints'; 'position provider + constraints'; 'position provider + gyroscope + accelerometer'; 'position provider + gyroscope + accelerometer + constraints'; 'position provider + gyroscope + accelerometer + simplified constraints'};

assert(all(size(label) == size(log_dirs)));
n = length(log_dirs);


logs = [];
for i = 1:n
    log = load_log(log_dirs{i}, label{i});
    logs = [logs; log];
end


% figure(1)
% for i = 1:n
%     subplot(n,2,2*i-1);
%     plot(logs(i).fanuc_position.time-logs(i).start_time, logs(i).fanuc_position.X, '*');
%     hold on;
%     plot(logs(i).ekf.time-logs(i).start_time, logs(i).ekf.x, '-');
%     hold off;
%     title(logs(i).label);
%     xlabel('time [ms]');
%     ylabel('x [m]');
%     axis([0 180000 -0.25 0.25])
% 
%     subplot(n,2,2*i);
%     plot(logs(i).fanuc_position.time-logs(i).start_time, logs(i).fanuc_position.Y, '*');
%     hold on;
%     plot(logs(i).ekf.time-logs(i).start_time, logs(i).ekf.y, '-');
%     hold off;
%     title(logs(i).label);
%     xlabel('time [ms]');
%     ylabel('y [m]');
%     axis([0 180000 -0.25 0.25])
% end
% leg = legend('fanuc','estimation', 'Location','southoutside','orientation','horizontal');
% leg.Position(1) = 0.35;
% leg.Position(2) = 0.02;
% 
% figure(2)
% for i = 1:n
%     subplot(n,2,2*i-1);
%     plot(logs(i).ekf.time- logs(i).start_time, logs(i).ekf.vx, '-');
%     title(logs(i).label);
%     xlabel('time [ms]');
%     ylabel('vx [m]');
%     axis([0 180000 -inf inf])
% 
%     subplot(n,2,2*i);
%     plot(logs(i).ekf.time- logs(i).start_time, logs(i).ekf.vy, '-');
%     title(logs(i).label);
%     xlabel('time [ms]');
%     ylabel('vy [m]');
%     axis([0 180000 -inf inf])
% end

% figure(3)
% hold on
% for i = 1:n
%     plot(logs(i).ekf.time - logs(i).start_time, logs(i).ekf.x, 'o');
% end
% hold off
% legend(label, 'Location', 'southwest')
% xlabel('time [ms]');
% ylabel('x [m]');
% axis([0 180000 -inf inf])
% 
% figure(4)
% hold on
% for i = 1:n
%     plot(logs(i).ekf.time - logs(i).start_time, logs(i).ekf.y, 'o');
% end
% hold off
% legend(label, 'Location', 'southwest')
% xlabel('time [ms]');
% ylabel('y [m]');
% axis([0 180000 -inf inf])

fig = figure(5);
for i = 1:n
    subplot(n,1,i);
    plot((logs(i).ekf.time- logs(i).start_time)./1000.0, logs(i).ekf.x, '-');
    title(logs(i).label);
    
    axis([0 180 -0.25 0.25]);
end
han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
xlabel(han,'time [s]');
ylabel(han,'x [m]');

fig = figure(6);
for i = 1:n
    subplot(n,1,i);
    plot((logs(i).ekf.time- logs(i).start_time)./1000.0, logs(i).ekf.y, '-');
    title(logs(i).label);
    %xlabel('time [s]');
    %ylabel('y [m]');
    axis([0 180 -0.25 0.25]);
end
han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
xlabel(han,'time [s]');
ylabel(han,'y [m]');

fig = figure(7);
for i = 1:n
    subplot(n,1,i);
    plot((logs(i).ekf.time- logs(i).start_time)./1000.0, logs(i).ekf.z, '-');
    title(logs(i).label);
    axis([0 180 -0.15 0.15]);
end
han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
xlabel(han,'time [s]');
ylabel(han,'z [m]');

