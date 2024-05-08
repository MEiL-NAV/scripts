function log = load_log(dir_name, label)
if nargin == 2
    log.label = label;
elseif nargin == 1
    log.label = '';
else
    assert(false);
end
log.name = dir_name;
log.accel = readtable(strcat(dir_name,'/accel.csv'));
log.ekf = readtable(strcat(dir_name,'/ekf.csv'));
log.fanuc_position = readtable(strcat(dir_name,'/fanuc_position.csv'));
log.force = readtable(strcat(dir_name,'/force.csv'));
log.gyro = readtable(strcat(dir_name,'/gyro.csv'));
log.pos_provider = readtable(strcat(dir_name,'/pos_provider.csv'));

f = log.fanuc_position{:,:};
j = find(any(diff(f(:,2:end)) ~= 0,2),1);
log.start_time = log.fanuc_position.time(j);
end