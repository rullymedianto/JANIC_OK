classdef com2saw
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        saw
    end
    
    methods
        function obj = com2saw(x)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            if (5>x) && (x>2)
                obj.saw = 1;
            elseif (7>x) && (x>=5)
                obj.saw = 3;
            elseif x>=7
                obj.saw = 5;
            else
                obj.saw = 0;
            end
        end
        
%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end

