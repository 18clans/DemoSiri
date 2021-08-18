//
//  IntentHandler.swift
//  FindPharmacyIntent
//
//  Created by NIIRDS Team on 8/17/21.
//

import Intents
import SwiftUI

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        /*guard intent is FindPharmacyIntent else {
            
            return .none
        }*/
        
        return FindPharmacyIntentHandler()
    }
    
}
