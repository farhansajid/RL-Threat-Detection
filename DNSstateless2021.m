%rlCreateEnvTemplate("MyEnvironment");
%Tmat=table2array(RL(:,1:15)); %conversion of table to matrix
% validateEnvironment(DNSstateless2021)

classdef DNSstateless2021 < rl.env.MATLABEnvironment
    %DNSstateless2021: Template for defining custom environment in MATLAB.    
    
    %% Properties (set properties' attributes accordingly)
    properties
        % Dataset
        %rlData = readDataset()
        % Specify and initialize environment's necessary properties    
        randRow = randi([1, length(DNSstateless2021.readDataset())]);
        %randRow = randi([1, 433355]);

        % Reward each time step
        RewardForNotFalling = 10
        
        % The input that the agent can apply
        class = 1

        % Penalty when it fails
        PenaltyForFalling = -1
    end
    
    properties
        % Initialize system states 
        State = zeros(1, 15)
    end
    
    properties(Access = protected)
        % Initialize internal flag to indicate episode termination
        IsDone = false
    end

    %% Necessary Methods
    methods              
        % Contructor method creates an instance of the environment
        function this = DNSstateless2021()
            % Initialize Observation settings
            ObservationInfo = rlNumericSpec([1 15]);
            ObservationInfo.Name = 'DNS States';
            ObservationInfo.Description = 'Benign, HeavyAttack'; % Benign = 0, HeavyAttack = 1

            %disp(ObservationInfo);
            % Initialize Action settings   
            ActionInfo = rlFiniteSetSpec([0 1]);
            ActionInfo.Name = 'DNS Statless Action';
            
            % The following line implements built-in functions of RL env
            this = this@rl.env.MATLABEnvironment(ObservationInfo,ActionInfo);
            
            % Initialize property values and pre-compute necessary values
            updateActionInfo(this);
            %read Dataset
            %rlData = readDataset();
            
        end
        
        % Apply system dynamics and simulates the environment with the 
        % given action for one step.
        function [Observation,Reward,IsDone,LoggedSignals] = step(this, Action)
            
            LoggedSignals = [];
            
            % Get action
            Classified = getClass(this, Action);
            data = DNSstateless2021.readDataset();
            %disp(data);

            if Classified == data(this.randRow, 16)
                IsDone = 1;
            else
                IsDone = 0;
            end
               
            % Update observations vector
            Observation = data(this.randRow,1:15); %this.rlData(this.randRow,1:15);
            
            % Update system states
            this.State = Observation;
            
            % Check terminal condition
            this.IsDone = IsDone;
            
            % Get reward
            Reward = getReward(this);
            
            % (optional) use notifyEnvUpdated to signal that the 
            % environment has been updated (e.g. to update visualization)
            notifyEnvUpdated(this);
        end
        
        % Reset environment to initial state and output initial observation
        function InitialObservation = reset(this)
            rlData = DNSstateless2021.readDataset();
            this.randRow = randi([1, length(rlData)]);
            InitialObservation = rlData(this.randRow,1:15);
            this.State = InitialObservation;

            % (optional) use notifyEnvUpdated to signal that the 
            % environment has been updated (e.g. to update visualization)
            notifyEnvUpdated(this);
        end
    end
    %% Optional Methods (set methods' attributes accordingly)
    methods               
        % Helper methods to create the environment
        % Discrete force 1 or 2
        function class1 = getClass(this,action)
            if ~ismember(action,this.ActionInfo.Elements)
                error('Action must be %g for Benign=0 and %g for HeavyAttack=1.',-this.class, this.class); %put the class labeles
            end
            class1 = action;           
        end
        % update the action info based on the value of class
        function updateActionInfo(this)
            this.ActionInfo.Elements = this.class*[0 1];
        end
        
        % Reward function
        function Reward = getReward(this)
            if ~this.IsDone
                Reward = this.RewardForNotFalling;
            else
                Reward = this.PenaltyForFalling;
            end          
        end
        
        % (optional) Visualization method
        function plot(this)
            % Initiate the visualization
            
            % Update the visualization
            envUpdatedCallback(this)
        end
    end
    
    methods (Static)
            function rlData = readDataset()
                % Set up the Import Options and import the data
                opts = delimitedTextImportOptions("NumVariables", 16);

                % Specify range and delimiter
                opts.DataLines = [2, Inf];
                opts.Delimiter = ",";

                % Specify column names and types
                opts.VariableNames = ["timestamp", "FQDN_count", "subdomain_length", "upper", "lower", "numeric", "entropy", "special", "labels", "labels_max", "labels_average", "longest_word", "sld", "len", "subdomain", "Class"];
                opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

                % Specify file level properties
                opts.ExtraColumnsRule = "ignore";
                opts.EmptyLineRule = "read";

                % Import the data
                DatasetstatelessattackheavyAllProcessed = readtable("D:\OneDrive\Yousaf Saeed\Dataset-stateless_attack_heavyAllProcessed.csv", opts);

                % Clear temporary variables
                clear opts

            % conversion of table to matrix
            %RL2data=table2array(RL2(:,1:40)); %conversion of table to matrix
            rlData = table2array(DatasetstatelessattackheavyAllProcessed);
        end
    end

    methods (Access = protected)
        % (optional) update visualization everytime the environment is updated 
        % (notifyEnvUpdated is called)
        function envUpdatedCallback(this)
        end
    end
end
