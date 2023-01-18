$(function() {
  new ClipboardJS('.clipboard-button', {
    target: function(trigger) {
      return trigger.parentElement;
    }
  });

  html = '<a href="#" onclick="return false" class="icon clipboard-button" data-clipboard-target="code"><i class="icon-copy"></i></a>';

  $('pre code').prepend(html);
})
