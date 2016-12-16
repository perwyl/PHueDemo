//
//  ViewController.swift
//  PHueDemo
//
//  Created by Liu Jinyu on 9/11/16.
//  Copyright © 2016 Liu Jinyu. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var brightnessStepper: UIStepper!
    
    @IBOutlet weak var redSlidder: UISlider!
    @IBOutlet weak var blueSlidder: UISlider!
    @IBOutlet weak var greenSlidder: UISlider!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    @IBAction func textFieldTapped(_ sender: Any) {
        
        buttonBottomConstraint.constant = 400 
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func briStepperValueChanged(_ sender: UIStepper) {
        
        let value: Int = Int(sender.value)
        
        Alamofire.request(Router.PUTBri(value)).responseJSON{ response in
            
            print("Success: \(response.result.isSuccess)")
            print(response.result.value)
        }
    }
    
    @IBAction func redSlidderValueChanged(_ sender: UISlider) {
        
        let hue = convertRGFTOXY()
        
        Alamofire.request(Router.PUTHue(hue)).responseJSON{ response in
            
            print("Success: \(response.result.isSuccess)")
            print(response.result.value)
        }
    }
    
    
    @IBAction func blueSlidderValueChanged(_ sender: Any) {
        
        let hue = convertRGFTOXY()
        
        Alamofire.request(Router.PUTHue(hue)).responseJSON{ response in
            
            print("Success: \(response.result.isSuccess)")
            print(response.result.value)
        }
    }
    
    @IBAction func greenSlidderValueChanged(_ sender: UISlider) {
        
        let hue = convertRGFTOXY()
        
        Alamofire.request(Router.PUTHue(hue)).responseJSON{ response in
            
            print("Success: \(response.result.isSuccess)")
            print(response.result.value)
        }
    }
    
    @IBAction func btnRandomItPressed(_ sender: UIButton) {

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.updateRandomIt()
        }

    }
    
    @IBAction func btnBlinkPressed(_ sender: Any) {
        
       
    }
    
    func spotifyIt(){
        
    }
    
    
    func updateRandomIt(){

        let randomRed = arc4random_uniform(255)
        let randomBlue = arc4random_uniform(255)
        let randomGreen = arc4random_uniform(255)
            
            DispatchQueue.main.async {
                self.view.backgroundColor = UIColor(red: CGFloat(randomRed)/255.0, green: CGFloat(randomGreen)/255.0, blue: CGFloat(randomBlue)/255.0, alpha: 1)
            }
            
            let randomBri = Int(arc4random_uniform(254))
            
            self.redSlidder.value = Float(randomRed)
            self.blueSlidder.value = Float(randomBlue)
            self.greenSlidder.value = Float(randomGreen)
            
            let hue = self.convertRGFTOXY()
            
            Alamofire.request(Router.PutHueBri(hue, randomBri)).responseJSON{ response in
                
                print("Success: \(response.result.isSuccess)")
                print(response.result.value)
            }
        
    }
    
    
    func convertRGFTOXY() -> [Double] {
        
        let red: CGFloat = CGFloat(redSlidder.value)
        let green: CGFloat = CGFloat(greenSlidder.value)
        let blue: CGFloat = CGFloat(blueSlidder.value)
        
        DispatchQueue.main.async {
             self.view.backgroundColor = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
        }
        
        var redCal = (red > 0.04045) ? pow((red + 0.055) / (1.0 + 0.055), 2.4) : (red / 12.92)
        var greenCal = (green > 0.04045) ? pow((green + 0.055) / (1.0 + 0.055), 2.4) : (green / 12.92)
        var blueCal = (blue > 0.04045) ? pow((blue + 0.055) / (1.0 + 0.055), 2.4) : (blue / 12.9)
        
        var X = redCal * 0.664511 + greenCal * 0.154324 + blueCal * 0.162028
        var Y = redCal * 0.283881 + greenCal * 0.668433 + blueCal * 0.047685
        var Z = redCal * 0.000088 + greenCal * 0.072310 + blueCal * 0.986039
        
        var x = X / (X + Y + Z)
        var y = Y / (X + Y + Z)
        
        return [Double(x),Double(y)]
    }
    
    
}

