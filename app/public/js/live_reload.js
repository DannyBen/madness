var baseUri = document.body.dataset.baseUri || "";
var wsProtocol = location.protocol === "https:" ? "wss:" : "ws:";
var wsUrl = wsProtocol + "//" + location.host + baseUri + "/_live_reload";
var socket;

function connect() {
  socket = new WebSocket(wsUrl);

  socket.onopen = function() {
    console.log("[LiveReload] connected");
  };

  socket.onmessage = function(event) {
    console.log("[LiveReload] changed:", event.data);
    reloadContent();
  };

  socket.onclose = function() {
    console.log("[LiveReload] disconnected, reconnecting...");
    setTimeout(connect, 1000);
  };
}

function reloadContent() {
  fetch(location.href, { cache: "no-store" })
    .then(function(response) { return response.text(); })
    .then(function(html) {
      var parsed = new DOMParser().parseFromString(html, "text/html");
      swapElement(parsed, ".main");
      swapElement(parsed, "nav");
      updateTitle(parsed);
      reinitMermaid();
      console.log("[LiveReload] content swapped");
    })
    .catch(function(error) {
      console.error("[LiveReload] fetch failed:", error);
    });
}

function updateTitle(parsed) {
  var newTitle = parsed.querySelector("title");
  if (newTitle) document.title = newTitle.textContent;
}

function reinitMermaid() {
  if (typeof mermaid !== "undefined") mermaid.init();
}

function swapElement(parsed, selector) {
  var current = document.querySelector(selector);
  var updated = parsed.querySelector(selector);
  if (current && updated) {
    current.innerHTML = updated.innerHTML;
  }
}

window.addEventListener("beforeunload", function() {
  socket.close();
});

connect();
