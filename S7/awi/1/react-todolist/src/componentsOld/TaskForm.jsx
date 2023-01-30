import React from "react";
class TaskForm extends React.Component {

    constructor(props) {
        super(props)
        this.submit = () => {
            this.props.handleClick(this.state.newTask)
            this.setState({ newTask: '' })
        }
        this.state = {
            newTask: ''
        }
        this.handleChange = (event) => this.setState({ newTask: event.target.value })
    }

    render() {
        return (
            <div>
                <input name={ 'New task' } onChange={ this.handleChange } value={ this.state.newTask }/>
                <input type={ 'submit' } onClick={ this.submit }/>
            </div>
        )
    }
}

export default TaskForm
