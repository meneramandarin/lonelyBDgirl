import React, { useEffect, useRef } from 'react';
import * as THREE from 'three';

const LonelyBDGirlGame = () => {
  const mountRef = useRef(null);

  useEffect(() => {
    // Scene setup
    const scene = new THREE.Scene();
    scene.background = new THREE.Color(0x7acba5); // Light green background like old Pokemon games

    // Camera setup (orthographic for top-down 2D style)
    const camera = new THREE.OrthographicCamera(
      -10, 10, 7.5, -7.5, 0.1, 1000
    );
    camera.position.set(0, 10, 0);
    camera.lookAt(0, 0, 0);
    camera.rotation.z = Math.PI; // Adjust camera rotation

    // Renderer setup
    const renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setSize(800, 600);
    mountRef.current?.appendChild(renderer.domElement);
    
    // Exit early if we can't mount the renderer
    if (!mountRef.current) {
      return () => {};
    }

    // Main character (BD girl)
    const characterGeometry = new THREE.PlaneGeometry(1, 1);
    const characterTexture = new THREE.TextureLoader().load('/api/placeholder/32/32');
    const characterMaterial = new THREE.MeshBasicMaterial({ 
      map: characterTexture,
      transparent: true,
      side: THREE.DoubleSide
    });
    const character = new THREE.Mesh(characterGeometry, characterMaterial);
    character.position.set(0, 0.1, 0); // Slightly above ground
    character.rotation.x = -Math.PI / 2; // Lay flat
    scene.add(character);

    // Create grid-based floor (like Pokemon's grid movement system)
    const gridSize = 20;
    const cellSize = 1;
    
    // Create floor tiles
    for (let x = -gridSize/2; x < gridSize/2; x++) {
      for (let z = -gridSize/2; z < gridSize/2; z++) {
        // Alternate colors for checkerboard pattern
        const isEven = (x + z) % 2 === 0;
        const color = isEven ? 0x9bdb9b : 0x88c088; // Two shades of green
        
        const tileGeometry = new THREE.PlaneGeometry(cellSize, cellSize);
        const tileMaterial = new THREE.MeshBasicMaterial({ 
          color: color,
          side: THREE.DoubleSide 
        });
        const tile = new THREE.Mesh(tileGeometry, tileMaterial);
        tile.position.set(x * cellSize + cellSize/2, 0, z * cellSize + cellSize/2);
        tile.rotation.x = -Math.PI / 2; // Make it horizontal
        scene.add(tile);
      }
    }
    
    // Add some conference building facades
    const buildingPositions = [
      { x: -5, z: -5, width: 3, height: 2 },
      { x: 5, z: -6, width: 4, height: 3 },
      { x: -7, z: 4, width: 2, height: 2 },
      { x: 4, z: 6, width: 3, height: 2 }
    ];
    
    buildingPositions.forEach(building => {
      const buildingGeometry = new THREE.BoxGeometry(building.width, 1.5, building.height);
      const buildingMaterial = new THREE.MeshBasicMaterial({ color: 0x5d5d5d });
      const buildingMesh = new THREE.Mesh(buildingGeometry, buildingMaterial);
      buildingMesh.position.set(building.x, 0.75, building.z);
      scene.add(buildingMesh);
      
      // Add door
      const doorGeometry = new THREE.PlaneGeometry(0.7, 1);
      const doorMaterial = new THREE.MeshBasicMaterial({ 
        color: 0x8b4513,
        side: THREE.DoubleSide 
      });
      const door = new THREE.Mesh(doorGeometry, doorMaterial);
      
      // Position door on front side of building
      if (building.z < 0) {
        door.position.set(building.x, 0.5, building.z + building.height/2 + 0.01);
      } else {
        door.position.set(building.x, 0.5, building.z - building.height/2 - 0.01);
        door.rotation.y = Math.PI;
      }
      scene.add(door);
    });

    // Add simple NPCs (other conference attendees)
    const npcPositions = [
      { x: -3, z: -3 },
      { x: 2, z: 4 },
      { x: -4, z: 1 },
      { x: 6, z: -2 }
    ];
    
    npcPositions.forEach(pos => {
      const npcGeometry = new THREE.PlaneGeometry(0.8, 0.8);
      const npcMaterial = new THREE.MeshBasicMaterial({ 
        color: Math.random() * 0xffffff,
        transparent: true,
        side: THREE.DoubleSide
      });
      const npc = new THREE.Mesh(npcGeometry, npcMaterial);
      npc.position.set(pos.x, 0.1, pos.z);
      npc.rotation.x = -Math.PI / 2;
      scene.add(npc);
    });

    // Add directional light
    const light = new THREE.DirectionalLight(0xffffff, 1);
    light.position.set(0, 10, 0);
    scene.add(light);
    
    // Add ambient light
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
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
    const moveSpeed = 0.1;
    const keyState = {
      ArrowUp: false,
      ArrowDown: false,
      ArrowLeft: false,
      ArrowRight: false
    };

    const handleKeyDown = (e) => {
      if (keyState.hasOwnProperty(e.key)) {
        keyState[e.key] = true;
      }
    };

    const handleKeyUp = (e) => {
      if (keyState.hasOwnProperty(e.key)) {
        keyState[e.key] = false;
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    window.addEventListener('keyup', handleKeyUp);

    // Update character position based on key presses
    let movementId;
    const updateCharacterPosition = () => {
      if (keyState.ArrowUp) character.position.z -= moveSpeed;
      if (keyState.ArrowDown) character.position.z += moveSpeed;
      if (keyState.ArrowLeft) character.position.x -= moveSpeed;
      if (keyState.ArrowRight) character.position.x += moveSpeed;
      
      // Update camera to follow character
      camera.position.x = character.position.x;
      camera.position.z = character.position.z;
      
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
      
      // Check if mountRef is still valid before trying to remove the renderer
      if (mountRef.current && renderer.domElement && renderer.domElement.parentNode === mountRef.current) {
        mountRef.current.removeChild(renderer.domElement);
      }
    };
  }, []);

  return (
    <div className="w-full h-screen flex flex-col items-center">
      <div className="mb-4 mt-4 text-xl font-bold">Lonely BD Girl at Crypto Conference</div>
      <div ref={mountRef} className="border-4 border-gray-800 rounded" />
      <div className="mt-4 p-2 bg-gray-100 rounded">
        <p className="text-sm">Use arrow keys to move the character</p>
      </div>
    </div>
  );
};

export default LonelyBDGirlGame;