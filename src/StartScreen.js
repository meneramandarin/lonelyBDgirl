import React from 'react';

const StartScreen = ({ onStartClick }) => {
  // Simple pixel-style button with hover effect
  const pixelButton = {
    fontFamily: "'IBM Plex Mono', monospace",
    fontSize: '24px',
    color: '#FF1493', // Dark pink
    backgroundColor: '#FFC0CB', // Light pink
    border: '4px solid #FF1493',
    padding: '10px 40px',
    cursor: 'pointer',
    position: 'relative',
    overflow: 'hidden',
    boxShadow: '0 6px 0 #FF69B4',
    transition: 'all 0.1s',
    transform: 'translateY(0)',
    textTransform: 'uppercase',
    letterSpacing: '1px',
    fontWeight: 'bold',
  };

  const handleStartClick = () => {
    console.log('Game started!');
    // Call the onStartClick prop to notify parent component
    onStartClick();
  };

  return (
    <>
      {/* Font import in the component itself */}
      <style>
        {`
          @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;700&display=swap');
          
          body {
            margin: 0;
            padding: 0;
            overflow: hidden;
          }
        `}
      </style>

      <div 
        style={{
          width: '100vw',
          height: '100vh',
          backgroundColor: '#FFC0CB', // Light pink
          display: 'flex',
          flexDirection: 'column',
          justifyContent: 'center',
          alignItems: 'center',
          fontFamily: "'IBM Plex Mono', monospace",
        }}
      >
        <h1 
          style={{
            color: '#FF1493', // Dark pink
            fontSize: '72px',
            marginBottom: '60px',
            textShadow: '4px 4px 0px #FF69B4',
            fontWeight: 'bold',
            fontStyle: 'italic',
          }}
        >
          Lonely BD Girl
        </h1>
        
        <button 
          style={pixelButton}
          onClick={handleStartClick}
          onMouseDown={(e) => {
            e.currentTarget.style.transform = 'translateY(4px)';
            e.currentTarget.style.boxShadow = '0 2px 0 #FF69B4';
          }}
          onMouseUp={(e) => {
            e.currentTarget.style.transform = 'translateY(0)';
            e.currentTarget.style.boxShadow = '0 6px 0 #FF69B4';
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.transform = 'translateY(0)';
            e.currentTarget.style.boxShadow = '0 6px 0 #FF69B4';
          }}
        >
          Start
        </button>
      </div>
    </>
  );
};

export default StartScreen;