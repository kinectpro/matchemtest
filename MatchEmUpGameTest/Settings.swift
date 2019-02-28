//
//  Settings.swift
//  MatchEmUpGameTest
//
//  Created by Денис Марков on 2/27/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

struct Settings {
    static let googlePlacesAPIKey = "AIzaSyDqY0VhKj6_mEaxhnL_ut35KUgju_1chvA"
    static let placesType = "restaurant"
    static let radiusSearch = "1609" // 1 mile in meters
    static let maxPhotoWidth = 400
    static let photoDownloadServerUrl = "https://maps.googleapis.com/maps/api/place/photo?"
   
    //https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=&radius=1609&types=restaurant&key=AIzaSyDqY0VhKj6_mEaxhnL_ut35KUgju_1chvA
    //https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU&key=AIzaSyDqY0VhKj6_mEaxhnL_ut35KUgju_1chvA
    
    //https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU&key=YOUR_API_KEY
}
