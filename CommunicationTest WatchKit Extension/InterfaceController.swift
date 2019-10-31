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
    @IBOutlet var giveNameLabel: WKInterfaceLabel!
    @IBOutlet var textField: WKInterfaceTextField!
    
    var pokemonName : String = ""
    var pokemonSelected : String = ""
    
    
    
    // MARK: Delegate functions
    // ---------------------

    // Default function, required by the WCSessionDelegate on the Watch side
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //@TODO
    }
    
    // 3. Get messages from PHONE
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("WATCH: Got message from Phone")
        // Message from phone comes in this format: ["course":"MADT"]
//        let messageBody = message["course"] as! String
        self.pokemonSelected = message["pokemon"] as! String
        self.giveNameLabel.setHidden(false)
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
        
        self.giveNameLabel.setHidden(true)
        self.textField.setHidden(true)
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

    @IBAction func namePokemon(_ value: NSString?) {
        self.pokemonName = value! as String
        self.giveNameLabel.setText(pokemonName)
    }
    
    //send a message to the phone
    @IBAction func buttonPressed() {
        
        if WCSession.default.isReachable {
            print("Attempting to send message to phone")
            self.messageLabel.setText("Sending msg to watch")
            WCSession.default.sendMessage(
                ["name" : "Pritesh"],
                replyHandler: {
                    (_ replyMessage: [String: Any]) in
                    print("Message sent, put something here if u are expecting a reply from the phone")
                    self.messageLabel.setText("Got reply from phone")
            }, errorHandler: { (error) in
                print("Error while sending message: \(error)")
                self.messageLabel.setText("Error sending message")
            })
        }
        else {
            print("Phone is not reachable")
            self.messageLabel.setText("Cannot reach phone")
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
