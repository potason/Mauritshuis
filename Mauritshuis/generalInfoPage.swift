//
//  generalInfoPage.swift
//  Mauritshuis
//
//  Created by Mark Vermeer on 29-11-17.
//  Copyright © 2017 Mark Vermeer. All rights reserved.
//

import UIKit

class generalInfoPage: UIViewController {
    
    @IBOutlet weak var leadingConstraintGeneral: NSLayoutConstraint!
    @IBOutlet weak var viewMenuGeneral: UIView!
    
    var showMenuGeneral = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("general info page")
        leadingConstraintGeneral.constant = -150
    }

    @IBAction func menuGeneral(_ sender: UIBarButtonItem) {
        self.view.bringSubview(toFront: viewMenuGeneral)
        
        if(showMenuGeneral){
            leadingConstraintGeneral.constant = -150
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuGeneral = false
        }else{
            leadingConstraintGeneral.constant = 0
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuGeneral = true
        }
    
    }
    
}
