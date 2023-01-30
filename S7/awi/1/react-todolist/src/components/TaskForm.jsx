import React, {useState} from "react";

function TaskForm(props) {

    // Init state
    const [newTask, setNewTask] = useState('')

    // Handlers
    const submit = () => {
        props.handleClick(newTask)
        setNewTask('')
    }

    const handleChange = (event) => setNewTask(event.target.value)

    // Return UI
    return (
        <div>
            <input name={ 'New task' } onChange={ handleChange } value={ newTask }/>
            <input type={ 'submit' } onClick={ submit }/>
        </div>
    )
}

export default TaskForm
