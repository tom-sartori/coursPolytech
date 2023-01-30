import './App.css';
import TaskList from "./components/TaskList";

function App() {
    return (
        <div>
            <h1>Todo lists</h1>
            <TaskList name='TODO 1'> </TaskList>
            <TaskList name='TODO 3'> </TaskList>
        </div>
    );
}

export default App;
