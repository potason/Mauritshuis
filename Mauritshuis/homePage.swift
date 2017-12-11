//
//  homePage.swift
//  Mauritshuis
//
//  Created by Mark Vermeer on 29-11-17.
//  Copyright © 2017 Mark Vermeer. All rights reserved.
//

import UIKit

class homePage: UIViewController {

    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var viewMenuHome: UIView!
    
    var showMenuHome = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("home page")
        leadingConstraint.constant  = -150
        viewMenuHome.layer.shadowOpacity = 1
        viewMenuHome.layer.shadowRadius = 8
        picture.layer.shadowOpacity = 1
        picture.layer.shadowRadius = 8
    }
    
    @IBAction func menuHome(_ sender: UIBarButtonItem) {
        self.view.bringSubview(toFront: viewMenuHome)
        
        if(showMenuHome){
            leadingConstraint.constant = -150
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuHome = false
        }else{
            leadingConstraint.constant = 0
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuHome = true
        }
    }
}
