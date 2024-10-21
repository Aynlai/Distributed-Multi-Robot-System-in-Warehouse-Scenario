# 0. Initialization Settings

## 0.1 Before simulation starts

<img src="https://github.com/steynmulder/distributed-perception-warehouse/blob/dev/fig/1.png?raw=true" style="zoom:67%;" />

Simulink- 'Modeling' - 'Model Properties'

Some common callback events include:

- **PreLoadFcn**: Code that runs before the model is loaded.
- **InitFcn**: Code that runs before the simulation starts.
- **StartFcn**: Code that runs when the simulation begins.
- **StopFcn**: Code that runs when the simulation ends.

<img src="https://github.com/steynmulder/distributed-perception-warehouse/blob/dev/fig/2.png?raw=true" style="zoom: 67%;" />

Here we use 'exampleMultiAgentInit.m' file 



## 0.2 Understand InitMultiAgent.m file

To understand Initialization file you need to know the following knowledge

### 0.2.1 Common Operations with`.mat` File

#### 0.2.1.1 Saving Data to a `.mat` File

Creating a **`.mat` file** in MATLAB is straightforward. Use the `save` function to create the file and store variables from workspace into it. 

Before saving data to a `.mat` file, you need to have some variables in the MATLAB workspace. 

Once you have the variables in the workspace, use the `save` function to store them in a `.mat` file. You can either save all the variables or choose specific ones.

This command saves **all the variables** currently in the workspace into a file called `myData.mat`. MATLAB automatically creates the file in the current working directory.

```matlab
save('myData.mat');
```

If you only want to save specific variables (e.g., `a` and `b`), you can specify them in the `save` command:

```matlab
% Example of saving specified variables
a = 10;
b = [1, 2, 3; 4, 5, 6];
save('myData.mat', 'a', 'b');
```

#### 0.2.1.2 **Loading Data from a `.mat` File**

```matlab
% Example of loading variables
load('myData.mat');
```

Alternatively, you can load specific variables from a `.mat` file:

```matlab
% Loading only variable 'a' from the file
load('myData.mat', 'a');
```

MATLAB `.mat` files have different versions, and you may want to specify a version depending on your needs. By default, MATLAB saves in version 7, which is compressed. If you are working with very large datasets, you might prefer version 7.3, which supports HDF5 format.

```matlab
save('myData.mat','-v7.3');
```

#### 0.2.1.3 Inspecting the Contents of a `.mat` File

If you want to check what variables are stored inside a `.mat` file without loading them into your workspace, you can use the `whos` command:

```matlab
whos -file myData.mat
```

This will list the names, sizes, and types of all variables stored in `myData.mat`.

#### 0.2.1.4 Properties of `.mat`  File

+ `.mat` files is a binary file. It is optimized for use in MATLAB and offers faster read and write speeds than many other file formats (like text or CSV).

+  `.mat` files can store almost any type of MATLAB data, including matrices, structures, cell arrays, and even objects. Other file formats like CSV or text files may struggle with non-numeric data or complex structures.

+ `.mat` files can be shared and used across different versions of MATLAB. Additionally, other programs like Python (via SciPy's `loadmat`) can also read `.mat` files, making it easy to share data across platforms.

------

### 0.2.2 [P-Code File](https://se.mathworks.com/help/matlab/matlab_prog/building-a-content-obscured-format-with-p-code.html)

If a function or file is defined as a `.p` file(for example, TaskingAlgorithm.p), it means that `TaskingAlgorithm` is implemented as a protected class or function in Matlab.

+ A **`.p` file** is a **Content-Obscured MATLAB file** that allows you to share or deploy MATLAB functions, scripts, or classes without exposing the underlying source code.
+ It behaves the same as the source `.m` file for which it was produced, meaning you can call functions or classes defined in a `.p` file just like you would with an `.m` file.
+ `.p` files are often used when distributing code to users, clients, or collaborators while keeping proprietary algorithms or logic confidential.

#### 0.2.2.1 Create P-Code Files

To generate a P-code file, enter the following command in the MATLAB Command Window:

```matlab
pcode file1.m file2.m
```

The command produces the files `file1.p`, `file2.p`, and so on. To convert all `.m` source files residing in your current folder to P-code files, use the command:

```matlab
pcode *.m
```

------



### 0.2.3 [`struct` Data Type](https://www.mathworks.com/help/releases/R2024a/matlab/ref/struct.html)

A *structure array* is a data type that groups related data using data containers called *fields*. Each field can contain any type of data. Access data in a field using dot notation of the form `structName.fieldName`.

#### 0.2.3.1 Creation

When you have data to put into a new structure, create the structure using dot notation to name its fields one at a time:

```matlab
% Initialize an empty structure
% Not compulsory
person = struct();

% Add fields one by one
s.a = 1;
s.b = {'A','B','C'}
s = struct with fields:
    a: 1
    b: {'A'  'B'  'C'}
```

Field names can contain ASCII letters (A–Z, a–z), digits (0–9), and underscores, and must begin with a letter. The maximum length of a field name is `namelengthmax`.

You also can create a structure array using the `struct` function, described below. You can specify many fields simultaneously, or create a non-scalar structure array.

**Syntax**

```matlab
s = struct
s = struct(field,value)
s = struct(field1,value1,...,fieldN,valueN)
s = struct([])
s = struct(obj)
```

#### 0.2.3.2 Accessing a Data in a `struct`

You can access the values stored in a structure using dot notation.

```matlab
% Access the name field
person.name
% Output: 'Alice'

% Access the age field
person.age
% Output: 28

% Modify the value of the age field
person.age = 29;

% Access the address field
person.address
% Output: '456 Elm St'
```

#### 0.2.3.3 Structure Array

You can also create an array of structures, where each element of the array is a structure with the same fields.

In this case, `people` is an array of structures, and each element of the array contains a structure with `name`, `age`, and `address` fields.

```matlab
% Create an array of structures
people(1) = struct('name', 'John', 'age', 30, 'address', '123 Main St');
people(2) = struct('name', 'Alice', 'age', 28, 'address', '456 Elm St');

% Access the second person's name
people(2).name
% Output: 'Alice'
```

#### 0.2.3.4 Adding Nested Structures

```matlab
% Create a nested structure
person = struct('name', 'John', 'age', 30);
person.address = struct('street', '123 Main St', 'city', 'New York', 'zip', '10001');

% Access the nested structure's fields
person.address.city
% Output: 'New York'
```

------



### [0.2.4 Simulink.Bus](https://www.mathworks.com/help/releases/R2024a/simulink/slref/simulink.bus.html)

#### 0.2.4.1 Bus Object

1. A simulink.bus object specifies only the architectural properties of a bus. 

   + as distinct from the values of the signals it contains.
     + For example, a bus object can specify  the number of elements in a bus, element names, hierarchy, order, whether and how elements are nested, and the data types of constituent signals; but not the signal values.

   + A bus object is analogous to a struct in C code because it defines the members of the bus but does not define the values of the element(signal).
   + A bus object is also similar to a cable connector. The connector defines all the pins and their configuration and controls what types of wires can be connected to it. Similarly, a bus object defines the configuration and properties of the signals that the associated bus must have.

2. `Simulink.Bus` objects contain `Simulink.BusElement` objects.
   +  Each bus element object specifies the properties of a signal in a bus, such as its name, data type, and dimension. 
   + The order of the bus element objects in the bus object defines the order of the signals in the bus.
3. Each bus object provides a reusable specification for a bus
   + Multiple blocks, objects, and model components can specify the same bus object.

#### 0.2.4.2 Bus Element

Bus Element is one of the properties of Bus Object

Refer to **0.2.3.3-2.Create Bus Objects from Bus Element Objects Programmatically**

You can create a `Simulink.BusElement` object in multiple ways.

- To interactively create a `Simulink.BusElement` object, use the [Type Editor](https://se.mathworks.com/help/releases/R2024a/simulink/slref/typeeditor.html) or [Model Explorer](https://se.mathworks.com/help/releases/R2024a/simulink/slref/modelexplorer.html).
- To programmatically create a default `Simulink.BusElement` object, use the `Simulink.BusElement` function (described here)

**Syntax**

```matlab
be = Simulink.BusElement
```

#### 0.2.4.3 Creation Bus Object

You can create a `Simulink.Bus` object in multiple ways.

- To interactively create a `Simulink.Bus` object, use the [Type Editor](https://se.mathworks.com/help/releases/R2024a/simulink/slref/typeeditor.html) or [Model Explorer](https://se.mathworks.com/help/releases/R2024a/simulink/slref/modelexplorer.html). Bus objects created with either tool are initially stored in the base workspace or a data dictionary.
- To programmatically create `Simulink.Bus` objects from blocks in a model, MATLAB data, and external C code, see [Programmatically Create Simulink Bus Objects](https://se.mathworks.com/help/releases/R2024a/simulink/ug/create-bus-objects-programmatically.html).[No.3]
  -  Bus objects created programmatically are initially stored in the base workspace, a data dictionary, or a function.

You cannot store `Simulink.Bus` objects in model workspaces. As you create bus objects programmatically, you can store them in the MATLAB® workspace or a data dictionary or **save** their definitions in a function. 

To simulate a block that uses a bus object, that bus object must be in the base workspace or in a data dictionary.

1. **Use TypeEditor to create a bus object**

   <img src="https://github.com/steynmulder/distributed-perception-warehouse/blob/dev/fig/3.png?raw=true" style="zoom:67%;" />

   **Create a bus object:**

   In the Add gallery, Click ![Create types](https://se.mathworks.com/help/releases/R2024a/simulink/slref/type-editor-create-types-button-without-arrow.png)

   **Add elements:**

   <img src="https://github.com/steynmulder/distributed-perception-warehouse/blob/dev/fig/4.png?raw=true" style="zoom:67%;" />

   Nest the bus objects:

   set the element's **DataType** to **Bus: xxx[another bus object's name]**

2. **Use a Simulink Block: Bus Creator**

   To programmatically create a `Simulink.Bus` object based on a block in a model, use the [`Simulink.Bus.createObject`](https://se.mathworks.com/help/releases/R2024a/simulink/slref/simulink.bus.createobject.html) function.

   The Bus Creator block combines input signals or messages into a bus, which retains the separate identities of the signals and messages.

   By default, the Bus Creator block creates a *virtual bus*, which is analogous to a bundle of wires held together by tie wraps. Alternatively, the block can **[create a *nonvirtual bus*,](https://se.mathworks.com/help/releases/R2024a/simulink/slref/buscreator.html)** which is analogous to a structure in C code.

   ![TopBus groups NestedBus and Step in a virtual bus. NestedBus groups Chirp and Sine in a virtual bus.](https://se.mathworks.com/help/releases/R2024a/examples/simulink/win64/CreateNonvirtualBusesWithinAComponentExample_01.png)

   The virtual buses in this model are not defined by *Simulink.Bus* objects. To change the output of the Bus Creator blocks to non-virtual buses, you must have bus objects that match the bus hierarchy

   To create the bus objects that correspond to *TopBus* and NestedBus, use the *Simulink.Bus.createObject* function. In the Matlab Command Window, enter this command

   ```matlab
   %This function creates the bus object that corresponds to the output bus of the specified block.
   Simulink.Bus.createObject("BusHierarchy","BusHierarchy/Bus Creator1");
   ```

   If the output bus contains nested buses, the function also creates bus objects that correspond to the nested buses. In this example, the function creates two bus objects that are named after the corresponding buses, `TopBus` and `NestedBus`.

   To view the bus objects, open the **Type Editor**. In the Simulink® Toolstrip, on the **Modeling** tab, in the **Design** gallery, click **Type Editor**. To expand an external data source or bus, click the arrow next to its name.

   ![Type Editor with bus objects for NestedBus and TopBus](https://se.mathworks.com/help/releases/R2024a/examples/simulink/win64/CreateNonvirtualBusesWithinAComponentExample_02.png)

   Now that you have bus objects that correspond to the nonvirtual buses you want to create, create the nonvirtual buses. In the Simulink Editor, double-click the Bus Creator block named `Bus Creator1`. In the Block Parameters dialog box, set **Output data type** to `Bus: TopBus`, select the **Output as nonvirtual bus** check box, and click **OK**. `TopBus` is now a nonvirtual bus, while `NestedBus` remains a virtual bus. To identify the nonvirtual bus by line style, compile the model.

   ![TopBus with the line style that indicates a nonvirtual bus](https://se.mathworks.com/help/releases/R2024a/examples/simulink/win64/CreateNonvirtualBusesWithinAComponentExample_03.png)

   Double-click the block named `Bus Creator`. In the Block Parameters dialog box, set **Output data type** to `Bus: NestedBus`, select the **Output as nonvirtual bus** check box, and click **OK**. `NestedBus` is now a nonvirtual bus. To update its line style, compile the model.

   ![NestedBus with the line style that indicates a nonvirtual bus](https://se.mathworks.com/help/releases/R2024a/examples/simulink/win64/CreateNonvirtualBusesWithinAComponentExample_04.png)

   If you do not save the bus objects, then you must recreate the bus objects when you reopen the model. For information on how to save the bus objects, see [Specify Bus Properties with Bus Objects](https://se.mathworks.com/help/releases/R2024a/simulink/ug/when-to-use-bus-objects.html).

   Elements of a bus must have unique names. By default, each element of the bus inherits the name of the element connected to the Bus Creator block.

   + If duplicate names are present, the Bus Creator block appends the port number to all input element names.
   + For elements that do not have names, the Bus Creator block generates names in the form `signaln`, where `n` is the port number connected to the element. You can refer to elements by name when you search for their sources or select elements for connection to other blocks. For element naming guidelines, see [Signal Names and Labels](https://se.mathworks.com/help/releases/R2024a/simulink/ug/signal-basics.html#brh77af-1).
   + To extract elements from the bus by name, use a [Bus Selector](https://se.mathworks.com/help/releases/R2024a/simulink/slref/busselector.html) block

3. **Create Bus Objects from Bus Element Objects Programmatically**

   Create a hierarchy of `Simulink.Bus` objects using arrays of `Simulink.BusElement` objects.

   Create an array that contains two `BusElement` objects, named `Chirp` and `Sine`, in the base workspace.

   ```matlab
   elems(1) = Simulink.BusElement;
   elems(1).Name = 'Chirp';
   
   elems(2) = Simulink.BusElement;
   elems(2).Name = 'Sine';
   ```

   Array indexing lets you create and access the elements of the array. Dot notation lets you access property values of the elements.

   Create a `Bus` object, named `Sinusoidal`, that contains the elements defined in the `elems` array.

   ```matlab
   Sinusoidal = Simulink.Bus;
   Sinusoidal.Elements = elems;
   ```

   To create a hierarchy of `Bus` objects, create another `Bus` object to reference the `Bus` object named `Sinusoidal`.

   Create an array that contains two `BusElement` objects, named `NestedBus` and `Step`. Specify the `Bus` object named `Sinusoidal` as the data type of the `NestedBus` element.

   ```matlab
   clear elems
   
   elems(1) = Simulink.BusElement;
   elems(1).Name = 'NestedBus';
   elems(1).DataType = 'Bus: Sinusoidal';
   
   elems(2) = Simulink.BusElement;
   elems(2).Name = 'Step';
   ```

   Create a `Bus` object, named `TopBus`, that contains the elements defined in the `elems` array.

   ```matlab
   TopBus = Simulink.Bus;
   TopBus.Elements = elems;
   ```

   You can view the hierarchy of the created objects in the **Type Editor**.

   ```matlab
   typeeditor
   ```

   **Similar to 1. Simulink Block: Bus Creator**

   ![image-20241014161656182](https://se.mathworks.com/help/releases/R2024a/examples/simulink/win64/CreateNonvirtualBusesWithinAComponentExample_03.png)

   + **Inspect Bus Objects Programmatically**

     While the [Type Editor](https://se.mathworks.com/help/releases/R2024a/simulink/slref/typeeditor.html) lets you inspect a hierarchy of `Simulink.Bus` objects interactively, you can also inspect the objects programmatically.

     Open the example. Then, load the bus objects by running the function named `busObjectDefinition`.

     ```matlab
     % cannot store `Simulink.Bus` objects in model(base) workspaces
     % Run the above creation code again to get the 2 bus objects
     % openExample('simulink/InspectBusObjectsProgrammaticallyExample')
     busObjectDefinition
     ```

     Two bus objects appear in the base workspace.

     Inspect the top-level bus object, which is named `TopBus`.

     ```matlab
     TopBus
     %Inspect the elements of TopBus.
     TopBus.Elements(1)
     %Inspect the elements of the nested Simulink.Bus object named Sinusoidal.
     Sinusoidal
     ```

   + **Inspect Leaf Elements of Bus Objects**

     To directly inspect the leaf elements of a bus object, use the `getNumLeafBusElements` and `getLeafBusElements` object functions.

     ```matlab
     % To get the number of leaf elements in `TopBus`, use the `getNumLeafBusElements` object function.
     num = getNumLeafBusElements(TopBus)
     % To get information about the leaf elements in TopBus, use the getLeafBusElements object function. For example, inspect the first element of TopBus.
     leaf = getLeafBusElements(TopBus);
     leaf(1)
     ```

4. **Create Bus Objects from Matlab Data**

   **[Not used in this project, for reference]**

   To create a `Simulink.Bus` object from a cell array, use the [`Simulink.Bus.cellToObject`](https://se.mathworks.com/help/releases/R2024a/simulink/slref/simulink.bus.celltoobject.html) function. Each subordinate cell array represents another bus object.

   To create a bus object from a MATLAB structure, use the [`Simulink.Bus.createObject`](https://se.mathworks.com/help/releases/R2024a/simulink/slref/simulink.bus.createobject.html) function. The structure can contain MATLAB `timeseries`, MATLAB `timetable`, and `matlab.io.datastore.SimulationDatastore` objects or be a numeric structure.

5. **Create Bus Objects from External C Code**

   **[Not used in this project, for reference]**

   You can create a `Simulink.Bus` object that corresponds to a structure type (`struct`) that your existing C code defines. Then, in preparation for integrating existing algorithmic C code for simulation (for example, by using the Legacy Code Tool), you can use the bus object to package signal or parameter data according to the structure type. To create the object, use the [`Simulink.importExternalCTypes`](https://se.mathworks.com/help/releases/R2024a/simulink/slref/simulink.importexternalctypes.html) function.

#### 0.2.4.4  **Save Bus Objects**

As you create bus objects programmatically,

You can save `Simulink.Bus` objects to these locations:

- Data dictionary
- Function 
- MAT-file
- Database or other external files [[refer to](https://se.mathworks.com/help/releases/R2024a/simulink/slref/simulink.bus.html): openExample('simulink/InspectBusObjectsProgrammaticallyExample')]

If you do not save bus objects, then when you reopen a model that uses the bus objects, you need to recreate the bus objects.

Choose where to store bus objects based on your modeling requirements.

| Modeling Requirement                                         | Location                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| Store data for large models and model hierarchies.           | Use a data dictionary.<br />When you save to a data dictionary from the base workspace, you get all the variables used by the model, not just the `Simulink.Bus` objects.To save changes to a data dictionary, use the [Type Editor](https://se.mathworks.com/help/releases/R2024a/simulink/slref/typeeditor.html) or [Model Explorer](https://se.mathworks.com/help/releases/R2024a/simulink/slref/modelexplorer.html).To update a model to use a data dictionary, see [Migrate Models to Use Simulink Data Dictionary](https://se.mathworks.com/help/releases/R2024a/simulink/ug/migrate-models-to-use-dictionary.html). |
| Use MATLAB® for traceability and model differencing.         | Use a script or function.<br />To create a script or function that defines one or more `Simulink.Bus` objects, use the [Type Editor](https://se.mathworks.com/help/releases/R2024a/simulink/slref/typeeditor.html), [Model Explorer](https://se.mathworks.com/help/releases/R2024a/simulink/slref/modelexplorer.html), or [`Simulink.Bus.save`](https://se.mathworks.com/help/releases/R2024a/simulink/slref/simulink.bus.save.html) function. |
| Save and load bus objects faster.                            | Use a MAT file.<br />To create a MAT file that contains `Simulink.Bus` objects from the base workspace, use the [Type Editor](https://se.mathworks.com/help/releases/R2024a/simulink/slref/typeeditor.html), [Model Explorer](https://se.mathworks.com/help/releases/R2024a/simulink/slref/modelexplorer.html), or [`save`](https://se.mathworks.com/help/releases/R2024a/matlab/ref/save.html) function. |
| Compare bus interface information with design documents stored in an external data source | Use a database or other external files.<br />Use the [`Simulink.importExternalCTypes`](https://se.mathworks.com/help/releases/R2024a/simulink/slref/simulink.importexternalctypes.html) function, scripts, or Database Toolbox™ functionality on C code structure (`struct`) definitions. In preparation for integrating existing algorithmic C code for simulation, for example, by using the Legacy Code Tool, you can package signal or parameter data in the definitions according to structure type. |

To save bus objects stored in the base workspace, you can use any MATLAB technique that saves the contents of the base workspace. However, the resulting file contains everything in the base workspace, not just bus objects.

**When you modify bus objects, you must resave them to keep the changes.**

#### 0.2.4.5 Specify Bus Object

After you create a `Simulink.Bus` object and specify its attributes, you can associate it with a block or object that needs the bus definition.

Use a `Simulink.Bus` object to specify bus properties for these blocks and objects:

- [Bus Creator](https://se.mathworks.com/help/releases/R2024a/simulink/slref/buscreator.html) block
- [Constant](https://se.mathworks.com/help/releases/R2024a/simulink/slref/constant.html) block
- [Data Store Memory](https://se.mathworks.com/help/releases/R2024a/simulink/slref/datastorememory.html) block
- [In Bus Element](https://se.mathworks.com/help/releases/R2024a/simulink/slref/inbuselement.html) block
- [Inport](https://se.mathworks.com/help/releases/R2024a/simulink/slref/inport.html) block
- [Out Bus Element](https://se.mathworks.com/help/releases/R2024a/simulink/slref/outbuselement.html) block
- [Outport](https://se.mathworks.com/help/releases/R2024a/simulink/slref/outport.html) block
- [Signal Specification](https://se.mathworks.com/help/releases/R2024a/simulink/slref/signalspecification.html) block
- [`Simulink.BusElement`](https://se.mathworks.com/help/releases/R2024a/simulink/slref/simulink.buselement.html) object
- [`Simulink.Parameter`](https://se.mathworks.com/help/releases/R2024a/simulink/slref/simulink.parameter.html) object
- [`Simulink.Signal`](https://se.mathworks.com/help/releases/R2024a/simulink/slref/simulink.signal.html) object

To associate a block or object with a bus object, set the data type of the block or object to `Bus: <object name>` and replace `<object name>` with the `Simulink.Bus` object name. When you set the data type of a `Simulink.BusElement` object to a `Simulink.Bus` object, the `Bus:` prefix is optional.

You can specify the bus object as the data type either before or after defining the bus object. However, before you simulate the model, you must define and load the `Simulink.Bus` object.

During model development, you can modify buses to match bus objects or modify bus objects to match buses. If you do not want to change the bus object, you can:

- Create a bus object that matches the changes to the bus and use the new bus object for the blocks that the changed bus connects to.
- Revert the bus changes so that the bus continues to match the associated bus object.

#### 0.2.4.6 Map Simulink Bus Objects to Models

Before you simulate a model, all the `Simulink.Bus` objects it uses must be loaded into the base workspace or a data dictionary used by the model. For automation and consistency across models, mapping bus objects to models is important.

To ensure the necessary bus objects load before model execution, consider these approaches:

- Projects — Automatically load or run files that define bus objects by configuring the files to run when you open a project. For details, see [Project Management](https://se.mathworks.com/help/releases/R2024a/simulink/project-management.html).

- Data dictionaries — Store bus objects with variables and other objects for one or more models.

  To share a bus object among models, you can link each model to a dictionary and create a common referenced dictionary to store the object. For an example, see [Partition Dictionary Data Using Referenced Dictionaries](https://se.mathworks.com/help/releases/R2024a/simulink/ug/partition-dictionary-into-reference-dictionaries.html).

- Databases — Capture mapping information in an external data source, such as a database.

- **Model callbacks** — Load or run files that define bus objects by using a model callback, such as `PreLoadFcn`. For more information, see [Model Callbacks](https://se.mathworks.com/help/releases/R2024a/simulink/ug/model-callbacks.html). **[here, we use this way to load bus objects as mentioned in the beginning of file]**

  **If a model uses only a few bus objects, consider copying the bus object code directly into the callback, instead of loading a file.**

# 1 World Module

+  **Simevents Toolbox**

## 1.1 [Entity Generator](https://se.mathworks.com/help/simevents/ref/entitygenerator.html)

The **Entity Generator** acts as the **starting point** for entities within a SimEvents model. 

[Entities](https://se.mathworks.com/help/simevents/gs/role-of-entities-in-simevents-models.html) are discrete items of interest in a discrete-event simulation. By definition, these items are called *entities* in SimEvents® software. 

Entities can pass through a network of queues, servers, gates, and switches during a simulation. Entities can carry data, known in SimEvents software as *attributes*.

### 1.1.1 Parameters: Time Source

By default the block entity generation method is Time-based. 

In this project, the block generates entities using [intergeneration times specified](https://se.mathworks.com/help/simevents/ug/specifying-intergeneration-times-for-entities.html) by the Period [read the code in the link to understand attribute:`dt` and how to write the intergeneration times specified function]

<img src="C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241019170219039.png" alt="5" style="zoom:50%;" />

The code within the **Intergeneration time action** field acts like a function that is invoked whenever the SimEvents engine needs to determine the time until the next entity generation.

```matlab
%The persistent variables dtArray and index are declared to retain their values between these internal calls.
persistent dtArray index 

% initialization of dtArray
if isempty(dtArray)
    dtArray = [zeros(1,numAgents-1] inf];
    inden = 1;
end

% dtArray = [0, 0, 0, 0, inf];
% The array [0, 0, 0, 0] represents the time intervals between generating the first 4 entities (each 0 means the next entity is generated immediately).

dt = dtArray(index);
index = index + 1;
```

### 1.1.2 Parameters: Entity type

Choose the type of entity to generate. The `Bus object` type lets you generate bus objects as entities.

+ Click **Launch Type Editor** to open the Type Editor to generate bus objects. 
+ load the `.mat` data into workspace first

![6](C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241019171834509.png)

### 1.1.3 Parameters: Event actions

Define the behavior in the Event action parameter. The Generate action is called when an entity is generated and the Exit action is called just before an entity exits the block.

<img src="C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241019172730015.png" alt="7" style="zoom:67%;" />

+ The `agent` Bus Object acts as a **template** or **structure** that defines the data fields (attributes) for each entity.
+ Each field in the `entity` object refers to a **corresponding Bus Element** in the `agent` Bus Object.

+ During entity generation, the **Event Actions** block assigns **initial values** to these fields.

### Example Use Case:

Consider a scenario in a **warehouse logistics simulation** where autonomous robots need to move packages:

- The **Entity Generator** might create entities representing the **robots**.
- Each robot could have attributes like `Id`, `CurrentPosition`, `Velocity`, and `TaskId`.
- The **Entity Generator** releases these robot entities into the simulation at specific time intervals, such as when the warehouse opens or when a new package needs to be delivered.
- Once generated, these robot entities flow through different parts of the model, such as **queues** or **servers** that represent various stages of their tasks, like picking up a package or navigating through the warehouse.

## 1.2 FIFO Queue



## 1.3 EntityServer

In a discrete-event simulation, a server stores entities for a length of time, called *service time*, and then attempts to output the entity. 

During the service period, the block is said to be *serving* the entity that it stores.

### 1.3.1 Service Capacity and Time

![8](C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241019180108043.png)

### 1.3.2 Event actions

![image-20241019180146247](C:\Users\Ryan\AppData\Roaming\Typora\typora-user-images\image-20241019180146247.png)



## 1.4 EntityTerminator

# 2 Entity Pool Module

## 2.1 Data Initializer

