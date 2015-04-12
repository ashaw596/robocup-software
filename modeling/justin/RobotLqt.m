
% Linear Quadratic Tracking (LQT) controller for the robot
classdef RobotLqt < matlab.System
    
    
    properties
        % Translational velocity error weight
        trans_vel_weight;
        
        % Rotational velocity error weight
        rot_vel_weight;
        
        % Control voltage weight
        u_weight;
    end
    
    
    properties (Dependent = true)
        Q;
        R;
    end
    
    
    methods
        function Q = get.Q(obj)
            Q = [obj.trans_vel_weight,                    0,                  0;
                                    0, obj.trans_vel_weight,                  0;
                                    0                     0, obj.rot_vel_weight];
        end
       
        function R = get.R(obj)
            R = eye(4) * obj.u_weight;
        end
    end
    
    
    methods (Access = protected)

        % input: command body velocity
        function num = getNumInputsImpl(~)
            num = 5;
        end

        % output: voltages for motors
        function num = getNumOutputsImpl(~)
            num = 1;
        end

        function sz = getOutputSizeImpl(~)
            sz = [4 1];
        end

        function t1 = getOutputDataTypeImpl(obj)
            t1 = 'double';
        end

        function [in1name, in2name, in3name, in4name, in5name] = getInputNamesImpl(~)
            in1name = 'Cmd Velocity';
            in2name = 'Curr. Velocity';
            in3name = 'A_1';
            in4name = 'A_2';
            in5name = 'B';
        end

        function name = getOutputNamesImpl(~)
            name = 'u';
        end
        
        function fixedout = isOutputFixedSizeImpl(~)
            fixedout = true;
        end
        
        
        function flag1 = isOutputComplexImpl(obj)
            flag1 = false;
        end


        function u = stepImpl(~, cmdVel, currVel, A_1, A_2, B)
            % TODO: do LQT


            u = [1 -1 -1 1]';
        end
    end
    
end
