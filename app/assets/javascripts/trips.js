var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var geocoder=new google.maps.Geocoder;
var map;
var start;

function initialize() {
  directionsDisplay = new google.maps.DirectionsRenderer();
  var mapOptions = {
    zoom: 7,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    center: new google.maps.LatLng(41.850033, -87.6500523)
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
  directionsDisplay.setMap(map);
  directionsDisplay.setPanel(document.getElementById('directions-panel'));
}

function calcRoute() {
  var start=document.getElementById('trip_source').value;
  geocoder.geocode( { 'address': start}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
      		var start_lat=results[0].geometry.location.lat();
      		document.getElementById('trip_lat_src').value=start_lat 
      		var start_lng=results[0].geometry.location.lng(); 
      		document.getElementById('trip_long_src').value=start_lng
      		start=new google.maps.LatLng(start_lat,start_lng); 
      }
  });
  var end=document.getElementById('trip_destination').value;
  geocoder.geocode( { 'address': end}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
      		var end_lat=results[0].geometry.location.lat();
      		document.getElementById('trip_lat_dest').value=end_lat
      		var end_lng=results[0].geometry.location.lng();
      		document.getElementById('trip_long_dest').value=end_lng
      		 end=new google.maps.LatLng(end_lat,end_lng);  
      }
  });
  var request = {
    origin: start,
    destination: end,
    travelMode: google.maps.TravelMode.DRIVING
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
  
}
google.maps.event.addDomListener(window, 'load', initialize);