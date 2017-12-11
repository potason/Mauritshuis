//
//  searchPage.swift
//  Mauritshuis
//
//  Created by Mark Vermeer on 29-11-17.
//  Copyright © 2017 Mark Vermeer. All rights reserved.
//

import UIKit

class searchPage: UIViewController {

    @IBOutlet weak var leadingConstraintSearch: NSLayoutConstraint!
    @IBOutlet weak var viewMenuSearch: UIView!
    @IBOutlet weak var girl: UIButton!
    @IBOutlet weak var delft: UIButton!
    @IBOutlet weak var diana: UIButton!
    
    var showMenuSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("search page")
        leadingConstraintSearch.constant = -150
        viewMenuSearch.layer.shadowOpacity = 1
        viewMenuSearch.layer.shadowRadius = 8
        
        //button layouts
        girl.backgroundColor = UIColor(displayP3Red: 43/255, green: 128/255, blue: 2/255, alpha: 1)
        girl.layer.shadowOpacity = 0.5
        girl.layer.cornerRadius = 5
        girl.layer.borderWidth = 1
        
        delft.backgroundColor = UIColor(displayP3Red: 43/255, green: 128/255, blue: 2/255, alpha: 1)
        delft.layer.shadowOpacity = 0.5
        delft.layer.cornerRadius = 5
        delft.layer.borderWidth = 1
        
        diana.backgroundColor = UIColor(displayP3Red: 43/255, green: 128/255, blue: 2/255, alpha: 1)
        diana.layer.shadowOpacity = 0.5
        diana.layer.cornerRadius = 5
        diana.layer.borderWidth = 1
    }

    @IBAction func menuSearch(_ sender: UIBarButtonItem) {
        self.view.bringSubview(toFront: viewMenuSearch)
        
        if(showMenuSearch){
            leadingConstraintSearch.constant = -150
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuSearch = false
        }else{
            leadingConstraintSearch.constant = 0
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuSearch = true
        }
    
    
    }
    
}
