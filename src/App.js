import logo from "./logo.svg";
import "./App.css";

function App() {
  const backendApi = "192.168.1.50";
  console.log("Connecting to backend at: " + backendApi);
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <a
          className="App-link"
          href="https://example.com"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn Jenkins on Udemy KING
        </a>
      </header>
      <p>Application version: 1</p>
    </div>
  );
}

export default App;
