/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var savePasswordSwitc: UISwitch!

    let mainMenuSegue = "MainMenuSegue"
    let changePasswordSegue = "ChangePasswordSegue"
    
    var papa: PFUser!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if let user = PFUser.currentUser()?.username {
//            
//            self.performSegueWithIdentifier(mainMenuSegue, sender: self)
//            
//        } else {
//            
//            print("not ready to jump")
//        }
//        
        if let savedName = defaults.stringForKey("username") {
            
            usernameText.text = savedName
        }
        
        if let savedPassword = defaults.stringForKey("password") {
            
            passwordText.text = savedPassword
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func entrarTapped(sender: UIButton) {
        
        print("\(usernameText.text!) \(passwordText.text!)")
        
        if usernameText.text! != "" || passwordText.text! != "" {
            
            
            if passwordText.text! == "098" {
                
                print("el pass es \(passwordText.text!)")
                
                displayError("Error", message: "No puedes accesar con la contraseña por defecto.")
                
            } else {
                
                print("campos ok")
                
                if savePasswordSwitc.on {
                    
                    defaults.setObject(usernameText.text!, forKey: "username")
                    defaults.setObject(passwordText.text!, forKey: "password")
                }
                
                do {
                    
                    papa = try PFUser.logInWithUsername(usernameText.text!, password: passwordText.text!)
                
                } catch let error {
                    
                    print(error)
                    
                }
                //displayError("Ok", message: "Entrando")
                
//                PFUser.logInWithUsernameInBackground(usernameText.text!, password: passwordText.text!) {
//                    (usuario: PFUser?, error: NSError?) -> Void in
//                    
//                    if error == nil {
//                        
//                        self.papa = usuario
//                        
//                        let role: PFObject = self.papa!["role"] as! PFObject
//                        
//                        if role.objectId == "dSK2DNKOkX" {
//                            
//                            print("role ok let them walk tru fire")
//                            self.performSegueWithIdentifier(self.mainMenuSegue, sender: self)
//                            
//                        
//                    } else {
//                        print(error)
//                    }
//                }
//            }
//                
                if papa != nil {
                    
                    print("we are cooking dope \(papa!)")
                    
                    let role: PFObject = papa!["role"] as! PFObject
                    
                    if role.objectId == "dSK2DNKOkX" {
                        
                        print("role ok let them walk tru fire")
                        self.performSegueWithIdentifier(mainMenuSegue, sender: self)
                    } else {
                        
                        print("role not ok")
                        displayError("Error", message: "Solo los papas pueden usar esta aplicacion")
                        PFUser.logOut()
                    }
                
                } else {
                    
                    displayError("Error", message: "No estas dado de alta.")
                }
                
            }
            
            
        } else {
            
            displayError("Error", message: "Los campos no deben estar vacios.")
            
            
        }
        
        
        //self.performSegueWithIdentifier(mainMenuSegue, sender: self)
        
    
    }
    
    @IBAction func cambiarTapped(sender: UIButton) {
    
        if usernameText.text! != "" && passwordText.text! == "098"{
        
            self.performSegueWithIdentifier(changePasswordSegue, sender: self)
            
        } else {
            
            displayError("Error", message: "Necesitas poner el usuario al que le quieres cambiar la contraseña, si no lo has hecho ya, y la contraseña por defecto.")
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        textField.resignFirstResponder()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    @IBAction func unwindSegueHere(segue: UIStoryboardSegue) {
        
        print("unwinding")
        let changePassVC = segue.sourceViewController as! ChangePasswordViewController
        
        if changePassVC.passToSend != nil {
        
            passwordText.text! = changePassVC.passToSend
        } else {
            
            passwordText.text! = ""
            displayError("Alerta", message: "El password no se modifico.")
        }
        
        
    }
    
    func displayError(error: String, message: String) {
        
        let alert: UIAlertController = UIAlertController(title: error, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { alert in
            
            //self.dismissViewControllerAnimated(true, completion: nil)
            })
        presentViewController(alert, animated: true, completion: nil)
    
    }
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == changePasswordSegue {
            
            return true
            
        }
        
        if papa != nil && identifier == mainMenuSegue {
            
            print("logged in")
            
            return true
        } else {
            
            print("not logged in")
            
            return false
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == changePasswordSegue {
            
            let changePasswordVC = segue.destinationViewController as! ChangePasswordViewController
            
            changePasswordVC.userToChange = usernameText.text!
            
            
        } else if segue.identifier == mainMenuSegue {
            
            let topNavigation = segue.destinationViewController as! UINavigationController
            let mainMenuVC = topNavigation.topViewController as! MainMenuViewController
            
            if papa != nil {
            
                mainMenuVC.papa = papa!
                
            } else {
            
                mainMenuVC.papa = PFUser.currentUser()
                
            }
            
        }
    }
}
