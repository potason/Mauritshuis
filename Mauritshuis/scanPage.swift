//
//  scanPage.swift
//  Mauritshuis
//
//  Created by Mark Vermeer on 29-11-17.
//  Copyright © 2017 Mark Vermeer. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import SVProgressHUD

class scanPage: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var leadingConstraintScan: NSLayoutConstraint!
    @IBOutlet weak var viewMenuScan: UIView!
    @IBOutlet weak var paintingView: UIImageView!
    
    @IBOutlet weak var CameraButton: UIBarButtonItem!
    @IBOutlet weak var Photo: UIImageView!
    
    let APIKey = "f969050a1dd85538498beb694c8686928ed79ce1" //PAINTING RECOGNITION KEY
    let version = "2017-11-26"
    let imagePicker = UIImagePickerController()
    let benchmark = 0.7
    
    var classificationTop3: [String] = []
    var showMenuScan = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("scan page")
        leadingConstraintScan.constant = -150
        viewMenuScan.layer.shadowOpacity = 1
        viewMenuScan.layer.shadowRadius = 8
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            //start loading animation
            SVProgressHUD.show(withStatus: "Classifying your image")
            
            Photo.image = image
            paintingView.layer.shadowOpacity = 1
            paintingView.layer.shadowRadius = 8
            imagePicker.dismiss(animated: true, completion: nil)
            
            let recognition = VisualRecognition(apiKey:APIKey, version:version)
            
            let imageData = UIImageJPEGRepresentation(image, 0.01)
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("tempImage.jpg")
            
            try? imageData?.write(to: fileURL, options: [])
            
            recognition.classify(imageFile: fileURL, classifierIDs: ["Paintings"],  threshold: 0.0, success: { (classifiedImages) in
                //get IBM Bluemix results and put in a object
                let classes = classifiedImages.images.first!.classifiers.first!.classes
                
                //start with empty classification results
                self.classificationTop3 = []
                
                //order from highest score -> lowest
                let classesOrdered = classes.sorted{
                    $0.score > $1.score
                }
                
                //end loading animation
                SVProgressHUD.dismiss()
                
                //get top 3 of the image classification
                for i in 0..<3{
                    self.classificationTop3.append(classesOrdered[i].classification)
                }
                
                //if: score of the best classification > benchmark take that image, else: ask user to select the correct one from the top 3 (assuming the correct one is available in the top 3).
                if classesOrdered[0].score > self.benchmark{
                    print(classesOrdered[0].classification)
                    print(self.classificationTop3[0])
                    print(classesOrdered[0].score)
                    
                    self.oneObservation(classification: classesOrdered[0].classification)
                }else{
                    print(self.classificationTop3)
                }
            })
        } else{
            print("There was an error picking the image")
        }
    }
    
    func oneObservation(classification: String){
        //do things needed for one observation
    }
    
    
    @IBAction func CameraPressed(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func menuScan(_ sender: UIBarButtonItem) {
        self.view.bringSubview(toFront: viewMenuScan)
        
        if(showMenuScan){
            leadingConstraintScan.constant = -150
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuScan = false
        }else{
            leadingConstraintScan.constant = 0
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuScan = true
        }
    
    }
    

}
