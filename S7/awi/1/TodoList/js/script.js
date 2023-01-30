const container = document.getElementById('container'); // class Task extends React.Component {
//     render() {
//         return <li>{ this.props.title }</li>
//     }
// }

const Task = props => /*#__PURE__*/React.createElement("li", null, props.title);

class TaskList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tasks: this.props.tasks
    };

    this.addTask = newTask => {
      this.setState({
        tasks: [...this.state.tasks, newTask]
      });
    };
  }

  render() {
    return /*#__PURE__*/React.createElement("div", {
      style: {
        display: 'inline-block'
      }
    }, /*#__PURE__*/React.createElement("h2", null, this.props.name), this.state.tasks.map(t => /*#__PURE__*/React.createElement(Task, {
      title: t
    })), /*#__PURE__*/React.createElement(TaskForm, {
      handleClick: this.addTask
    }));
  }

}

class TaskForm extends React.Component {
  constructor(props) {
    super(props);

    this.submit = () => {
      this.props.handleClick(this.state.newTask);
      this.setState({
        newTask: ''
      });
    };

    this.state = {
      newTask: ''
    };

    this.handleChange = event => this.setState({
      newTask: event.target.value
    });
  }

  render() {
    return /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("input", {
      name: 'New task',
      onChange: this.handleChange,
      value: this.state.newTask
    }), /*#__PURE__*/React.createElement("input", {
      type: 'submit',
      onClick: this.submit
    }));
  }

}

ReactDOM.render( /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("h1", null, "Todo lists"), /*#__PURE__*/React.createElement(TaskList, {
  name: "TODO 1",
  tasks: ['T1', 'T2']
}, " "), /*#__PURE__*/React.createElement(TaskList, {
  name: "TODO 3",
  tasks: ['T3', 'T4']
}, " ")), container);