A repository dedicated to the assigned tasks by Prokoders company.

#### Task #1:
Objective: Create a responsive settings screen using Flutter that mimics the provided design:  
![](https://i.ibb.co/16Zz334/task-1.png)  
Requirements:  
* Custom widgets: Utilize custom widgets to ensure reusability and clean code architecture. For instance, create custom widgets for the toggle buttons, text buttons, and section headers.  
* Responsive design: Make sure the UI is responsive across different screen sizes. Consider using MediaQuery  

Here is a sample output of the code:  
![](https://i.ibb.co/QkX1pMK/task-1-sample-output.jpg)  
#### Task #2:  
Objective: Create a user interface using Flutter that includes a list displaying tasks, with the ability to add a new task, delete a task, and mark a task as completed or incompleted using `GetX` for state management.  
Requirements:  
1. User Interface (UI):  
Design a simple and clean user interface that includes:
    * A list to dsiplay existing tasks.
    * A button to add a new task.
    * Icons or buttons to delete a task.
    * A checkbox or toggle to mark tasks as completed or incompleted.
2. Task Management:  
Implement a TaskController using GetX to manage the state of tasks. This should include:  
    * A list to hold tasks.
    * Functions to add new tasks to the list.
    * Functions to mark tasks as completed or incompleted.
3. State Management with GetX:  
    * Use GetX for state management to ensure that the UI updates automatically when tasks are added, deleted, or modified.
    * Implement GetX or Obs widgets to rebuild the UI whenever the state changes.
4. Task Actions:  
Ensure that the follwoing actions are supported and functional within the app:  
    * Add a new task: When the user clikcs the add button, a dialog or input field should appear to enter task details.
    * Delete a task: Implement functionality to remove a task from the list.
    * Mark task as completed/incompleted: Allow the user to mark a task as completed or revert it to incompleted.
5. UI Updates:  
Ensure that any changes in the task list (adding, deleting, and marking as completed/incompleted) are immediately reflected in the user interface.  
##### Key points in completing this task:  
* Third-party library implemetation:  
I have used some external packages in order to ensure that the UI is visually appealing, see the difference here for example:  

    |             | Fancy animation | Normal animation |
    | ---         | --- | --- |
    | add a task  | ![add a task](https://s11.gifyu.com/images/SooZn.gif)  | ![add a task](https://s11.gifyu.com/images/SoofG.gif) |
    | edit a task | ![edit a task](https://s11.gifyu.com/images/SooZR.gif)  | ![edit a task](https://s11.gifyu.com/images/SoofB.gif) |
    | delete a task | ![delete a task](https://s11.gifyu.com/images/SooZF.gif) | ![delete a task](https://s11.gifyu.com/images/SoofX.gif) | 
    | mark a task as completed | ![mark as completed](https://s11.gifyu.com/images/SooZ5.gif) | ![mark as completed](https://s11.gifyu.com/images/Soofe.gif)  
    | mark a task as incompleted | ![mark as incompleted](https://s11.gifyu.com/images/SooZG.gif) | ![mark as incompleted](https://s11.gifyu.com/images/SooY3.gif)  
* __Handling edge cases:__  
I have forbidden adding a task with an empty title:  
![a task with empty title](https://s11.gifyu.com/images/SooaL.gif)  
and the case of inputing the same title twice:  
![input the same title twice](https://s11.gifyu.com/images/Soofx.gif)
* __Events listening and auto UI updating:__  
I have effectively implemeted `GetX` to ensure the UI updates whenever there is a change, see deleting a task example above.
* __Clean, easy to edit, and reusable code:__  
I have ensured writing a clean code that would facilitate the process of editing or changing in later time.  
