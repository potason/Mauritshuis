//
//  ViewController.swift
//  Mauritshuis
//
//  Created by Mark Vermeer on 25-11-17.
//  Copyright © 2017 Mark Vermeer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var anonimousButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    @IBAction func AnonimousPressed(_ sender: Any) {
        print("Anonimous pressed")
    }
    
    @IBAction func FacebookPressed(_ sender: Any) {
        print("Facebook /Users/finnpotason/Programming/application/Mauritshuis/Mauritshuis/personalPage.swiftlogin pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Startscreen has loaded")
        
        //button layout
        anonimousButton.layer.cornerRadius = 5
        anonimousButton.layer.borderWidth = 1
        
        facebookButton.layer.cornerRadius = 5
        facebookButton.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

