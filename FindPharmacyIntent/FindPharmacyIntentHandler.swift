//
//  FindPharmacyIntentHandler.swift
//  NaviAssistant
//
//  Created by NIIRDS Team on 8/9/21.
//

import Foundation
import Intents
import SwiftUI

struct Pharmacy2: Codable, Identifiable{
    let id = UUID()
    var nabp: String
    var npi: String
    var name: String
    var address1: String?
    var address2: String?
    var city: String
    var state: String
    var zip: String
    var phoneNumber: String
    var latitude: Double
    var longitude: Double
}

struct latLon {
    var lat: String
    var lon: String
}

class FindPharmacyIntentHandler: NSObject, FindPharmacyIntentHandling {
    @ObservedObject private var locationManager = LocationManager()
    func handle(intent: FindPharmacyIntent,
                completion: @escaping (FindPharmacyIntentResponse) -> Void) {
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //var coordinates = getLocation()
            var coordinates: latLon = latLon(lat: "", lon: "")
            self.locationManager.$location.sink{location in
                
                let lat = String(location?.coordinate.latitude ?? 0)
                let lon = String(location?.coordinate.longitude ?? 0)
                
                coordinates = latLon(lat: lat, lon: lon)
                print(coordinates)
            }
                // Iterate the available characters, creating
                // a GameCharacter for each one.
            Api2().get(url: "https://mx-test.navitus.com/v1/Pharmacy/FindWithinPublic?latitude=\(coordinates.lat)&longitude=\(coordinates.lon)&radius=5&globalMemberID=T07825629") { (pharmacies) in
                let pharmacy: [PharmacyResponse] = [PharmacyResponse(
                    identifier: pharmacies[0].npi,
                    display: pharmacies[0].name)]
                
                pharmacy[0].name = pharmacies[0].name
                pharmacy[0].nabp = pharmacies[0].nabp
                pharmacy[0].npi = pharmacies[0].npi
                pharmacy[0].address1 = pharmacies[0].address1
                pharmacy[0].address2 = pharmacies[0].address2
                pharmacy[0].city = pharmacies[0].city
                pharmacy[0].state = pharmacies[0].state
                pharmacy[0].zip = pharmacies[0].zip
                pharmacy[0].phoneNumber = pharmacies[0].phoneNumber
                pharmacy[0].latitude = Double(pharmacies[0].latitude) as NSNumber?
                pharmacy[0].longitude = Double(pharmacies[0].longitude) as NSNumber?
               
                print(pharmacy)
                
               // let activityType = "com.navitus.naviassistant"
                //let activity = NSUserActivity(activityType: activityType)
                
                let response = FindPharmacyIntentResponse(code: .success, userActivity: nil)
                let error = FindPharmacyIntentResponse(code: .failure, userActivity: nil)

                response.result = pharmacy[0]
                
                if pharmacy[0].npi != nil {
                        completion(response)
                    
                        //completion(.failure(error: "This did not work"))

                    } else {
                        //completion(response)
                        completion(error)
                    }
            }
        }
      


        
        func getLocation() -> latLon {
            var coordinates: latLon = latLon(lat: "", lon: "")
            locationManager.$location.sink{location in
                
                let lat = String(location?.coordinate.latitude ?? 0)
                let lon = String(location?.coordinate.longitude ?? 0)
                print(lat, lon)
                
                coordinates = latLon(lat: lat, lon: lon)
                print(coordinates)
            }
            
                return coordinates
        }
        
    }
    
    
    class Api2{
        func get(url: String, completion: @escaping([Pharmacy2]) -> ()){
            guard let urlPath = URL(string: url) else { return }
            
            URLSession.shared.dataTask(with: urlPath) { (data, _, _) in
                let gets = try! JSONDecoder().decode([Pharmacy2].self, from: data!)
                
                DispatchQueue.main.async {
                    completion(gets)
                }
            }
            .resume()
    }
}
}
