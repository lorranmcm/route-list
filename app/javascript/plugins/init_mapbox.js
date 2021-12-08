import 'mapbox-gl/dist/mapbox-gl.css';
import mapboxgl from 'mapbox-gl';

const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10'
  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    if (marker.project_id == marker.task_project_id) {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);

      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    };
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach((marker) => {
    if (marker.project_id == marker.task_project_id) {
      bounds.extend([marker.lng, marker.lat])
    }
  });

  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  mapElement.style.borderRadius = "10px";
  mapElement.style.boxShadow = "2px 2px 2px 1px rgba(0, 0.2, 0.2, 0.2)";
  if (mapElement) {
    const map = buildMap(mapElement);
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  }
};

export { initMapbox };
