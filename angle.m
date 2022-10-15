function [x] = angle(m,s)
  if m>0 && (m/s)>0
                    if atand(m/s) == inf                            %Result atand = inf
                        x = 90;
                    else
                        x = atand(m/s);               %Heading 0 - 89
                    end
                    
   elseif m>0 && (m/s)<0
                        if atand(m/s) == inf                        %Result atand = inf
                            x = -90 + 180;
                        else
                            x = atand(m/s) + 180;     %Heading 90-179
                        end
                        
   elseif m<0 && (m/s)>0
                        if atand(m/s) == inf                        %Result atand = inf
                            x = 90 + 180;
                        else
                            x = atand(m/s) + 180;     %Heading 180 - 269
                        end
                        
   elseif m<0 && (m/s)<0
                        if atand(m/s) == inf                        %Result atand = inf
                            x = -90 + 360;  
                        else
                             x = atand(m/s) + 360;    %Heading 270-359;
                        end
  else 
                        if m == 0 && s>0                                %Heading 0 
                            x = 0;
                        else
                                x = 180;                                                  %Heading 180
                        end
                        end    
end