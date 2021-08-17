//
//  ContentView.swift
//  DemoSiri
//
//  Created by NIIRDS Team on 8/16/21.
//

import SwiftUI

struct ContentView: View {
  
    
    var body: some View {
        VStack{
            //SiriButtonView()
            
            // TODO: Add Intent and voice shortcut?
        SiriButtonView(intent: FindPharmacyIntent, voiceShortcut: <#T##INVoiceShortcut?#>)
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
