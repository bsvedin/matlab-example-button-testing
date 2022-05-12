classdef MainClass < handle
    properties
        statusMessages
        state
    end
    
    properties (Access = private)
        abortFlag
    end
    
    events
        statusMessagesUpdated
        stateUpdated
    end
    
    methods
        function obj = MainClass()
            obj.abortFlag = false;
            obj.statusMessages = cell(0,0);
            obj.updateStatusMessages('Tool initialized');
            obj.state = 'Not Started';
        end
        
        function run(obj)
            % Long running method
            obj.abortFlag = false;
            obj.updateState('Running');
            updateTime = 0;
            obj.updateStatusMessages(sprintf('Execution Message: %i', updateTime));
            t = tic;
            while toc(t) < 15
                if obj.abortFlag
                    break
                end
                if floor(toc(t)) > updateTime
                    updateTime = updateTime + 1;
                    obj.updateStatusMessages(sprintf('Execution Message: %i', updateTime));
                end
            end
            if obj.abortFlag
                obj.updateState('Aborted');
            else
                obj.updateState('Completed');
            end
        end
        
        function abort(obj)
            obj.abortFlag = true;
        end
        
        function updateStatusMessages(obj, message)
            obj.statusMessages{end+1, 1} = message;
            notify(obj, 'statusMessagesUpdated');
        end
        
        function updateState(obj, state)
            obj.state = state;
            notify(obj, 'stateUpdated');
        end
    end
end

