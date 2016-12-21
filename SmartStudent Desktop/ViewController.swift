//
//  ViewController.swift
//  SmartStudent Desktop
//
//  Created by Christopher Johnson on 12/13/16.
//  Copyright © 2016 Smartstar. All rights reserved.
//

import Cocoa
//import Alamofire
import SwiftHTTP

class ViewController: NSViewController {
    
    @IBOutlet weak var submitButton : NSButton!
    @IBOutlet weak var submitProgressBar : NSProgressIndicator!
    @IBOutlet weak var submitResultLabel : NSTextField!
    
    @IBOutlet weak var actionTabView : NSTabView!
    
    // Stuff from the set tab
    @IBOutlet weak var setTabNameField : NSTextField!
    @IBOutlet weak var setTabTraitField : NSTextField!
    @IBOutlet weak var setTabValueSlider : NSSlider!
    
    // Stuff from the view tab
    @IBOutlet weak var viewTabTextField : NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        submitResultLabel.isHidden = true
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            
        }
    }
    func doPOST( parameters : [ String : String ] ){
        do {
            let params = parameters
            let opt = try HTTP.POST("http://127.0.0.1:8080", parameters: params)
            opt.start { response in
                if let err = response.error {
                    self.submitResultLabel.isHidden = false
                    self.submitResultLabel.stringValue = "Failure: " + String(err.code)
                    return
                }
                //print("data is: \(response.data)") access the response of the data with response.data
            }/*
             let params = [ "key" : "key", "value" : "value", "action" : "set" ]
             let opt = try HTTP.POST("127.0.0.1:8080", parameters: params)
             opt.start { response in
             if response.error != nil {
             self.outputLabel.stringValue = "Failure"
             return
             }
             self.outputLabel.stringValue = "Done"
             }*/
            //let opt = try HTTP.GET("127.0.0.1:8080")
            //opt.start()
            //self.outputLabel.stringValue = "Good"
        } catch let error {
            self.submitResultLabel.isHidden = false
            self.submitResultLabel.stringValue = "Post failure: " + error.localizedDescription
        }
    }
    
    func doGET( path : String ) {
        do {
            let opt = try HTTP.GET("http://127.0.0.1:8080" + path)
            opt.progress = { progress in
                self.submitProgressBar.doubleValue = Double(progress)
            }
            opt.start { response in
                if let err = response.error {
                    self.submitResultLabel.isHidden = false
                    self.submitResultLabel.stringValue = "Failure: " + String(err.code)
                    return
                }
                //self.viewTabTextField.objectValue = response.data
                self.viewTabTextField.stringValue = (response.text ?? "")
                //print("data is: \(response.data)") access the response of the data with response.data
            }
            /*
             let params = [ "key" : "key", "value" : "value", "action" : "set" ]
             let opt = try HTTP.POST("127.0.0.1:8080", parameters: params)
             opt.start { response in
             if response.error != nil {
             self.outputLabel.stringValue = "Failure"
             return
             }
             self.outputLabel.stringValue = "Done"
             }*/
            //let opt = try HTTP.GET("127.0.0.1:8080")
            //opt.start()
            //self.outputLabel.stringValue = "Good"
        } catch let error {
            self.submitResultLabel.isHidden = false
            self.submitResultLabel.stringValue = "Get failure: " + error.localizedDescription
        }
    }
    func doFavicon() {
        do {
            let opt = try HTTP.GET("http://127.0.0.1:8080/favicon.ico")
            opt.start { response in
                if let err = response.error {
                    self.submitResultLabel.isHidden = false
                    self.submitResultLabel.stringValue = "Failure: " + String(err.code)
                    return
                }
                
                //self.viewTabTextField.objectValue = response.data
                //print("data is: \(response.data)") access the response of the data with response.data
            }/*
             let params = [ "key" : "key", "value" : "value", "action" : "set" ]
             let opt = try HTTP.POST("127.0.0.1:8080", parameters: params)
             opt.start { response in
             if response.error != nil {
             self.outputLabel.stringValue = "Failure"
             return
             }
             self.outputLabel.stringValue = "Done"
             }*/
            //let opt = try HTTP.GET("127.0.0.1:8080")
            //opt.start()
            //self.outputLabel.stringValue = "Good"
        } catch let error {
            self.submitResultLabel.isHidden = false
            self.submitResultLabel.stringValue = "Get failure: " + error.localizedDescription
        }
    }
    
    @IBAction func submit( _: AnyObject ) {
        switch self.actionTabView.indexOfTabViewItem(self.actionTabView.selectedTabViewItem!) {
        case 0:
            self.doPOST(parameters: [ "action" : "set", "name" : self.setTabNameField.stringValue, "trait" : self.setTabTraitField.stringValue, "value" : String(self.setTabValueSlider.integerValue)])
        default:
            NSLog("This should never have been executed")
        }
    }
    
    @IBAction func request( _: AnyObject ) {
        self.doGET(path: "")
        //self.doFavicon()
    }
}

