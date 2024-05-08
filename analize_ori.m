close all; clc; clear;

% log_dirs = {'ori/ori_low_no'; 'ori/ori_low_with'; 'ori/ori_high_no'; 'ori/ori_high_with'};
% label = {'Low speed'; 'Low speed + correction'; 'High speed'; 'High speed + correction'};
log_dirs = {'pos/pos_gyro_no_corr'; 'pos/all_without_accel'; 'pos/pos_with_const_3_01'; 'pos/all_no_const'; 'pos/all_const'; 'pos/simple_const_gyro'};
label = {'position provider + gyroscope'; 'position provider + gyroscope + accelerometer + constraints'; 'position provider + constraints'; 'position provider + gyroscope + accelerometer'; 'position provider + gyroscope + accelerometer + constraints'; 'position provider + gyroscope + accelerometer + simplified constraints'};


assert(all(size(label) == size(log_dirs)));
n = length(log_dirs);


logs = [];
for i = 1:n
    log = load_log(log_dirs{i}, label{i});
    [r,p,y] = quat2angle(log.ekf{:, 8:11}, "XYZ");
    log.rpy.r = rad2deg(r);
    log.rpy.p = rad2deg(p);
    log.rpy.y = rad2deg(y);
    logs = [logs; log];
end

fig = figure(1);
for i = 1:n
    subplot(n,1,i);
    [r,~] = yaw_exclusion(logs(i).rpy.r,logs(i).rpy.r,logs(i).rpy.y);
    % plot((logs(i).fanuc_position.time - logs(i).start_time)/1000.0, wrapTo180(180 - logs(i).fanuc_position.W), 'o','MarkerSize',1);
    % hold on
    plot((logs(i).ekf.time - logs(i).start_time)/1000.0, r, '-');
    % hold off
    title(logs(i).label);
    axis([0 inf -5 5]);
end
% leg = legend('fanuc','estimation', 'Location','southoutside','orientation','horizontal');
% leg.Position(1) = 0.35;
% leg.Position(2) = 0.02;
han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
xlabel('time [s]');
ylabel('roll [deg]');

fig = figure(2);
for i = 1:n
    subplot(n,1,i);
    [~, p] = yaw_exclusion(logs(i).rpy.r,logs(i).rpy.p,logs(i).rpy.y); 
    % plot((logs(i).fanuc_position.time - logs(i).start_time)/1000.0, logs(i).fanuc_position.P, 'o','MarkerSize',1);
    % hold on
    plot((logs(i).ekf.time - logs(i).start_time)/1000.0, p, '-');
    % hold off
    title(logs(i).label);
    axis([0 inf -5 5]);
end
% leg = legend('fanuc','estimation', 'Location','southoutside','orientation','horizontal');
% leg.Position(1) = 0.35;
% leg.Position(2) = 0.02;
han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
xlabel('time [s]');
ylabel('pitch [deg]');

fig = figure(3);
for i = 1:n
    subplot(n,1,i);
    % plot((logs(i).fanuc_position.time - logs(i).start_time)/1000.0, logs(i).fanuc_position.R, 'o','MarkerSize',1);
    % hold on
    plot((logs(i).ekf.time - logs(i).start_time)/1000.0, logs(i).rpy.y, '-');
    % hold off
    title(logs(i).label);
    axis([0 inf -120 120]);
end
% leg = legend('fanuc','estimation', 'Location','southoutside','orientation','horizontal');
% leg.Position(1) = 0.35;
% leg.Position(2) = 0.02;
han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
xlabel('time [s]');
ylabel('yaw [deg]');

