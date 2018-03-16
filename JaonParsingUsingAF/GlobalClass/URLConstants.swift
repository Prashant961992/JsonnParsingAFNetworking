//
//  URLConstants.swift
//  VGL Swift
//
//  Created by Chetna Ranipa on 10/10/17.
//  Copyright © 2017 Chetna Ranipa. All rights reserved.
//
import Foundation
struct APPURL {
    
    public struct Domains {
        static let BaseURL = "https://mediamap.us/demo/services/"
        static let GetLatLongList = "http://mediamap.us/demo/webapi.php?format=json"
        static let GoogleDirectionURL = "https://maps.googleapis.com/maps/api/directions/json?"
        static let HostName = "71.6.154.117"
        static let UserName = "wsvgl"
        static let Password = "QWE@123"
        static let Port = 21
    }
    
    public  struct API {
        
        static let FAQAPI = Domains.BaseURL + "faq.php"
        static let ABOUTAPI = Domains.BaseURL + "about.php"
        static let TERMSAPI = Domains.BaseURL + "terms.php"

    }
   
    public  struct Constant {
        static let MINIMUM_AMOUNT_CC_AVENUE = "1"
        static let GOOGLE_KEY = "AIzaSyDwkmj0r89PGWOGHFvIda-pyngf9KpQ8KI"
    }

    public  struct ERROR_MESSAGE {
        static let NoInternet = "No Internet Connection"
    }
    
//    public struct Color {
//        static let YELLOW_PRIMARY = UIColor.init(red: 255.0/255.0, green: 197.0/255.0, blue: 57.0/255.0, alpha: 1)
//        static let GREEN_PRIMARY = UIColor.init(red: 0/255.0, green: 70.0/255.0, blue: 39.0/255.0, alpha: 1)
//    }
}
