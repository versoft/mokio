showCallback = (geocodeResult, parsedGeocodeResult) ->
  $("#callback_result").text JSON.stringify(parsedGeocodeResult, null, 4)
  return
addresspickerMap = $(".gmap_full_address").addresspicker(
  regionBias: "pl"
  updateCallback: showCallback
  mapOptions:
    center: new google.maps.LatLng(53.76512409999999, 20.523828900000012)
    scrollwheel: false
    mapTypeId: google.maps.MapTypeId.ROADMAP


  elements:
    map: "#map"
    lat: ".gmap_lat"
    lng: ".gmap_lng"
    street_number: ".gmap_street_number"
    route: ".gmap_route"
    locality: ".gmap_locality"
    administrative_area_level_2: ".gmap_administrative_area_level_2"
    administrative_area_level_1: ".gmap_administrative_area_level_1"
    country: ".gmap_country"
    postal_code: ".gmap_postal_code"
    type: ".gmap_type"
    zoom: ".gmap_zoom"
)
gmarker = addresspickerMap.addresspicker("marker")
gmarker.setVisible true
addresspickerMap.addresspicker "updatePosition"
$("#reverseGeocode").change ->
  $(".gmap_full_address").addresspicker "option", "reverseGeocode", ($(this).val() is "true")
  return


# Update zoom field
map = $(".gmap_full_address").addresspicker("map")

default_zoom = $(".gmap_zoom").val()
map.setZoom(parseInt(default_zoom))

google.maps.event.addListener map, "idle", ->
  $(".gmap_zoom").val map.getZoom()
  return

# Resize map to show on a Bootstrap's modal
$("#gmap_modal").on "shown", ->
  currentCenter = map.getCenter() # Get current center before resizing
  google.maps.event.trigger map, "resize"
  map.setCenter currentCenter # Re-set previous center
  return
