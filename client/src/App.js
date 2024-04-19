import React, {useState, useEffect} from 'react';
import './App.css';
import Lottery from './contracts/Lottery.json';
import web3 from 'web3';

function App(){
  const [balance, setBalance] = useState(null);
  const [web3, setWeb3] = useState(null);
  const [accounts, setAccounts] = useState('');
  const [contract, setContract] = useState('');

  useEffect(() => {
    const init = async() => {
      try {
        const web3 = new web3(web3.givenProvider || "http://localhost:7545")
        // const web3 = await web3();
        // Users
        const accounts = await web3.eth.getAccounts();
        // this.setState({ account: accounts[0] })
    
        // Contrat
        const networkId = await web3.eth.net.getId();
        // HTTP://127.0.0.1:7545
        const deployedNetwork = Lottery.networks[networkId];
        const contract = new web3.eth.Contract(
          Lottery.abi,
          deployedNetwork && deployedNetwork.address
        );
        setWeb3(web3);
        setAccounts(accounts);
        setBalance(balance);
        setContract(contract);
        } catch(error){
          alert(
            "Échec de la connexion."
          );
          console.error(error);
        }
      }
    init();
  }, []);

  useEffect(()=> {
    const load = async() => {
      await contract.methods.set(5).send({from : accounts[0]});
      const answer = await contract.methods.get().call();
      setBalance(answer);
    }
    if(typeof web3 !== 'undefined'
      && typeof accounts !== 'undefined'
      && typeof contract !=='undefined') {
        load();
      }
  }, [web3, accounts, contract]);

  return (
    <div className="App">
      <h1>Lottery</h1>
      <h1>{this.state.balance}</h1>
      <h3>Un minimum de 10 personnes doit être atteint! ✌️</h3>
      <h3>Présentement, voici le nombre : {this.state.players}</h3>
      <h3>{this.state.admin}</h3>

      <br></br>
      <button onClick={this.enter}>Participe!</button>
      <br></br>
      <p>Message de Lottery : {this.state.message}</p>

      <p>Votre compte ETH [adresse] : {this.state.account}</p>
      <p>Votre balance ETH : {this.state.balance}</p>
      <div>
        <p>Count: {this.state.count}</p>
        <button onClick={this.handleIncrement}>Increment</button>
      </div>
      <div>
        <button onClick={this.resetIncrement}>Reset</button>
      </div>
    </div>
  )
}

export default App;
