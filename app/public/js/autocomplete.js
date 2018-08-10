$(function() {
  $('.autocomplete').autocomplete({
    serviceUrl: '/_search/autocomplete',
    minChars: 2,
    noCache: false,
    preventBadQueries: false,
    triggerSelectOnValidInput: false,
    autoSelectFirst: false,
    preserveInput: false,
    showNoSuggestionNotice: true,
    onSelect: function(suggestion) {
      window.location = "/" + suggestion.data;
    }
  });
})
