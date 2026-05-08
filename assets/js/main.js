window.addEventListener('load', () => {
  const mobileMenuButton = document.querySelector('.mobile-menu-button')
  mobileMenuButton.addEventListener('click', (event) => {
    console.log('clock,ed')
    const mobileHeaderMenu = document.querySelector('.header-nav')
    event.preventDefault()
    if (mobileHeaderMenu.classList.contains('show')) {
      mobileHeaderMenu.classList.remove('show')
    } else {
      mobileHeaderMenu.classList.add('show')
    }
  })
})