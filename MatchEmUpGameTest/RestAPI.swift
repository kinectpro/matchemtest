//
//  RestAPI+getRestaurants.swift
//  MatchEmUpGameTest
//
//  Created by Денис Марков on 2/27/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire
import SwiftyJSON

class RestAPI {
    
    func getRestaurants(location: String, callback: @escaping (_ isOK: Bool, [GooglePlace]?) -> Void) {
        let requestURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location)&radius=\(Settings.radiusSearch)&types=\(Settings.placesType)&fields=photos&key=\(Settings.googlePlacesAPIKey)"
        
        Alamofire.request(requestURL, method: .get).validate().responseObject{ (response: DataResponse<GooglePlacesResponseWrapper>) in
            guard response.result.isSuccess else {
                debugPrint("Error: \(String(describing: response.result))")
                callback(false, nil)
                return
            }
            if let value = response.result.value {
                callback(true, value.results)
            } else {
                callback(false, nil)
            }
        }
    }
    
    
}

class GooglePlacesResponseWrapper: NSObject, Mappable {
    
    var html_attributions: [Any]?
    var next_page_token: String?
    var results: [GooglePlace]?
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        html_attributions   <- map["html_attributions"]
        next_page_token     <- map["next_page_token"]
        results             <- map["results"]
    }
}

class GooglePlace: NSObject, Mappable {
    var geometry: [Any]?
    var icon: String?
    var id: String?
    var name: String?
    var opening_hours: [Any]?
    var photos: [GooglePlacePhoto]?
    var place_id: String?
    var plus_code: Any?
    var rating: Double?
    var reference: String?
    var scope: String?
    var types: [String]?
    var user_ratings_total: Int?
    var vicinity: String?
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        geometry                <- map["geometry"]
        icon                    <- map["icon"]
        id                      <- map["id"]
        name                    <- map["name"]
        opening_hours           <- map["opening_hours"]
        photos                  <- map["photos"]
        place_id                <- map["place_id"]
        plus_code               <- map["plus_code"]
        rating                  <- map["rating"]
        reference               <- map["reference"]
        scope                   <- map["scope"]
        types                   <- map["types"]
        user_ratings_total      <- map["user_ratings_total"]
        vicinity                <- map["vicinity"]
    }
}

class GooglePlacePhoto: NSObject, Mappable {
    var height: Int?
    var width: Int?
    var html_attributions: [String]?
    var photo_reference: String?
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        height                  <- map["height"]
        width                   <- map["width"]
        html_attributions       <- map["html_attributions"]
        photo_reference         <- map["photo_reference"]
    }
    
}

/*{
 "geometry" : {
 "location" : {
 "lat" : -33.8648016,
 "lng" : 151.2054365
 },
 "viewport" : {
 "northeast" : {
 "lat" : -33.8634551197085,
 "lng" : 151.2068586802915
 },
 "southwest" : {
 "lat" : -33.8661530802915,
 "lng" : 151.2041607197085
 }
 }
 },
 "icon" : "https://maps.gstatic.com/mapfiles/place_api/icons/lodging-71.png",
 "id" : "bc58a5ca8e9c65e7b673c6cd628d24828a104be6",
 "name" : "Travelodge Hotel Sydney Wynyard",
 "opening_hours" : {
 "open_now" : true
 },
 "photos" : [
 {
 "height" : 2048,
 "html_attributions" : [
 "\u003ca href=\"https://maps.google.com/maps/contrib/112804721426091817263/photos\"\u003eTravelodge Hotel Sydney Wynyard\u003c/a\u003e"
 ],
 "photo_reference" : "CmRaAAAAygKX1T87epDYGmBdPV6DsYydE2p-6xbJfFlmnwzdjQLUkKj0byTpdGEHuP3xlf6rpktq6aYKfCs3BCIpXziofuz0zmOF67MnG5X8oPoSRitiSzp1pFc_wumpONnnafEKEhDSO_553cqO8j5bfHXppAIhGhSMlBaVi4GFvfvPH7BTxmi-9_YQEw",
 "width" : 1536
 }
 ],
 "place_id" : "ChIJDTwzJEGuEmsRw4ifQGYDkww",
 "plus_code" : {
 "compound_code" : "46P4+35 Сидней, New South Wales, Австралия",
 "global_code" : "4RRH46P4+35"
 },
 "rating" : 3.7,
 "reference" : "ChIJDTwzJEGuEmsRw4ifQGYDkww",
 "scope" : "GOOGLE",
 "types" : [ "lodging", "restaurant", "point_of_interest", "food", "establishment" ],
 "user_ratings_total" : 833,
 "vicinity" : "7-9 York Street, Sydney"
 }*/
