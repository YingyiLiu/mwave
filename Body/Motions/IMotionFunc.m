%{ 
mwave - A water wave and wave energy converter computation package 
Copyright (C) 2014  Cameron McNatt

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Contributors:
    C. McNatt
%}
classdef IMotionFunc < matlab.mixin.Heterogeneous & handle
    % Defines motions for modes of motion
    
    properties(Access = protected)
        cg;
    end
    
    properties (Dependent)
        Cg;
    end
    
    properties (Abstract)
        MotionIn;
    end
    
    methods (Abstract)
        Evaluate(pos);
    end
    
    methods
        function [c] = get.Cg(motF)
            c = motF.cg;
        end
        function [motF] = set.Cg(motF, c)
            [N, M] = size(c);
            
            if ((N ~= 1) || (M ~= 3))
                error('Cg must be a 1x3 vector');
            end
            
            motF.cg = c;
        end
    end
    
    methods (Access = protected)
        function [] = initCg(motF, varargin)
            if (isempty(varargin))
                motF.cg = [0 0 0];
            elseif (length(varargin) == 1)
                c = varargin{1};
                
                [N, M] = size(c);
            
                if ((N ~= 1) || (M ~= 3))
                    error('Cg must be a 1x3 vector');
                end
                
                motF.cg = c;
            else
                error('MotionFunc input not recognize');               
            end
        end
    end
end