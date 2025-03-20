import React, { useRef, useEffect } from 'react';
import * as THREE from 'three';

const LonelyBDGirlGame = () => {
  const mountRef = useRef(null);
  
  useEffect(() => {
    // --- Basic Three.js Setup ---
    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    const renderer = new THREE.WebGLRenderer({ antialias: true });
    
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setClearColor(0x87CEEB); // Sky blue background
    mountRef.current.appendChild(renderer.domElement);
    
    // --- Create Grass Field ---
    const grassGeometry = new THREE.PlaneGeometry(100, 100);
    const grassMaterial = new THREE.MeshBasicMaterial({ color: 0x3CB371, side: THREE.DoubleSide });
    const grassField = new THREE.Mesh(grassGeometry, grassMaterial);
    grassField.rotation.x = Math.PI / 2;
    scene.add(grassField);
    
    // --- Create Clouds ---
    const clouds = [];
    const createCloud = (x, y, z) => {
      const cloudGroup = new THREE.Group();
      
      // Create a few spheres for each cloud
      for (let i = 0; i < 5; i++) {
        const cloudPiece = new THREE.Mesh(
          new THREE.SphereGeometry(1, 16, 16),
          new THREE.MeshBasicMaterial({ color: 0xFFFFFF })
        );
        
        // Position cloud pieces relative to each other
        cloudPiece.position.set(
          Math.random() * 2 - 1,
          Math.random() * 0.5,
          Math.random() * 2 - 1
        );
        
        cloudGroup.add(cloudPiece);
      }
      
      cloudGroup.position.set(x, y, z);
      scene.add(cloudGroup);
      return cloudGroup;
    };
    
    // Create a few clouds at different positions
    clouds.push(createCloud(-10, 10, -10));
    clouds.push(createCloud(0, 15, -15));
    clouds.push(createCloud(10, 12, -5));
    
    // --- Camera Position ---
    camera.position.set(0, 5, 15);
    camera.lookAt(0, 0, 0);
    
    // --- Animation Loop ---
    const animate = () => {
      requestAnimationFrame(animate);
      
      // Bounce the clouds up and down
      clouds.forEach((cloud, index) => {
        cloud.position.y += Math.sin(Date.now() * 0.001 + index) * 0.01;
      });
      
      renderer.render(scene, camera);
    };
    
    animate();
    
    // --- Handle Window Resize ---
    const handleResize = () => {
      camera.aspect = window.innerWidth / window.innerHeight;
      camera.updateProjectionMatrix();
      renderer.setSize(window.innerWidth, window.innerHeight);
    };
    
    window.addEventListener('resize', handleResize);
    
    // Cleanup function
    return () => {
      window.removeEventListener('resize', handleResize);
      // Check if mountRef.current exists and contains the renderer's DOM element
      if (mountRef.current && renderer.domElement.parentNode === mountRef.current) {
        mountRef.current.removeChild(renderer.domElement);
      }
    };
  }, []);
  
  return <div ref={mountRef} style={{ width: '100%', height: '100vh' }} />;
};

export default LonelyBDGirlGame;