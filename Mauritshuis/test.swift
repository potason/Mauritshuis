//
//  test.swift
//  Mauritshuis
//
//  Created by Mark Vermeer on 02-12-17.
//  Copyright © 2017 Mark Vermeer. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import SVProgressHUD

class test: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var leadingConstraintScan2: NSLayoutConstraint!
    @IBOutlet weak var viewMenuScan2: UIView!
    @IBOutlet weak var paintingView: UIImageView!
    
    @IBOutlet weak var paintingTitle: UILabel!
    @IBOutlet weak var paintingInfo: UILabel!
    @IBOutlet weak var charactersTitle: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var CameraButton: UIBarButtonItem!
    @IBOutlet weak var Photo: UIImageView!
    
    let APIKey = "f969050a1dd85538498beb694c8686928ed79ce1" //PAINTING RECOGNITION KEY
    let version = "2017-11-26"
    let imagePicker = UIImagePickerController()
    let benchmark = 0.1
    
    var stackView = UIStackView()
    var classificationResult:String = ""
    var numberOfFaces:Int = 0
    var classificationTop3: [String] = []
    var showMenuScan2 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("scan2 page")
        leadingConstraintScan2.constant = -150
        viewMenuScan2.layer.shadowOpacity = 1
        viewMenuScan2.layer.shadowRadius = 8
        imagePicker.delegate = self
        paintingTitle.text = "Make/load a picture"
        paintingInfo.text = "To make or load a picture press the camera button on the top right!"
        charactersTitle.isHidden = true
        
        //button layout
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            classificationResult = ""
            numberOfFaces = 0
            var check1 = false
            var check2 = false
            //start loading animation
            SVProgressHUD.show(withStatus: "Classifying your image")
            
            Photo.alpha = 1
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
                
                //get top 3 of the image classification
                for i in 0..<3{
                    self.classificationTop3.append(classesOrdered[i].classification)
                }
                
                //if: score of the best classification > benchmark take that image, else: ask user to select the correct one from the top 3 (assuming the correct one is available in the top 3).
                if classesOrdered[0].score > self.benchmark{
                    self.classificationResult = classesOrdered[0].classification
                    check1 = true
                }else{
                    print(self.classificationTop3)
                }
            })
            
            recognition.detectFaces(inImageFile: fileURL, success: {(facesClassified) in
                self.numberOfFaces = facesClassified.images[0].faces.count
                check2 = true
            })

            //call function to fill the scan page
            var timer: Timer!
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (checking) in
                if(check1 && check2){
                    self.charactersTitle.isHidden = false
                    
                    //end loading animation
                    SVProgressHUD.dismiss()
                    
                    //load the right people and information
                    self.oneObservation(classification: self.classificationResult, facesNumber: self.numberOfFaces)
                    
                    timer.invalidate()
                }
            })
            
        } else{
            print("There was an error picking the image")
        }
    }
    
    func oneObservation(classification: String, facesNumber: Int){
        //do things needed for one observation
        print(classification)
        print(facesNumber)
        
        stackView.removeFromSuperview()
        
        if(classification == "les"){
            paintingTitle.text = "The Anatomy Lesson of Dr. Nicolaes Tulp, 1632"
            paintingInfo.text = "Rembrandt was only twenty-five when he was asked to paint the portraits of the Amsterdam surgeons. The portrait was commissioned for the anatomy lesson given by Dr Nicolaes Tulp in January 1632. Rembrandt portrayed the surgeons in action, and they are all looking at different things. Dynamism is added to the scene by the great contrasts between light and dark. In this group portrait, the young painter displayed his legendary technique and his great talent for painting lifelike portraits."
            
            let nameArray: [String] = ["Mark", "Finn", "Maaike", "Thimo", "Vincent"]
            makeStackViewCharacters(names: nameArray)
            
        } else if(classification == "meisje"){
            paintingTitle.text = "Girl with a pearl earring, 1665"
            paintingInfo.text = "Girl with a Pearl Earring is Vermeer’s most famous painting. It is not a portrait, but a ‘tronie’ – a painting of an imaginary figure. Tronies depict a certain type or character; in this case a girl in exotic dress, wearing an oriental turban and an improbably large pearl in her ear.\n\nJohannes Vermeer was the master of light. This is shown here in the softness of the girl’s face and the glimmers of light on her moist lips. And of course, the shining pearl."
            
            let nameArray: [String] = ["Girl with the pearl"]
            makeStackViewCharacters(names: nameArray)
            
        }else if(classification == "S&D"){
            paintingTitle.text = "Saul & David, 1651-1654 and 1655-1658"
            paintingInfo.text = "Saul and David was considered one of Rembrandt’s most famous paintings and a highlight of the Mauritshuis collection from the time of its acquisition in 1898 until 1969, when it’s attribution was rejected and the picture lost much of its allure.\n\nAfter a long period of study and treatment, the painting is once again the focus of attention as the centrepiece of the exhibition Rembrandt? The Case of Saul and David. In the exhibition we tell the gripping story of the painting’s history, the research, the conservation treatment and the advanced techniques that were used. And we give the final answer: Yes, it's a Rembrandt!"
            
            let nameArray: [String] = ["Saul", "David"]
            makeStackViewCharacters(names: nameArray)
            
        }else if(classification == "self"){
            paintingTitle.text = "Portrait of Rembrandt with a gorget, 1629"
            paintingInfo.text = "For a long time, this painting was thought to be a self-portrait of the young Rembrandt. But extensive research showed that it is a very good copy of a self-portrait of Rembrandt, made by one of his pupils. The original made by Rembrandt is in Nuremberg. Although this panel was not painted by Rembrandt, it does depict the painter at the age of twenty-three."
        
            let nameArray: [String] = ["Rembrandt van Rijn"]
            makeStackViewCharacters(names: nameArray)
            
        }
    }
    
    func makeStackViewCharacters(names: [String]){
        stackView = UIStackView(arrangedSubviews: createButtons(named: names))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        //constraints
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        stackView.topAnchor.constraint(equalTo: charactersTitle.bottomAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
    }
    
    func createButtons(named: [String]) -> [UIButton]{
        return named.map { name in
            let button = UIButton(type: UIButtonType.system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(name, for:.normal)
            button.backgroundColor = UIColor(displayP3Red: 43/255, green: 128/255, blue: 2/255, alpha: 1)
            button.layer.shadowOpacity = 0.5
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont(name: "Arial", size: 20)
            button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
            
            return button
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton){
        //print("button tapped")
        performSegue(withIdentifier: "Rembrandt", sender: self)
    }
    
    @IBAction func CameraPressed(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func menuScan2(_ sender: UIBarButtonItem) {
        self.view.bringSubview(toFront: viewMenuScan2)
        
        if(showMenuScan2){
            leadingConstraintScan2.constant = -150
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuScan2 = false
        }else{
            leadingConstraintScan2.constant = 0
            
            //animation to menu
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
            showMenuScan2 = true
        }
    }
    
    
}
