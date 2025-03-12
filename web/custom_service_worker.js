const CACHE_NAME = 'flutter-app-cache-v2'; // Updated version to force refresh if changed
const RESOURCES = {
  "index.html": "HASH",
  "main.dart.js": "HASH",
  "flutter_bootstrap.js": "HASH",
  "manifest.json": "HASH",
  "assets/AssetManifest.json": "HASH",
  "assets/FontManifest.json": "HASH",
  "assets/fonts/": "HASH",
  "assets/images/": "HASH",
  "assets/": "HASH"
};

// Install Service Worker and Pre-Cache Resources
self.addEventListener("install", (event) => {
  self.skipWaiting(); // Activate new service worker immediately
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('[Service Worker] Pre-caching all resources...');
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

// Activate Event - Clean Old Caches and Take Control
self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((keyList) => {
      return Promise.all(
        keyList.map((key) => {
          if (key !== CACHE_NAME) {
            console.log('[Service Worker] Deleting old cache:', key);
            return caches.delete(key);
          }
        })
      );
    })
  );
  return self.clients.claim(); // Force pages to use the new service worker immediately
});

// Fetch Event - Serve From Cache First, Then Network
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') return; // Ignore non-GET requests (e.g., POST)
  
  event.respondWith(
    caches.match(event.request).then((cachedResponse) => {
      if (cachedResponse) {
        console.log('[Service Worker] Serving from cache:', event.request.url);
        return cachedResponse;
      }
      console.log('[Service Worker] Fetching from network:', event.request.url);
      return fetch(event.request).then((networkResponse) => {
        return caches.open(CACHE_NAME).then((cache) => {
          cache.put(event.request, networkResponse.clone()); // Cache the new response
          return networkResponse;
        });
      }).catch(() => {
        console.warn('[Service Worker] Network request failed, serving fallback:', event.request.url);
        return caches.match("index.html"); // Serve homepage if network fails
      });
    })
  );
});

// Listen for Messages from Client (Optional - For Future Enhancements)
self.addEventListener("message", (event) => {
  if (event.data === "skipWaiting") {
    self.skipWaiting();
  }
});
