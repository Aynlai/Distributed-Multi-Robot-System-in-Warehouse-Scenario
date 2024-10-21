load InitThresh.mat
load InitPackages.mat
load WarehouseMap.mat

numAgents = size(chargingStations, 1);  
numTasks = length(packages);
agentFootprint = [0.5;0.5];            %[baseAgent.Width; baseAgent.Height];
paddingFactor = baseAgent.Padding;
agentIdleTime = 20;

agent = Simulink.Bus;
agentElems(1) = Simulink.BusElement;
agentElems(1).Name = 'Id';
agentElems(2) = Simulink.BusElement;
agentElems(2).Name = 'Status';
agentElems(2).DataType = 'Enum: AgentStatus';
agentElems(3) = Simulink.BusElement;
agentElems(3).Name = 'CurrentPosition';
agentElems(3).Dimensions = 3;
agentElems(4) = Simulink.BusElement;
agentElems(4).Name = 'Velocity';
agentElems(5) = Simulink.BusElement;
agentElems(5).Name = 'AngularVelocity';
agentElems(6) = Simulink.BusElement;
agentElems(6).Name = 'GoalPosition';
agentElems(6).Dimensions = 2;
agentElems(7).Name = 'Type';
agentElems(7).DataType = 'Enum: AgentType';
agentElems(8) = Simulink.BusElement;
agentElems(8).Name = 'Footprint';
agentElems(8).Dimensions = 2;
agentElems(9) = Simulink.BusElement;
agentElems(9).Name = 'TaskId';
agent.Elements = agentElems;

task = Simulink.Bus;
taskElems(1) = Simulink.BusElement;
taskElems(1).Name = 'Id';
taskElems(2) = Simulink.BusElement;
taskElems(2).Name = 'Status';
taskElems(2).DataType = 'Enum: TaskStatus';
taskElems(3) = Simulink.BusElement;
taskElems(3).Name = 'AgentId';
taskElems(4) = Simulink.BusElement;
taskElems(4).Name = 'Source';
taskElems(4).Dimensions = 2;
taskElems(5) = Simulink.BusElement;
taskElems(5).Name = 'Sink';
taskElems(5).Dimensions = 2;
taskElems(6) = Simulink.BusElement;
taskElems(6).Name = 'NextTask';
taskElems(7) = Simulink.BusElement;
taskElems(7).Name = 'PreviousTask';
task.Elements = taskElems;

agentBatch =  Simulink.Bus;
agentBatchElems = Simulink.BusElement;
agentBatchElems.Name = 'agent';
agentBatchElems.DataType = 'Bus: agent';
agentBatchElems.Dimensions = numAgents;
agentBatch.Elements = agentBatchElems;

taskBatch =  Simulink.Bus;
taskBatchElems = Simulink.BusElement;
taskBatchElems.Name = 'task';
taskBatchElems.DataType = 'Bus: task';
taskBatchElems.Dimensions = numTasks;
taskBatch.Elements = taskBatchElems;

taskingAlgorithm = "auction";                 % can custom own taskingAlgorithm here
switch taskingAlgorithm
    case "greedy"
        taskingAlgorithm = TaskingAlgorithm.Greedy;
    case "munkres"
        taskingAlgorithm = TaskingAlgorithm.Munkres;
    case "auction"
        taskingAlgorithm = TaskingAlgorithm.Auction;
end

node = Simulink.Bus;
nodeElems(1) = Simulink.BusElement;
nodeElems(1).Name = 'North';
nodeElems(1).DataType = 'boolean';               % boolean type means if there
nodeElems(2) = Simulink.BusElement;              % connection in that direction like north or east
nodeElems(2).Name = 'East';
nodeElems(2).DataType = 'boolean';
nodeElems(3) = Simulink.BusElement;
nodeElems(3).Name = 'South';
nodeElems(3).DataType = 'boolean';
nodeElems(4) = Simulink.BusElement;
nodeElems(4).Name = 'West';
nodeElems(4).DataType = 'boolean';
nodeElems(5) = Simulink.BusElement;
nodeElems(5).Name = 'Name';
nodeElems(5).Dimensions = 2;
node.Elements = nodeElems;

network = Simulink.Bus;
networkElems(1) = Simulink.BusElement;
networkElems(1).Name = 'Map';
networkElems(1).DataType = 'Bus: node';
networkElems(1).Dimensions = size(logicalMap);    % the size of nodes equal to the size of Map
networkElems(2) = Simulink.BusElement;
networkElems(2).Name = 'ResList';
if numAgents == 1
    networkElems(2).Dimensions = [5 4];
else
    networkElems(2).Dimensions = [5 4 numAgents];
end
network.Elements = networkElems;

routingAlgorithm = "aStar";                           %aStar
switch routingAlgorithm
    case "aStar"
        routingAlgorithm = RoutingAlgorithm.AStar;
end