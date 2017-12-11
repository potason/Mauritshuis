//
//  SecondViewController.swift
//  Mauritshuis
//
//  Created by Mark Vermeer on 25-11-17.
//  Copyright © 2017 Mark Vermeer. All rights reserved.
//

import UIKit
import VisualRecognitionV3

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let APIKey = "f969050a1dd85538498beb694c8686928ed79ce1" //PAINTING RECOGNITION KEY
    let version = "2017-11-26"
    
    @IBOutlet weak var CameraButton: UIBarButtonItem!
    @IBOutlet weak var Photo: UIImageView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewMenu: UIView!
    
    
    let imagePicker = UIImagePickerController()
    let benchmark = 0.7
    
    var classificationTop3 : [String] = []
    var showMenu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        viewMenu.layer.shadowOpacity = 1
        viewMenu.layer.shadowRadius = 8
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            Photo.image = image
            imagePicker.dismiss(animated: true, completion: nil)
            
            let recognition = VisualRecognition(apiKey:APIKey, version:version)

            let imageData = UIImageJPEGRepresentation(image, 0.01)
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("tempImage.jpg")
             
            try? imageData?.write(to: fileURL, options: [])
            
            
            recognition.classify(imageFile: fileURL, success: { (classifiedImages) in
                print("PHOTO IS CLASSIFIED \n")
                //get IBM Bluemix results and put in a object
                let classes = classifiedImages.images.first!.classifiers.first!.classes
                
                //start with empty classification results
                self.classificationTop3 = []
                
                //order from highest score -> lowest
                let classesOrdered = classes.sorted{
                    $0.score > $1.score
                }
                
                //get top 3 of the image classification
                for i in 0..<3{
                    self.classificationTop3.append(classesOrdered[i].classification)
                }
                
                //if: score of the best classification > benchmark take that image, else: ask user to select the correct one from the top 3 (assuming the correct one is available in the top 3).
                if classesOrdered[0].score > self.benchmark{
                    print(self.classificationTop3[0])
                    print(classesOrdered[0].score)
                }else{
                    print(self.classificationTop3)
                }
            })
            
        } else{
            print("There was an error picking the image")
        }
    }
    
    @IBAction func CameraPressed(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pressMenu(_ sender: UIBarButtonItem) {
        if(showMenu){ //hide menu
            leadingConstraint.constant = -150
            
            //animation to the menu
            UIView.animate(withDuration: 0.3, animations:{self.view.layoutIfNeeded()})
            
            showMenu = false
        }else{ //show menu
            leadingConstraint.constant = 0
            
            //animation to the menu
            UIView.animate(withDuration: 0.3, animations:{self.view.layoutIfNeeded()})
            
            showMenu = true
        }
    }
    
}
