$(function() {
  new ClipboardJS('.sourceCode', {
    target: function(trigger) {
      return trigger.parentElement;
    }
  });
})
