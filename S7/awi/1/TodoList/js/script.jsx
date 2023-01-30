const container = document.getElementById('container');

// class Task extends React.Component {
//     render() {
//         return <li>{ this.props.title }</li>
//     }
// }
const Task = (props) => <li>{ props.title }</li>

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

ReactDOM.render(
    <div>
        <h1>Todo lists</h1>
        <TaskList name='TODO 1' tasks={ ['T1', 'T2'] }> </TaskList>
        <TaskList name='TODO 3' tasks={ ['T3', 'T4'] }> </TaskList>
    </div>
    , container);
