//
//  friendsPage.swift
//  Mauritshuis
//
//  Created by Mark Vermeer on 29-11-17.
//  Copyright © 2017 Mark Vermeer. All rights reserved.
//

import UIKit

class friendsPage: UIViewController {

    @IBOutlet weak var leadingConstraintFriends: NSLayoutConstraint!
    @IBOutlet weak var viewMenuFriends: UIView!
    
    @IBOutlet weak var girlButton: UIButton!
    @IBOutlet weak var tulpButton: UIButton!
    @IBOutlet weak var saulButton: UIButton!
    @IBOutlet weak var student1Button: UIButton!
    @IBOutlet weak var student2Button: UIButton!
    
    var showMenuFriends = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("friends page")
        leadingConstraintFriends.constant = -150
        viewMenuFriends.layer.shadowOpacity = 1
        viewMenuFriends.layer.shadowRadius = 8
        
        //button layouts
        girlButton.backgroundColor = UIColor(displayP3Red: 43/255, green: 128/255, blue: 2/255, alpha: 1)
        girlButton.layer.shadowOpacity = 0.5
        girlButton.layer.cornerRadius = 5
        girlButton.layer.borderWidth = 1
        
        tulpButton.backgroundColor = UIColor(displayP3Red: 43/255, green: 128/255, blue: 2/255, alpha: 1)
        tulpButton.layer.shadowOpacity = 0.5
        tulpButton.layer.cornerRadius = 5
        tulpButton.layer.borderWidth = 1
        
        saulButton.backgroundColor = UIColor(displayP3Red: 43/255, green: 128/255, blue: 2/255, alpha: 1)
        saulButton.layer.shadowOpacity = 0.5
        saulButton.layer.cornerRadius = 5
        saulButton.layer.borderWidth = 1
        
        student1Button.backgroundColor = UIColor(displayP3Red: 43/255, green: 128/255, blue: 2/255, alpha: 1)
        student1Button.layer.shadowOpacity = 0.5
        student1Button.layer.cornerRadius = 5
        student1Button.layer.borderWidth = 1
        
        student2Button.backgroundColor = UIColor(displayP3Red: 43/255, green: 128/255, blue: 2/255, alpha: 1)
        student2Button.layer.shadowOpacity = 0.5
        student2Button.layer.cornerRadius = 5
        student2Button.layer.borderWidth = 1
    }

    @IBAction func menuFriends(_ sender: UIBarButtonItem) {
        self.view.bringSubview(toFront: viewMenuFriends)
        
        if(showMenuFriends){
            leadingConstraintFriends.constant = -150
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuFriends = false
        }else{
            leadingConstraintFriends.constant = 0
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuFriends = true
        }
    }
    
}
