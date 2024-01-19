// ==UserScript==
// @name         ChatGPT Content Width Adjuster (CWA)
// @namespace    http://tampermonkey.net/
// @version      1.2
// @description  Adjust the width of the content area in ChatGPT dialog interactively with buttons
// @author       driversti
// @match        https://chat.openai.com/*
// @grant        GM_addStyle
// @grant        GM_registerMenuCommand
// ==/UserScript==

(function() {
    'use strict';

    let currentWidth;
    const windowWidth = window.innerWidth;

    if (windowWidth >= 1280) {
        currentWidth = 48;
    } else if (windowWidth >= 1024) {
        currentWidth = 48;
    } else if (windowWidth >= 768) {
        currentWidth = 40;
    } else {
        currentWidth = 40;
    }

    // Function to update the width
    function updateWidth(newWidth) {
        currentWidth = newWidth;
        GM_addStyle(`
            @media (min-width: 1280px) {
                .xl\\:max-w-\\[48rem\\] {
                    max-width: ${currentWidth}rem !important;
                }
            }
            
            @media (min-width: 1024px) {
                .lg\\:max-w-\\[48rem\\], .lg\\:max-w-\\[40rem\\] {
                    max-width: ${currentWidth}rem !important;
                }
            }
            @media (min-width: 768px) {
                .md\\:max-w-3xl {
                    max-width: ${currentWidth}rem !important;
                }
            }
        `);
    }

    // Add buttons to the page
    function addButton(id, text, onClick) {
        const button = document.createElement('button');
        button.innerText = text;
        button.id = id;
        button.style.position = 'fixed';
        button.style.right = '20px';
        button.style.zIndex = '10000';
        button.style.width = '30px';
        button.style.height = '30px';
        button.style.border = 'none';
        button.style.background = 'grey';
        button.style.color = 'white';
        button.style.borderRadius = '15px';
        button.style.textAlign = 'center';
        button.style.cursor = 'pointer';
        button.style.boxShadow = '0px 0px 10px rgba(0,0,0,0.5)';
        button.style.outline = 'none';
        button.addEventListener('click', onClick);
        document.body.appendChild(button);
    }

    // Position buttons in the middle of the screen
    function positionButtons() {
        const increaseButton = document.getElementById('increaseWidthButton');
        const decreaseButton = document.getElementById('decreaseWidthButton');
        const yOffset = window.innerHeight / 2;
        increaseButton.style.top = `${yOffset - 45}px`; // Position the 'increase' button slightly above the middle
        decreaseButton.style.top = `${yOffset}px`; // Position the 'decrease' button at the middle
    }

    // Button actions
    function increaseWidth() {
        updateWidth(currentWidth + 1);
    }

    function decreaseWidth() {
        updateWidth(currentWidth - 1);
    }

    // Create and position the buttons after the window loads
    window.addEventListener('load', function() {
        addButton('increaseWidthButton', '+', increaseWidth);
        addButton('decreaseWidthButton', '-', decreaseWidth);
        positionButtons(); // Position buttons after they are added
    });

    // Update button positions on window resize
    window.addEventListener('resize', positionButtons);
})();
