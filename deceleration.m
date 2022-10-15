function [Vtime] = deceleration(v0,vtarget)
if v0 > vtarget
Vtime = v0 - 0.7;
else 
    Vtime = v0;
end

