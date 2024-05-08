function [r_out, p_out] = yaw_exclusion(r,p,y)
assert(all(size(r) == size(p)));
assert(all(size(r) == size(y)));
n = length(r);
r_out = zeros(n,1);
p_out = zeros(n,1);

for i = 1:n
    y_rad = deg2rad(y(i));
    r_out(i) = r(i);
    p_out(i) = p(i);
    % r_out(i) =  r(i) * cos(y_rad) + p(i) * sin(y_rad);
    % p_out(i) = -r(i) * sin(y_rad) + p(i) * cos(y_rad);
end
end