import React, {useEffect, useState} from "react";
import TaskForm from "./TaskForm";
import Task from "./Task";

function TaskList(props) {
    // Init state
    const [tasks, setTasks] = useState([])

    // Handlers
    const addTask = (newTask) => {
        setTasks( tasks => [...tasks, newTask] )
    }

    // Effects
    // Fetching data for the todoList
    useEffect( () => {
        fetch('http://localhost:3001/tasks')
            .then(resp => resp.json())
            .then(data => setTasks(data.map(t => t.title)))
    }, [])

    // Return UI
    return (
        <div style={ { display: 'inline-block' } }>
            <h2>{ props.name }</h2>
            { tasks.map(t => <Task title={ t }></Task> ) }
            <TaskForm handleClick={ addTask }></TaskForm>
        </div>
    )
}

export default TaskList
