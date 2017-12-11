//
//  personalPage.swift
//  Mauritshuis
//
//  Created by Mark Vermeer on 29-11-17.
//  Copyright © 2017 Mark Vermeer. All rights reserved.
//

import UIKit

class personalPage: UIViewController {
    
    @IBOutlet weak var leadingConstraintPersonal: NSLayoutConstraint!
    @IBOutlet weak var viewMenuPersonal: UIView!
    
    var showMenuPersonal = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("personal page")
        leadingConstraintPersonal.constant = -150
        viewMenuPersonal.layer.shadowOpacity = 1
        viewMenuPersonal.layer.shadowRadius = 8
    }
    
    @IBAction func menuPersonal(_ sender: UIBarButtonItem) {
        self.view.bringSubview(toFront: viewMenuPersonal)
        
        if(showMenuPersonal){
            leadingConstraintPersonal.constant = -150
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuPersonal = false
        }else{
            leadingConstraintPersonal.constant = 0
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuPersonal = true
        }
        
    }

    
}
