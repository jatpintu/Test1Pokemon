//
//  ViewController.swift
//  CommunicationTest
//
//  Created by Parrot on 2019-10-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate  {
    
    var pokemonSelected : String = ""

    @IBOutlet weak var outputLabel: UITextView!
    @IBOutlet weak var pokemon1: UILabel!
    @IBOutlet weak var pokemon2: UILabel!
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    //Received messages from Watch
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            self.outputLabel.insertText("\nMessage Received: \(message)")
        }
        print("Received a message from the watch: \(message)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 1. Check if phone supports WCSessions
        print("view loaded")
        if WCSession.isSupported() {
            outputLabel.insertText("\nPhone supports WCSession")
            WCSession.default.delegate = self
            WCSession.default.activate()
            outputLabel.insertText("\nSession activated")
        }
        else {
            print("Phone does not support WCSession")
            outputLabel.insertText("\nPhone does not support WCSession")
        }
        
        self.pokemon1.alpha = 0.0
        self.pokemon2.alpha = 0.0
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sendMessageButtonPressed(_ sender: Any) {
        
        outputLabel.insertText("\nTrying to send message to watch")
        
//        if (WCSession.default.isReachable) {
//            let message = ["course": "MADT"]
//            WCSession.default.sendMessage(message, replyHandler: nil)
//            outputLabel.insertText("\nMessage sent to watch")
//            print("Message sent to watch")
//        }
//        else {
//            print("PHONE: Cannot reach watch")
//            outputLabel.insertText("\nCannot reach watch")
//        }
    }
    
    @IBAction func pokemonButtonPressed(_ sender: Any) {
        print("You pressed the pokemon button")
        self.pokemonSelected = "pikachu"
        if (WCSession.default.isReachable) {
            let message = ["pokemon": "pok1"] as [String : Any]
                   WCSession.default.sendMessage(message, replyHandler: nil)
                   outputLabel.insertText("\nMessage sent to watch")
                   print("Message sent to watch")
               }
               else {
                   print("PHONE: Cannot reach watch")
                   outputLabel.insertText("\nCannot reach watch")
               }
    }
    @IBAction func caterpieButtonPressed(_ sender: Any) {
        print("You pressed the caterpie button")
        self.pokemonSelected = "caterpie"
        if (WCSession.default.isReachable) {
            let message = ["pokemon": "pok2"] as [String : Any]
                   WCSession.default.sendMessage(message, replyHandler: nil)
                   outputLabel.insertText("\nMessage sent to watch")
                   print("Message sent to watch")
               }
               else {
                   print("PHONE: Cannot reach watch")
                   outputLabel.insertText("\nCannot reach watch")
               }
    }
    
    
}

