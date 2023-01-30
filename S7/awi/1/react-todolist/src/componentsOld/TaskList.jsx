import React from "react";
import TaskForm from "./TaskForm";
import Task from "./Task";

class TaskList extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            tasks: this.props.tasks
        }
        this.addTask = (newTask) => {
            this.setState({ tasks: [...this.state.tasks, newTask] })
        }
    }

    render() {
        return (
            <div style={ { display: 'inline-block' } }>
                <h2>{this.props.name}</h2>
                { this.state.tasks.map(t => <Task title={ t }></Task> ) }
                <TaskForm handleClick={ this.addTask }></TaskForm>
            </div>
        )
    }
}

export default TaskList
