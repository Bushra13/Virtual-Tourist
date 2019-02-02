//
//  Constants.swift
//  Virtual Tourist
//
//  Created by Bushra on 20/01/2019.
//  Copyright © 2019 Bushra Alkhushiban. All rights reserved.
//

import UIKit


struct Constants {
    
    static let APIScheme = "https"
    static let APIHost = "api.flickr.com"
    static let APIPath = "/services/rest"
    static let APIKey = "749a0b0d8ed37c4685e8bd6508a6f9f1"
    
    static let SearchBBoxHalfWidth = 1.0
    static let SearchBBoxHalfHeight = 1.0
}

struct ParameterKeys {
    static let APIKey = "api_key"
    static let Method = "method"
    static let Extras = "extras"
    static let Format = "format"
    static let NoJSONCallback = "nojsoncallback"
    static let BoundingBox = "bbox"
    static let PerPage = "per_page"
    static let Page = "page"
    static let Lat = "lat"
    static let Lon = "lon"
}

struct ParameterValues {
    static let ResponseFormat = "json"
    static let DisableJSONCallback = "1"
    static let MediumURL = "url_m"
}

struct Methods {
    static let SearchMethod = "flickr.photos.search"
}

struct ResponseKeys {
    static let Photos = "photos"
    static let Photo = "photo"
}

