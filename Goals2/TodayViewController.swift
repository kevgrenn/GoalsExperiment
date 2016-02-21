//
//  TodayViewController.swift
//  Goals2
//
//  Created by kevin grennan on 2/20/16.
//  Copyright © 2016 kevin grennan. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var todayScroll: UIScrollView!
    
    var scrollHeight = CGFloat(100)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.todayScroll.delegate = self
        todayScroll.contentSize.height = scrollHeight
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text != "" {
        textField.userInteractionEnabled = false
        performAction(self.textField.center.y)
        }
            return true
    }
    
    func performAction(textFiledY: CGFloat) {
        let textFields = getTextFieldsInView(self.view)
        let numberOfTextFields = CGFloat(textFields.count * 40)
        let textField = UITextField(frame: CGRectMake(50, numberOfTextFields, 250, 40))
        
        todayScroll.contentSize.height += numberOfTextFields
        if todayScroll.contentSize.height > 600{
            UIView.animateWithDuration(0.4, animations: {
            self.todayScroll.contentOffset.y += 40
            })
            }
        
        textField.placeholder = "Anything else?"
        textField.font = UIFont.systemFontOfSize(18)
        textField.borderStyle = UITextBorderStyle.None
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.keyboardType = UIKeyboardType.Default
        textField.returnKeyType = UIReturnKeyType.Done
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        textField.delegate = self
        let doneButton = UIImageView(frame: CGRectMake(15, numberOfTextFields-30, 20, 20))
        doneButton.image = UIImage(named: "doneButton")!
        self.todayScroll.addSubview(doneButton)
        self.todayScroll.addSubview(textField)
        textField.becomeFirstResponder()
        
        let imageView = UIImageView(frame: CGRectMake(15, numberOfTextFields-30, 20, 20))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")

        imageView.backgroundColor = UIColor(colorLiteralRed: 189/255, green: 244/255, blue: 47/255, alpha: 0.8)
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        self.todayScroll.addSubview(imageView)
        
        imageView.addGestureRecognizer(panGestureRecognizer)
        imageView.userInteractionEnabled = true
    }
    
    func getTextFieldsInView(view: UIView) -> [UITextField] {
        var results = [UITextField]()
        for subview in view.subviews as [UIView] {
            if let textFieldView = subview as? UITextField {
                results += [textFieldView]
            } else {
                results += getTextFieldsInView(subview)
            }
        }
        return results
    }
 
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func onCustomPan(sender: UIPanGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            print("yopo")
        } else if sender.state == UIGestureRecognizerState.Changed {
            print(translation.x)
            if translation.x > 0 {
                imageView.frame.size.width = 20 + translation.x
            } else {
                imageView.frame.size.width = 285 + translation.x

            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0{
                UIView.animateWithDuration(0.4, animations: {
                imageView.frame.size.width = 285
                })
            }else{
                UIView.animateWithDuration(0.4, animations: {
                imageView.frame.size.width = 20
                })
            }
        }
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
