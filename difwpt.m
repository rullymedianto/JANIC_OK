function [dw] = difwpt(vroute,wpt,endwpt)

if wpt == endwpt
    ds=0;
else 
    ds=1;
end

if ds == 1 && vroute+1 > vroute
    dw = 1;
elseif ds == 1 && vroute+1 < vroute
    dw = -1;
    
elseif ds == 0 || vroute+1 == vroute
    dw = 0 ;
end

end

