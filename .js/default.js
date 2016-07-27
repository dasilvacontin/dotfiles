/* globals $ */
window.nodeIsNotInFooter = (node) => {
  while (node.parentElement) {
    node = node.parentElement
    if (node.className.toLowerCase().indexOf('footer') > -1) return false
    if (node.id.toLowerCase().indexOf('footer') > -1) return false
    if (node.tagName.toLowerCase().indexOf('footer') > -1) return false
  }
  return true
}

let closeButtonSelector = ''
const keywords = ['close', 'cerrar', 'agree', 'cookie']
const tagNames = ['a', 'button', 'i']
tagNames.forEach((tagName, i) => {
  keywords.forEach((keyword, j) => {
    if (i !== 0 || j !== 0) closeButtonSelector += ', '
    closeButtonSelector += `${tagName}[class*=${keyword} i], `
    closeButtonSelector += `${tagName}[title*=${keyword} i]`
  })
})
closeButtonSelector += ', a[href^=javascript]'

window.closeCookiesWarning = () => {
  let cookieInfoLinks = Array.from(document.querySelectorAll('a[href*=cookie i], a[href*=aviso i]'))
  .filter(window.nodeIsNotInFooter)
  .filter((node) => node.href.indexOf('javascript') !== 0)

  if (cookieInfoLinks.length === 0) return
  console.log('cookieInfoLinks', cookieInfoLinks)

  cookieInfoLinks.forEach((cookieInfoLink) => {
    // go up til close buttons are found
    let container = cookieInfoLink
    let closeButtons = []
    while (closeButtons.length === 0) {
      container = container.parentElement
      if (container.tagName === 'BODY') break
      closeButtons = Array.from(container.querySelectorAll(closeButtonSelector))
      closeButtons = closeButtons.filter((btn) => btn !== cookieInfoLink)
    }

    console.log('closeButtons', closeButtons)
    for (var i = 0; i < closeButtons.length; ++i) closeButtons[i].click()

    if (closeButtons.length === 0) {
      console.log('couldnt find close button for cookie notice :/')
      console.log({ cookieInfoLink, container, closeButtons })
    } else {
      console.log('closed pointless cookie notice! <3')
    }
  })
}

function main () {
  // don't execute on embeded pages, probably unwanted and reduces noise
  if (window.top !== window.self) return

  // don't execute on google.com because oh shit waddup
  if (location.origin.indexOf('google.com') > -1) return

  $(window).load(() => {
    setTimeout(() => {
      console.log('hello world! ✨')
      window.closeCookiesWarning()
    }, 1000)
  })
}
main()
