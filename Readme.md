# 4. Multi-Agent systems

## 4.1 Merits of multi-agent systems in warehouse applications

1. Autonomous decision making among agents while achieving an optimal condition.
2. Assist in utilizing available resources to it's potential
3. Meet customer demands at scale and speed



## 4.2 Autonomous Robots in warehouse applications

![image-20241012103002587](C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241012103002587.png)

### 4.2.1 Sensing & Perception

In one entity which contains **sensor**, as well as the smart to understand its environment

### 4.2.2 Localization & Mapping

or have a self-awareness of the environment

### 4.2.3 Planning

able to plan its path or its task from one location to another

### 4.2.4. Control

as well as finally control. its electronic components, such as the drives, as well as sensors, and drive autonomously in a given 2D space or 3D space.

## 4.3 Multiple robots in warehouse applications

Robots are expected to coordinate/interact with the environment as well as within themselves to complete complex tasks optimally

![image-20241012104155103](C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241012104155103.png)

communicate with other either to a single server or from a peer to peer communication.

Once you have the communication set up it also talks to the tasking and the routing engine, which would help you resolve, as well as complete these tasks in an optimal fashion

![image-20241012105115457](C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241012105115457.png)

**Scenario Creation:** defining the environment, coming up with a map, coming up with a traffic graph for these robots could actually navigate

**Robots**: define their jobs, since we are talking about a simulation environment, we want to create these entities. Once you've created the entity of an agent, this particular agent or robot has its own flavor of dynamics

 +  **Entity Creation**:  being done by SimEvents, 

    <img src="C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241012105929536.png" alt="image-20241012105929536" style="zoom: 33%;" />

    which is specifically for a agent or a robot

    here we created a robot with a particular ID, current position, type and footprint. You don't have to provide these details every single time,  but just give the number of agents

    Agent is being stored as agent data, which needs to be passed on to your initialization engine where you're creating all of these events or the broadcast messages. 

    <img src="C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241012111349750.png" alt="image-20241012111349750" style="zoom:67%;" />

 +  **Agent Dynamics**

    Differential Drive robot model

**SimEvents**: communication protocols for entites

+ essential queues with first in first out or last in first out or broadcast until the downstream block accepts it.
+ In our case, the downstream block is going to be a server, and the example we are looking at is a communication protocol where all of the agents talk to a particular serve. There is no peer to peer communication, but a peer to server communication

**Allocation Algorithms:**

+ A task [job] is defined as moving packages from point A to point B

  > depending on the cost and availability we can allocate the job to the least expensive agent.

  + COST associated to complete task
    + take into account the Manhattan distance of the route from A to B, as well as the current position of the agent.

  + Availability of the agent

    

+ Resource Allocation algorithm [in game theory domain]

  + Greedy algorithm
  + Hungarian Alogorithm
  + Auction Algorithm

+ Use state Machines or StateFlow from Simulink to keep track and manage task states

**Conflict Managment**

+ the tasking engine mainly depends on the routing engine to calculate the cost and update the cost every single time stamp of the simulation

+ **Conflict Management:**

  >  we have the cost as well as the task, we need to ensure that there is no conflict, or there is no chaos between the agents when they're trying to move about in a given 3D, 2D space

  + Reservation Principle
  + Multi-Agent Path Finding
  + Dynamic A*
  + Barrier Functions

+ Similarly we are planning multiple routes using the router, you can also use a state machine to manage these bots within the particular route they choose to travel

+ Calculate and update Cost Function

**Simulation:**

+ Plot relevant results to understand:
  1. Tasking Efficiency
  2. Assignment Matrix: which agent is assigned to each task
  3. Progression of Task States
  4. Health of Agents: whether the agent is available, busy or is broken down, or out of battery

## 4.4 Example

![image-20241012115217773](C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241012115217773.png)

### 4.4.1 Initialization Engine

where we would **create the bus signals** for agents and tasks

### 4.4.2 Agent Creation

![image-20241012115321588](C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241012115321588.png)

we have defined the bus and would create these entities using the entity generator where we would name it and it would get mapped to the entity pool.

As explained earlier, each entity has an ID, current position, type as well as a footprint. 

### 4.4.3 Task Engine & Routing Engine

![image-20241012115821495](C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241012115821495.png)

![image-20241012115921585](C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241012115921585.png)