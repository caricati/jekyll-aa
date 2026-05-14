(function () {
  const DEFAULT_LANGUAGE = "pt";
  const SUPPORTED_LANGUAGES = ["pt", "en"];

  const LANGUAGE_ROUTES = {
    pt: "/",
    en: "/en/",
  };

  const STORAGE_KEY = "auto-adrenalina-language";

  function isBot() {
    return /bot|googlebot|crawler|spider|crawling/i.test(navigator.userAgent);
  }

  function normalizeLanguage(lang) {
    if (!lang) {
      return DEFAULT_LANGUAGE;
    }

    return lang.toLowerCase().split("-")[0];
  }

  function getBrowserLanguage() {
    const browserLang =
      navigator.language || navigator.userLanguage || DEFAULT_LANGUAGE;

    const normalized = normalizeLanguage(browserLang);

    if (SUPPORTED_LANGUAGES.includes(normalized)) {
      return normalized;
    }

    return DEFAULT_LANGUAGE;
  }

  function getCurrentPath() {
    return window.location.pathname;
  }

  function isHomePage() {
    const path = getCurrentPath();

    return path === "/" || path === "/index.html";
  }

  function alreadyRedirected() {
    return sessionStorage.getItem(STORAGE_KEY);
  }

  function markRedirect(language) {
    sessionStorage.setItem(STORAGE_KEY, language);
  }

  function redirectTo(language) {
    const target =
      LANGUAGE_ROUTES[language] || LANGUAGE_ROUTES[DEFAULT_LANGUAGE];

    window.location.replace(target);
  }

  /*
   |--------------------------------------------------------------------------
   | MAIN
   |--------------------------------------------------------------------------
   */

  if (isBot()) {
    return;
  }

  if (!isHomePage()) {
    return;
  }

  if (alreadyRedirected()) {
    return;
  }

  const preferredLanguage = getBrowserLanguage();

  markRedirect(preferredLanguage);

  if (preferredLanguage !== DEFAULT_LANGUAGE) {
    redirectTo(preferredLanguage);
  }
})();
