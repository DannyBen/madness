$(function() {
  $('.autocomplete').autocomplete({
    serviceUrl: '/_search/autocomplete',
    minChars: 2,
    triggerSelectOnValidInput: false,
    autoSelectFirst: true,
  });
})
