//
//  InterfaceController.swift
//  CommunicationTest WatchKit Extension
//
//  Created by Parrot on 2019-10-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

@available(watchOSApplicationExtension 6.0, *)
class InterfaceController: WKInterfaceController, WCSessionDelegate {


    @IBOutlet var messageLabel: WKInterfaceLabel!

    @IBOutlet var pokemonImageView: WKInterfaceImage!

    @IBOutlet var nameLabel: WKInterfaceLabel!

    @IBOutlet var outputLabel: WKInterfaceLabel!
    @IBOutlet var textField: WKInterfaceTextField!
    
    var pokemonName : String = ""
    var pokemonSelected : String = ""
    

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //@TODO
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("WATCH: Got message from Phone")
        self.pokemonSelected = message["pokemon"] as! String
        self.textField.setHidden(false)
        print(self.pokemonSelected)
        
    }
   
    // MARK: WatchKit Interface Controller Functions
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        
        
    }
    
    override func willActivate() {
        super.willActivate()
        
        self.textField.setHidden(true)
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

    @IBAction func namePokemon(_ value: NSString?) {
        self.pokemonName = value! as String
    }
    
    //send a message to the phone
    @IBAction func buttonPressed() {
        
        if (WCSession.default.isReachable == true)
        {
            let pokmessage = ["pokename":self.pokemonName,"pokselected":self.pokemonSelected] as [String : Any]
            WCSession.default.sendMessage(pokmessage, replyHandler:nil)
            print("Message Sent to Phone")
        }
        else
        {
            print("Message was not sent to Phone")
        }
    }
    
    
    // MARK: Functions for Pokemon Parenting
    @IBAction func nameButtonPressed() {
        print("name button pressed")
    }

    @IBAction func startButtonPressed() {
        print("Start button pressed")
    }
    
    @IBAction func feedButtonPressed() {
        print("Feed button pressed")
    }
    
    @IBAction func hibernateButtonPressed() {
        print("Hibernate button pressed")
    }
    
}
