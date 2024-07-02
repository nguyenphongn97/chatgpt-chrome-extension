function toggleDarkMode() {
    chrome.tabs.query({ active: true, currentWindow: true }, function (tabs) {
      chrome.scripting.executeScript({
        target: { tabId: tabs[0].id },
        function: toggleDarkModeOnPage
      });
    });
  }
  
  function toggleDarkModeOnPage() {
    if (document.documentElement.hasAttribute('data-dark-mode')) {
      document.documentElement.removeAttribute('data-dark-mode');
    } else {
      document.documentElement.setAttribute('data-dark-mode', 'true');
    }
  }
  
  chrome.action.onClicked.addListener(toggleDarkMode);
  