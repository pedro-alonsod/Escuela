//
//  MainMenuViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Alonso on 29/10/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class MainMenuViewController: UIViewController {

    @IBOutlet weak var titleMenuLabel: UILabel!
    let calificacionesSegue = "CalificacionesSegue"
    let tareasSegue = "TareasSegue"
    let avisosSegue = "AvisosSegue"
    let privadosSegue = "PrivadosSegue"
    
    var papa: PFUser!
    
    var hijos: [PFObject]!
    
    var calificacionesArray: [String : PFObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleMenuLabel.text = "Bienvenido \(papa.username!)"
        
        getCalificaciones()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    //

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
        
        PFUser.logOut()
    
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getCalificaciones() {
        
        if papa != nil {
            
            var hijosTry: [PFObject] = []
            let queryHijos = PFQuery(className: "PapaList")
            queryHijos.whereKey("papa", equalTo: papa)
            
            do {
            
                hijosTry = try queryHijos.findObjects()
            } catch let error {
                
                print("\(error)")
            }
            
            if hijosTry.count > 0 {
                let hijosArrayIndex = "hijos"
                print("tienes \(hijosTry.count) hijos")
                print("\(hijosTry[0][hijosArrayIndex])")
                
                for alumno in hijosTry[0][hijosArrayIndex] as! [PFObject] {
                    
                    
                    print("testeando \(alumno.debugDescription)")
                    
                    let queryCalificacionesHijo: PFQuery = PFQuery(className: "Calificaciones")
                    queryCalificacionesHijo.whereKey("alumnoId", equalTo: alumno)
                    var calificacionesInter: [PFObject]!
                    
                    do {
                    
                        calificacionesInter = try queryCalificacionesHijo.findObjects()
                        
                    } catch let error {
                        
                        print("hubo este error obteniendo las calificacionesInter \(error)")
                    }
                    
                    if calificacionesInter.count > 0 {
                        
                        print("is working \(calificacionesInter.count)")
                        let valor = "valor", mensaje = "Mensaje"
                        print("we have this grade \(calificacionesInter[0][valor]) with this Mensaje \(calificacionesInter[0][mensaje])")
                    }
                    
                }
                
                
                
                
            } else {
                
                displayError("Error", message: "No tienes hijos asignados en la aplicacion comunicate con el encargado.")
            }
        
            
        } else {
            
            displayError("Error", message: "Algo inesperado ha pasado, reinicia la aplicacion.")
            
        }
        
    }
    
    func displayError(error: String, message: String) {
        
        let alert: UIAlertController = UIAlertController(title: error, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { alert in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            })
        presentViewController(alert, animated: true, completion: nil)
        
    }
}
