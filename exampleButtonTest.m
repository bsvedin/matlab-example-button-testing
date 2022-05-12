classdef exampleButtonTest < matlab.unittest.TestCase & matlab.mock.TestCase & matlab.uitest.TestCase
    
    %% Methods - Test
    methods (Test)
            
        % Scenario: The Tool shall allow the user to abort the execution
        function testAbortWorkflow(testCase)
            app = exampleButtonTestingApp;
            %TODO - Figure out a way to make this asynchronous.
            % I have tried using testCase.press(location) rather than the button instance. That also did not work
            
            testCase.press(app.StartButton);
            testCase.verifyEqual(app.mainClass.state, 'Running');
            pause(3);
            testCase.press(app.AbortButton);
            testCase.verifyEqual(app.mainClass.state, 'Aborted');
            delete(app);
        end % testAbortWorkflow
        
        function testAbortWorkflowPressLocation(testCase)
            app = exampleButtonTestingApp;
            % I have tried using testCase.press(location) rather than the button instance. That also did not work
            
            pos = app.StartButton.Position;
            testCase.press(app.UIFigure, [pos(1)+20, pos(2)+20]);
            testCase.verifyEqual(app.mainClass.state, 'Running');
            pause(3);
            testCase.press(app.AbortButton);
            testCase.verifyEqual(app.mainClass.state, 'Aborted');
            delete(app);
        end % testAbortWorkflow
        
        
    end %methods (Test)
    
    
end %classdef