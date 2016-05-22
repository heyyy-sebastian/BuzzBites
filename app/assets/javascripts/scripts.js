"use strict";

$(document).ready(function() {
  // Form variables
  var displayData = $("ul#displayData");
  var buttonZS = $("button#zip-search");
  var formZipCode = $('input#zip-search');
  // Foursquare credentials and other queries, submitted with each API request
  var client_id = "DL1EJBH4FLH1TMS1CVCW2YIYNYQZLZFSNRFYGHAOUG01GMVM";
  var client_secret = "IWDFK4DSEJSL1UVNEJEHYEQL12VQUFAYIAQYT51T13EET0ZD";
  var section = "section=trending";
  var opennow = "openNow=1";
  //var datatype = "&m=foursquare";
  //var limit = "limit=30";
  var query = "query=restaurants";
  var version = "v=20160821";
  // Variables where the data will be stored/handled
  var foursquare_data_venueName = "", foursquare_data_venueType = "", foursquare_data_venueCheckins = 0;
  var restaurantsSorted = [];
  var zipCode = "";
  var restSearch = /Restaurant/; // RegEx pattern
  var myLatitude = "", myLongitude = "", lat_lot = "";
  var mapsApi = "AIzaSyDPMSlU4RW9QMz8ceTsBbBevwtLJvOLDAQ";

  // This function finds the current location loaded from browser data
  var getLocation = function() {
      if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(showPosition);
      } else { console.log('Geolocation is not supported or allowed for this Browser'); }
  }();

  // Default list of local trending restaurants
  function showPosition(position) {
    displayData.empty();
    myLatitude = position.coords.latitude;
    myLongitude = position.coords.longitude;

    lat_lot = "ll="+myLatitude+","+myLongitude;

    $.ajax({
      method: "GET",
      url: "https://api.foursquare.com/v2/venues/explore?client_id="+client_id+"&client_secret="+client_secret+"&"+version+"&"+section+"&"+opennow+"&"+query+"&"+lat_lot,
      success: function(data){
        var results = data["response"]["groups"][0]["items"];
        var x = 0, y = results.length - 1;
        for (x; x < y; x++) {
          foursquare_data_venueName = results[x]["venue"]["name"];
          foursquare_data_venueType = results[x]["venue"]["categories"][0]["name"];
          foursquare_data_venueCheckins = results[x]["venue"]["stats"]["checkinsCount"];
          if (foursquare_data_venueType.match(restSearch)) {
            restaurantsSorted[x] = { "name" : foursquare_data_venueName, "checkin" : foursquare_data_venueCheckins };
          }
        }
        restaurantsSorted.sort(function(a,b){return b.checkin - a.checkin;});
        console.log(restaurantsSorted);
        for (x = 0; x < y; x++) {
          displayData.append("<li><div class='collapsible-header'>"+restaurantsSorted[x]["name"]+"</div><div class='collapsible-body'>Checkin id: "+restaurantsSorted[x]["checkin"]+"</div></li>");
        }
      }
    });
  }
  // List of trending restaurants from zipcode submitted by user
  buttonZS.click(function() {
    console.log("Button pressed");
    displayData.empty();
    zipCode = formZipCode.val();
    if (zipCode != "") {
      $.ajax({
        method: "GET",
        url: "https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:"+zipCode+"&key="+mapsApi,
        success: function(data){
          myLongitude = data['results'][0]['geometry']['location']['lng'];
          myLatitude = data['results'][0]['geometry']['location']['lat'];
          lat_lot = "ll="+myLatitude+","+myLongitude; // Store the lat and lon info for

          $.ajax({
            method: "GET",
            url: "https://api.foursquare.com/v2/venues/explore?client_id="+client_id+"&client_secret="+client_secret+"&"+version+"&"+section+"&"+opennow+"&"+query+"&"+lat_lot,
            success: function(data){
              var results = data["response"]["groups"][0]["items"];
              console.log("Test");
              var x = 0, y = results.length - 1;

              for (x; x < y; x++) {
                foursquare_data_venueName = results[x]["venue"]["name"];
                foursquare_data_venueType = results[x]["venue"]["categories"][0]["name"];
                foursquare_data_venueCheckins = results[x]["venue"]["stats"]["checkinsCount"];
                if (foursquare_data_venueType.match(restSearch)) {
                  restaurantsSorted[x] = { "name" : foursquare_data_venueName, "checkin" : foursquare_data_venueCheckins };
                }
              }
              restaurantsSorted.sort(function(a,b){return b.checkin - a.checkin;});
              for (x; x < y; x++) {
                displayData.append("<p>"+restaurantsSorted[x]["name"]+"</p>");
              }
            }
          });
        }
      });
    }
  });

  $('.collapsible').collapsible({
      accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
    });
});
