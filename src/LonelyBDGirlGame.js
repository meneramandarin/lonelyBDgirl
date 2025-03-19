import React, { useEffect, useRef, useState } from 'react';
import * as THREE from 'three';

const LonelyBDGirlGame = () => {
  const mountRef = useRef(null);
  const [gameStatus, setGameStatus] = useState('Loading...');

  useEffect(() => {
    // Scene setup
    const scene = new THREE.Scene();
    scene.background = new THREE.Color(0xffcce6); // LIGHT PINK background

    // Camera setup (orthographic for top-down 2D style)
    const camera = new THREE.OrthographicCamera(
      -12, 12, 9, -9, 0.1, 1000
    );
    camera.position.set(0, 15, 0);
    camera.lookAt(0, 0, 0);

    // Renderer setup
    const renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setSize(800, 600);
    mountRef.current?.appendChild(renderer.domElement);
    
    // Exit early if we can't mount the renderer
    if (!mountRef.current) {
      return () => {};
    }

    setGameStatus('Use arrow keys to move');

    // Create grid-based floor
    const gridSize = 30;
    const cellSize = 1;
    
    // Create floor tiles with nicer pattern
    const floorGroup = new THREE.Group();
    scene.add(floorGroup);
    
    for (let x = -gridSize/2; x < gridSize/2; x++) {
      for (let z = -gridSize/2; z < gridSize/2; z++) {
        // Create more interesting pattern
        let color;
        const isPathX = (x % 5 === 0);
        const isPathZ = (z % 5 === 0);
        const isCorner = isPathX && isPathZ;
        
        if (isCorner) {
          color = 0xeeaabb; // Slightly darker pink for intersections
        } else if (isPathX || isPathZ) {
          color = 0xffbbcc; // Medium pink for paths
        } else {
          // Checkerboard for non-path areas
          const isEven = (x + z) % 2 === 0;
          color = isEven ? 0xffd6e6 : 0xffcce0; // Two shades of light pink
        }
        
        const tileGeometry = new THREE.PlaneGeometry(cellSize, cellSize);
        const tileMaterial = new THREE.MeshBasicMaterial({ 
          color: color,
          side: THREE.DoubleSide 
        });
        const tile = new THREE.Mesh(tileGeometry, tileMaterial);
        tile.position.set(x * cellSize + cellSize/2, 0, z * cellSize + cellSize/2);
        tile.rotation.x = -Math.PI / 2; // Make it horizontal
        floorGroup.add(tile);
      }
    }
    
    // Main character (BD girl) - BOLD PINK BLOB
    const characterSize = 0.8;
    const characterGeometry = new THREE.CircleGeometry(characterSize, 32);
    const characterMaterial = new THREE.MeshBasicMaterial({ 
      color: 0xff1493, // BOLD PINK
      side: THREE.DoubleSide
    });
    const character = new THREE.Mesh(characterGeometry, characterMaterial);
    character.position.set(0, 0.1, 0); // Slightly above ground
    character.rotation.x = -Math.PI / 2; // Lay flat
    
    // Add eyes to make the blob more expressive
    const eyeGeometry = new THREE.CircleGeometry(0.15, 16);
    const eyeMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
    const leftEye = new THREE.Mesh(eyeGeometry, eyeMaterial);
    leftEye.position.set(-0.25, 0.02, -0.3);
    leftEye.rotation.x = -Math.PI / 2;
    character.add(leftEye);
    
    const rightEye = new THREE.Mesh(eyeGeometry, eyeMaterial);
    rightEye.position.set(0.25, 0.02, -0.3);
    rightEye.rotation.x = -Math.PI / 2;
    character.add(rightEye);
    
    // Add pupils
    const pupilGeometry = new THREE.CircleGeometry(0.07, 16);
    const pupilMaterial = new THREE.MeshBasicMaterial({ color: 0x000000 });
    const leftPupil = new THREE.Mesh(pupilGeometry, pupilMaterial);
    leftPupil.position.set(0, 0.01, 0);
    leftEye.add(leftPupil);
    
    const rightPupil = new THREE.Mesh(pupilGeometry, pupilMaterial);
    rightPupil.position.set(0, 0.01, 0);
    rightEye.add(rightPupil);
    
    scene.add(character);
    
    // Create conference buildings with more interesting designs
    const buildingData = [
      { x: -10, z: -10, width: 5, height: 4, color: 0x6666cc, name: "DeFi Summit" },
      { x: 10, z: -8, width: 6, height: 5, color: 0x66cc66, name: "NFT Gallery" },
      { x: -12, z: 8, width: 4, height: 4, color: 0xcc6666, name: "Web3 Conference" },
      { x: 8, z: 12, width: 5, height: 4, color: 0xcccc66, name: "Blockchain Expo" }
    ];
    
    // FontLoader not needed for now, we'll use simple geometry for signs
    
    buildingData.forEach(building => {
      // Create building
      const buildingGeometry = new THREE.BoxGeometry(building.width, 2, building.height);
      const buildingMaterial = new THREE.MeshBasicMaterial({ color: building.color });
      const buildingMesh = new THREE.Mesh(buildingGeometry, buildingMaterial);
      buildingMesh.position.set(building.x, 1, building.z);
      scene.add(buildingMesh);
      
      // Add roof
      const roofGeometry = new THREE.BoxGeometry(building.width + 0.5, 0.5, building.height + 0.5);
      const roofMaterial = new THREE.MeshBasicMaterial({ color: 0x444444 });
      const roof = new THREE.Mesh(roofGeometry, roofMaterial);
      roof.position.set(0, 1.25, 0);
      buildingMesh.add(roof);
      
      // Add door
      const doorGeometry = new THREE.PlaneGeometry(1.2, 1.5);
      const doorMaterial = new THREE.MeshBasicMaterial({ 
        color: 0x8b4513,
        side: THREE.DoubleSide 
      });
      const door = new THREE.Mesh(doorGeometry, doorMaterial);
      
      // Position door on front side of building
      if (building.z < 0) {
        door.position.set(0, -0.25, building.height/2 + 0.01);
      } else {
        door.position.set(0, -0.25, -building.height/2 - 0.01);
        door.rotation.y = Math.PI;
      }
      buildingMesh.add(door);
      
      // Add windows
      for (let i = -1; i <= 1; i += 2) {
        const windowGeometry = new THREE.PlaneGeometry(0.8, 0.8);
        const windowMaterial = new THREE.MeshBasicMaterial({ 
          color: 0x88ccff,
          side: THREE.DoubleSide 
        });
        
        // Front windows
        const frontWindow = new THREE.Mesh(windowGeometry, windowMaterial);
        frontWindow.position.set(i * 1.5, 0.3, building.height/2 + 0.01);
        buildingMesh.add(frontWindow);
        
        // Back windows
        const backWindow = new THREE.Mesh(windowGeometry, windowMaterial);
        backWindow.position.set(i * 1.5, 0.3, -building.height/2 - 0.01);
        backWindow.rotation.y = Math.PI;
        buildingMesh.add(backWindow);
        
        // Side windows
        const leftWindow = new THREE.Mesh(windowGeometry, windowMaterial);
        leftWindow.position.set(-building.width/2 - 0.01, 0.3, i * 1.5);
        leftWindow.rotation.y = -Math.PI / 2;
        buildingMesh.add(leftWindow);
        
        const rightWindow = new THREE.Mesh(windowGeometry, windowMaterial);
        rightWindow.position.set(building.width/2 + 0.01, 0.3, i * 1.5);
        rightWindow.rotation.y = Math.PI / 2;
        buildingMesh.add(rightWindow);
      }
      
      // Create sign for the building
      const signGeometry = new THREE.BoxGeometry(building.width - 1, 0.8, 0.2);
      const signMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
      const sign = new THREE.Mesh(signGeometry, signMaterial);
      
      // Position sign on front of building
      if (building.z < 0) {
        sign.position.set(0, 1, building.height/2 + 0.2);
      } else {
        sign.position.set(0, 1, -building.height/2 - 0.2);
      }
      buildingMesh.add(sign);
    });
    
    // Add NPCs (other conference attendees)
    const npcColors = [
      0x3366ff, // Blue
      0xff6633, // Orange
      0x33cc33, // Green
      0xcc33cc, // Purple
      0xffcc33  // Yellow
    ];
    
    const npcPositions = [
      { x: -5, z: -5 },
      { x: 5, z: -7 },
      { x: -7, z: 3 },
      { x: 4, z: 8 },
      { x: 0, z: -12 },
      { x: -9, z: -3 },
      { x: 7, z: 2 },
      { x: -3, z: 10 }
    ];
    
    npcPositions.forEach((pos, index) => {
      const npcSize = 0.7;
      const npcGeometry = new THREE.CircleGeometry(npcSize, 32);
      const npcMaterial = new THREE.MeshBasicMaterial({ 
        color: npcColors[index % npcColors.length],
        side: THREE.DoubleSide
      });
      const npc = new THREE.Mesh(npcGeometry, npcMaterial);
      npc.position.set(pos.x, 0.1, pos.z);
      npc.rotation.x = -Math.PI / 2;
      scene.add(npc);
      
      // Add simple face to NPCs
      const npcEyeGeometry = new THREE.CircleGeometry(0.12, 16);
      const npcEyeMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
      
      const npcLeftEye = new THREE.Mesh(npcEyeGeometry, npcEyeMaterial);
      npcLeftEye.position.set(-0.2, 0.02, -0.2);
      npcLeftEye.rotation.x = -Math.PI / 2;
      npc.add(npcLeftEye);
      
      const npcRightEye = new THREE.Mesh(npcEyeGeometry, npcEyeMaterial);
      npcRightEye.position.set(0.2, 0.02, -0.2);
      npcRightEye.rotation.x = -Math.PI / 2;
      npc.add(npcRightEye);
      
      const npcPupilGeometry = new THREE.CircleGeometry(0.05, 16);
      const npcPupilMaterial = new THREE.MeshBasicMaterial({ color: 0x000000 });
      
      const npcLeftPupil = new THREE.Mesh(npcPupilGeometry, npcPupilMaterial);
      npcLeftPupil.position.set(0, 0.01, 0);
      npcLeftEye.add(npcLeftPupil);
      
      const npcRightPupil = new THREE.Mesh(npcPupilGeometry, npcPupilMaterial);
      npcRightPupil.position.set(0, 0.01, 0);
      npcRightEye.add(npcRightPupil);
    });
    
    // Add some decorative elements
    
    // Create some crypto-themed props
    const createBitcoinLogo = (x, z) => {
      const group = new THREE.Group();
      
      const coinGeometry = new THREE.CylinderGeometry(0.5, 0.5, 0.1, 32);
      const coinMaterial = new THREE.MeshBasicMaterial({ color: 0xf7931a });
      const coin = new THREE.Mesh(coinGeometry, coinMaterial);
      coin.rotation.x = Math.PI / 2;
      group.add(coin);
      
      // Add "B" symbol
      const bGeometry = new THREE.BoxGeometry(0.3, 0.7, 0.05);
      const bMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
      const bSymbol = new THREE.Mesh(bGeometry, bMaterial);
      bSymbol.position.set(0, 0, 0.08);
      group.add(bSymbol);
      
      group.position.set(x, 0.2, z);
      return group;
    };
    
    // Add some bitcoin logos around the map
    const bitcoinPositions = [
      { x: -7, z: -3 },
      { x: 7, z: 9 },
      { x: 3, z: -10 },
      { x: -9, z: 5 }
    ];
    
    bitcoinPositions.forEach(pos => {
      const bitcoin = createBitcoinLogo(pos.x, pos.z);
      scene.add(bitcoin);
    });
    
    // Create some plants/trees
    const createPlant = (x, z) => {
      const group = new THREE.Group();
      
      // Pot
      const potGeometry = new THREE.CylinderGeometry(0.3, 0.4, 0.5, 16);
      const potMaterial = new THREE.MeshBasicMaterial({ color: 0xcc9966 });
      const pot = new THREE.Mesh(potGeometry, potMaterial);
      group.add(pot);
      
      // Plant
      const plantGeometry = new THREE.ConeGeometry(0.5, 1, 16);
      const plantMaterial = new THREE.MeshBasicMaterial({ color: 0x44aa44 });
      const plant = new THREE.Mesh(plantGeometry, plantMaterial);
      plant.position.set(0, 0.7, 0);
      group.add(plant);
      
      group.position.set(x, 0.25, z);
      return group;
    };
    
    // Add plants around the map
    const plantPositions = [
      { x: -12, z: -12 },
      { x: 12, z: -12 },
      { x: -12, z: 12 },
      { x: 12, z: 12 },
      { x: 0, z: -15 },
      { x: 0, z: 15 },
      { x: -15, z: 0 },
      { x: 15, z: 0 }
    ];
    
    plantPositions.forEach(pos => {
      const plant = createPlant(pos.x, pos.z);
      scene.add(plant);
    });
    
    // Add lights
    const ambientLight = new THREE.AmbientLight(0xffffff, 1);
    scene.add(ambientLight);
    
    // Animation loop
    const animationId = requestAnimationFrame(function animate() {
      renderer.render(scene, camera);
      requestAnimationFrame(animate);
    });

    // Handle window resize
    const handleResize = () => {
      renderer.setSize(800, 600);
    };
    window.addEventListener('resize', handleResize);

    // Add keyboard controls
    const moveSpeed = 0.15; // Slightly faster movement
    const keyState = {
      ArrowUp: false,
      ArrowDown: false,
      ArrowLeft: false,
      ArrowRight: false,
      w: false,
      a: false,
      s: false,
      d: false
    };

    const handleKeyDown = (e) => {
      const key = e.key.toLowerCase();
      if (keyState.hasOwnProperty(key)) {
        keyState[key] = true;
      }
      if (keyState.hasOwnProperty(e.key)) {
        keyState[e.key] = true;
      }
    };

    const handleKeyUp = (e) => {
      const key = e.key.toLowerCase();
      if (keyState.hasOwnProperty(key)) {
        keyState[key] = false;
      }
      if (keyState.hasOwnProperty(e.key)) {
        keyState[e.key] = false;
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    window.addEventListener('keyup', handleKeyUp);

    // Character collision detection
    const isColliding = (x, z) => {
      // Check building collisions
      for (const building of buildingData) {
        if (
          x > building.x - building.width/2 - 0.5 &&
          x < building.x + building.width/2 + 0.5 &&
          z > building.z - building.height/2 - 0.5 &&
          z < building.z + building.height/2 + 0.5
        ) {
          return true;
        }
      }
      
      // World boundaries
      if (
        x < -gridSize/2 + 1 ||
        x > gridSize/2 - 1 ||
        z < -gridSize/2 + 1 ||
        z > gridSize/2 - 1
      ) {
        return true;
      }
      
      return false;
    };

    // Update character position based on key presses
    let lastDirection = { x: 0, z: -1 }; // Initially facing up
    
    let movementId;
    const updateCharacterPosition = () => {
      let newX = character.position.x;
      let newZ = character.position.z;
      let moved = false;
      
      // Support both WASD and arrow keys
      if (keyState.ArrowUp || keyState.w) {
        newZ -= moveSpeed;
        lastDirection = { x: 0, z: -1 };
        moved = true;
      }
      if (keyState.ArrowDown || keyState.s) {
        newZ += moveSpeed;
        lastDirection = { x: 0, z: 1 };
        moved = true;
      }
      if (keyState.ArrowLeft || keyState.a) {
        newX -= moveSpeed;
        lastDirection = { x: -1, z: 0 };
        moved = true;
      }
      if (keyState.ArrowRight || keyState.d) {
        newX += moveSpeed;
        lastDirection = { x: 1, z: 0 };
        moved = true;
      }
      
      // Only update if not colliding
      if (!isColliding(newX, newZ)) {
        character.position.x = newX;
        character.position.z = newZ;
      }
      
      // Adjust eyes to look in the direction of movement
      if (moved) {
        leftEye.position.set(-0.25, 0.02, -0.3 * lastDirection.z - 0.1 * lastDirection.x);
        rightEye.position.set(0.25, 0.02, -0.3 * lastDirection.z - 0.1 * lastDirection.x);
      }
      
      // Update camera to follow character
      camera.position.x = character.position.x;
      camera.position.z = character.position.z;
      
      // Check for interactions with buildings
      for (const building of buildingData) {
        const dx = Math.abs(character.position.x - building.x);
        const dz = Math.abs(character.position.z - building.z);
        const distance = Math.sqrt(dx * dx + dz * dz);
        
        if (distance < building.width/2 + building.height/2 + 2) {
          setGameStatus(`Near ${building.name}! Press E to enter`);
          break;
        } else {
          setGameStatus('Use arrow keys or WASD to move');
        }
      }
      
      movementId = requestAnimationFrame(updateCharacterPosition);
    };
    movementId = requestAnimationFrame(updateCharacterPosition);

    // Cleanup function
    return () => {
      cancelAnimationFrame(animationId);
      cancelAnimationFrame(movementId);
      window.removeEventListener('resize', handleResize);
      window.removeEventListener('keydown', handleKeyDown);
      window.removeEventListener('keyup', handleKeyUp);
      
      if (mountRef.current && renderer.domElement && renderer.domElement.parentNode === mountRef.current) {
        mountRef.current.removeChild(renderer.domElement);
      }
    };
  }, []);

  return (
    <div className="w-full h-screen flex flex-col items-center">
      <div className="mb-4 mt-4 text-2xl font-bold text-pink-600">Lonely BD Girl at Crypto Conference</div>
      <div ref={mountRef} className="border-4 border-pink-500 rounded shadow-lg" />
      <div className="mt-4 p-2 bg-pink-100 rounded border border-pink-300">
        <p className="text-sm text-pink-800">{gameStatus}</p>
      </div>
    </div>
  );
};

export default LonelyBDGirlGame;