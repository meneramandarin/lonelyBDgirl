import React, { useState } from 'react';
import LonelyBDGirlGame from './LonelyBDGirlGame';
import StartScreen from './StartScreen';

function App() {
  const [gameStarted, setGameStarted] = useState(false);

  const handleStartGame = () => {
    setGameStarted(true);
  };

  return (
    <div className="App">
      {!gameStarted ? (
        <StartScreen onStartClick={handleStartGame} />
      ) : (
        <LonelyBDGirlGame />
      )}
    </div>
  );
}

export default App;