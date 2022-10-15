function [y] = separationminimum(distance,aircraft)
a = length(aircraft);
if isempty(aircraft)
    y = 0;
else
    for i = 1:a
    minimumdistanceaircraft(1,i) = min(distance(aircraft(1,i),:));
    end
    y = min(minimumdistanceaircraft);
end
end