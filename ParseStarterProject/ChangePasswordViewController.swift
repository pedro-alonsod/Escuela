//
//  ChangePasswordViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Alonso on 29/10/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameBlockedText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var passwordNewText: UITextField!
    @IBOutlet weak var listoButton: UIButton!
    @IBOutlet weak var cancelarButton: UIButton!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    let mainSegue = "MainSegue"
    var passToSend: String!
    
    var userToChange: String!
    
    var papa: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        usernameBlockedText.text! = userToChange
        
        loadingActivity.hidden = true
        
        
        //listoButton.backgroundColor = UIColor.blueColor()
        listoButton.layer.cornerRadius = 5
        listoButton.layer.borderWidth = 1
        listoButton.layer.borderColor = UIColor.clearColor().CGColor

        //cancelarButton.backgroundColor = UIColor.blueColor()
        cancelarButton.layer.cornerRadius = 5
        cancelarButton.layer.borderWidth = 1
        cancelarButton.layer.borderColor = UIColor.clearColor().CGColor
        
        usernameBlockedText.backgroundColor = UIColor.clearColor()
        usernameBlockedText.layer.cornerRadius = 5
        usernameBlockedText.layer.borderWidth = 3
        usernameBlockedText.layer.borderColor = UIColor.lightGrayColor().CGColor

        emailText.backgroundColor = UIColor.clearColor()
        emailText.layer.cornerRadius = 5
        emailText.layer.borderWidth = 3
        emailText.layer.borderColor = UIColor.lightGrayColor().CGColor

        phoneText.backgroundColor = UIColor.clearColor()
        phoneText.layer.cornerRadius = 5
        phoneText.layer.borderWidth = 3
        phoneText.layer.borderColor = UIColor.lightGrayColor().CGColor

        passwordNewText.backgroundColor = UIColor.clearColor()
        passwordNewText.layer.cornerRadius = 5
        passwordNewText.layer.borderWidth = 3
        passwordNewText.layer.borderColor = UIColor.lightGrayColor().CGColor


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func listoTapped(sender: UIButton) {
  
        if emailText.text! != "" && phoneText.text! != "" && passwordNewText.text! != "" {
            
            //displayError("Ok", message: "Checando")
            print("doing the pass change")
            
            do {
                
                papa = try PFUser.logInWithUsername(usernameBlockedText.text!, password: "098")
            } catch let error {
                
                print(error)
            }
            
            if let tryPapa = papa {
                
                print("\(tryPapa)")
                
                let telefono = "telefono"
                let email = "email"
                
                print("\(tryPapa[telefono]) papa telefono \(tryPapa[email]) papa email")
                
                if tryPapa[telefono] as! String == phoneText.text! && tryPapa[email] as! String == emailText.text! {
                    
                    print("now to save pass")
                    
                    tryPapa.password = passwordNewText.text!
                    
                    do {
                        
                        try tryPapa.save()
                    
                    } catch let error {
                        
                        print(error)
                        
                        displayError("Error", message: "Hubo un error al gruardar la contraseña, por favor intenlo despues.")

                    }
                    
                    print("we done goofed let move out")
                    
                    passToSend = passwordNewText.text!
                 
                    PFUser.logOut()
                    self.performSegueWithIdentifier(mainSegue, sender: self)
                    
                }
//                
//                
//                tryPapa.password! = passwordNewText.text!
//            
//                do {
//                    
//                    var standarE = try tryPapa.save()
//                
//                    print(standarE)
//                    
//                } catch let error {
//                    
//                    print(error)
//                }
//                
            } else {
                
                print("Error with papa is nil")
                
                displayError("Error", message: "Hubo un error en coneccion, por favor intentalo mas tarde.")
            }
            
        } else {
            
            displayError("Error", message: "Todos los campos son necesarios.")
        }
    }
    
    
    @IBAction func cancelarTapped(sender: UIButton) {
    
    
        //self.dismissViewControllerAnimated(true, completion: nil)
        PFUser.logOut()
        self.performSegueWithIdentifier(mainSegue, sender: self)
        //self.shouldPerformSegueWithIdentifier(mainSegue, sender: self)
        //navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        textField.resignFirstResponder()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        return true
    }
    
    func displayError(error: String, message: String) {
        
        let alert: UIAlertController = UIAlertController(title: error, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { alert in
            
            //self.dismissViewControllerAnimated(true, completion: nil)
            })
        presentViewController(alert, animated: true, completion: nil)
        
    }
}
