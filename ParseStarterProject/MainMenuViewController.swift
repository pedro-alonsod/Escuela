//
//  MainMenuViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Alonso on 29/10/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var titleMenuLabel: UILabel!
    let calificacionesSegue = "CalificacionesSegue"
    let tareasSegue = "TareasSegue"
    let avisosSegue = "AvisosSegue"
    let privadosSegue = "PrivadosSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func calificacionesTapped(sender: UIButton) {
    
        self.performSegueWithIdentifier(calificacionesSegue, sender: self)
    
    }
    
    @IBAction func tareasTapped(sender: UIButton) {
   
        self.performSegueWithIdentifier(tareasSegue, sender: self)
    
    }
    
    @IBAction func avisosTapped(sender: UIButton) {
    
        self.performSegueWithIdentifier(avisosSegue, sender: self)
        
    
    }
    
    @IBAction func privadosTapped(sender: UIButton) {
  
        self.performSegueWithIdentifier(privadosSegue, sender: self)
    }
    
    @IBAction func salirTapped(sender: UIButton) {
    
    }
    
}
