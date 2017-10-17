//
//  ViewController.swift
//  BirdInCage
//
//  Created by Alixa Bahena on 10/15/17.
//  Copyright © 2017 Alixa Bahena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var startClicked: Bool = true
    var speed: Double = 1
    @IBOutlet var startButton: UIButton!
    @IBOutlet var slowButton: UIButton!
    @IBOutlet var fastButton: UIButton!
    @IBOutlet var cageImage: UIImageView!
    @IBOutlet var birdImage: UIImageView!
    @IBOutlet var birdImageCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var cageImageCenterXConstraint: NSLayoutConstraint!
    
    @IBAction func fastButtonPressed(_ sender: Any) {
        speed -= 0.5
        animateLabelTransitions()
    }
    
    @IBAction func slowButtonPressed(_ sender: Any) {
        speed += 0.5
        animateLabelTransitions()
    }
    
    @IBAction func startButtonPressed(sender: AnyObject)
    {
        
            if (startClicked)
            {
                startButton.setTitle("Stop", for: .normal)
               animateLabelTransitions()
                slowButton.isEnabled = true
                fastButton.isEnabled = true
               startClicked = false
            }
            else
            {
                startButton.setTitle("Start", for: .normal)
                startClicked = true
                birdImage.layer.removeAllAnimations()
                cageImage.layer.removeAllAnimations()
                slowButton.isEnabled = false
                fastButton.isEnabled = false
                
            }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateOffScreenLabel()
        slowButton.isEnabled = false
        fastButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
       cageImage.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateOffScreenLabel(){
        let screenWidth = view.frame.width
        cageImageCenterXConstraint.constant = -screenWidth
    }
    
    //function to create animations for labels and label constraints
    func animateLabelTransitions() {
        //force any outstanding layout changes to occur
        view.layoutIfNeeded()
        //Animate the alpha
        //and the center X constraints
       let screenWidth = view.frame.width
        self.cageImageCenterXConstraint.constant = 0
        self.birdImageCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: speed,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
                        self.birdImage.alpha = 0
                        self.cageImage.alpha = 1
                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        swap(&self.birdImage, &self.cageImage)
                        swap(&self.birdImageCenterXConstraint,  &self.cageImageCenterXConstraint)
                        
                        self.updateOffScreenLabel()
        })
    }

}

