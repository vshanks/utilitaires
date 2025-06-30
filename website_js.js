// Function that makes the background header of inferencepm.ai website a block colour upon scroll. 
// Controlled entirely by appending or removing classes to make this affect happen

document.addEventListener('DOMContentLoaded', function() {
    // Wait for DOM to be fully loaded

    // Grab header elements - container, logo, hamburger menu horizontal bars
    const targetElement = document.querySelector('#top-header-element');
    const targetLogoDiv = document.querySelector('#header-logo-div');
    const targetBurgerMenuTop = document.querySelector('.hamburger-menu-bar.top');
    const targetBurgerMenuBottom = document.querySelector('.hamburger-menu-bar.bottom');
    
    // Scroll event listener
    window.addEventListener('scroll', function() {
        // Get current scroll position
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        // Trigger at specific scroll points
        if (scrollTop > 20) {
        		// enable the look when the user is scrolling 
            targetElement.classList.add('header-scrolled');
            targetLogoDiv.classList.add('logo-scrolled-inverted-light');
            targetBurgerMenuTop.classList.add('burger-scrolled');
            targetBurgerMenuBottom.classList.add('burger-scrolled');
						
        } else {
        		// default resting look - likely transparent background resting face
            targetElement.classList.remove('header-scrolled');
            targetLogoDiv.classList.remove('logo-scrolled-inverted-light');
            targetBurgerMenuTop.classList.remove('burger-scrolled');
            targetBurgerMenuBottom.classList.remove('burger-scrolled');
        }
    });
});
