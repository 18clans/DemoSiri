//
//  IntentViewController.swift
//  FindPharmacyIntentUI
//
//  Created by NIIRDS Team on 7/28/21.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    @IBOutlet weak var pharmName: UILabel!
    @IBOutlet weak var pharmAddress1: UILabel!
    @IBOutlet weak var pharmAddress2: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var zip: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    /*private func configureView(for result: Set<INIntentResponse>,
                       of interaction: INInteraction,
                       interactiveBehavior: INUIInteractiveBehavior,
                       context: INUIHostedViewContext,
                       completion: @escaping (Bool, Set<INIntentResponse>, CGSize) -> Void) {
        
        guard let intent = interaction.intentResponse as? FindPharmacyIntentResponse else {
        completion(false, Set(), .zero)
            return
        }
        
z        if let name = intent.result?.name {
            self.pharmName.text = "Buy \(name) shares?"
        }
        



        
        completion(true, Set(result), self.desiredSize)
    }*/
    
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        if interaction.intentHandlingStatus == .success {
            if let response = interaction.intentResponse as? FindPharmacyIntentResponse {
                //let pharmView = Pharmacy
                self.pharmName.text = response.result?.name
                self.pharmAddress1.text = response.result?.address1
                self.city.text = response.result?.city
                self.state.text = response.result?.state
                self.zip.text = response.result?.zip
            }
        }
        guard let intent = interaction.intent as? FindPharmacyIntent else {
            completion(false, parameters, .zero)
            print("test1")
            return
        }
        //self.pharmName.text = "Test Text"
        
       /* if let name = intent.identifier {
            print("test2")
            self.pharmName.text = "\(name)"
        }*/
        print("test3")
        completion(true, parameters, self.desiredSize)
        
    }
    
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}
