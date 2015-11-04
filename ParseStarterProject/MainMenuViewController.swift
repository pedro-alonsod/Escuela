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
    var alumnosPapa: [PFObject] = []
    
    var nombres: [String] = []
    var alumnosObjetosId: [String] = []
    
    var calificacionesArray: [PFObject] = []
    var tareasDictionaryAlumno: [PFObject] = []
    var privadosDictionaryAlumno: [PFObject] = []
    var avisosDictionaryAlumno: [PFObject] = []
    
    var nombresArray: [String] = []
    
    
    @IBOutlet weak var calificacionesNumeroLabel: UILabel!
    @IBOutlet weak var tareasNumeroLabel: UILabel!
    @IBOutlet weak var avisosNumeroLabel: UILabel!
    @IBOutlet weak var privadosNumeroLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        let qos_user_class = QOS_CLASS_USER_INITIATED
        
        dispatch_async(dispatch_get_global_queue(qos_user_class, 0)) { [unowned self] in
            
            //this goes on and on in the backgorund I mey need it when queries are damn bad it took until "role ok" to run
            for var i = 0; i < 10; i++ {
                
                print(i)
            }
            
            
        }
        
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            //DO some work here
            //...
            self.displayError("Alerta", message: "Los datos se estan cargando.")
            dispatch_async(dispatch_get_main_queue()) {
                
                //update ui
                //Less obvious the getObjects methods time maintaining the current work it shows a alertview in a new thread
                //self.displayError("ALerta", message: "Los datos se estan cargando.")
            }
            
        }
        // Do any additional setup after loading the view.
        
        titleMenuLabel.text = "Bienvenido \(papa.username!)"
        
        //getCalificaciones()
        
        findAlumnos()
        
        if nombres.count > 0 {
        
            getCalificaciones()
            getTareas()
            
            //displayError("Alerta", message: "Esta cargando la informacion por favor espera.")
            getPrivados()
            getAvisos()
            
            calificacionesNumeroLabel.text = (calificacionesArray.count > 0) ? "\(calificacionesArray.count)":"0"
            
            tareasNumeroLabel.text = (tareasDictionaryAlumno.count > 0) ? "\(tareasDictionaryAlumno.count)":"0"
            
            avisosNumeroLabel.text = (avisosDictionaryAlumno.count > 0) ? "\(avisosDictionaryAlumno.count)":"0"
            
            privadosNumeroLabel.text = (privadosDictionaryAlumno.count > 0) ? "\(privadosDictionaryAlumno.count)":"0"
            
            
            
        } else {
            
            displayError("Error", message: "Hay un problema con tus alumnos asignados.")
        }
        
        
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
        
        if segue.identifier == calificacionesSegue {
            
            let calificacionesVC = segue.destinationViewController as! CalificacionesTableViewController
            
            if calificacionesArray.count > 0 {
                
                calificacionesVC.calificacionesAlumno = calificacionesArray
            } else {
                
                calificacionesVC.calificacionesAlumno = []
                displayError("Error", message: "No fue posible obtener las calificacines.")
            }
        } else if segue.identifier == tareasSegue {
            
            let tareasVC = segue.destinationViewController as! TareasTableViewController
            
            if tareasDictionaryAlumno.count > 0 {
                
                tareasVC.tareasAlumno = tareasDictionaryAlumno
                
            } else {
                
                tareasVC.tareasAlumno = []
                
            }
        } else if segue.identifier == avisosSegue {
            
            let avisosVC = segue.destinationViewController as! AvisosTableViewController
            
            if avisosDictionaryAlumno.count > 0 {
                
                avisosVC.avisosAlumno = avisosDictionaryAlumno
                
                
            } else {
                
                avisosVC.avisosAlumno = []
                
            }
        } else if segue.identifier == privadosSegue {
            
            let privadosVC = segue.destinationViewController as! PrivadosTableViewController
            
            if privadosDictionaryAlumno.count > 0 {
                
                privadosVC.privadosAlumno = privadosDictionaryAlumno
            } else {
                
                privadosVC.privadosAlumno = []
            }
        }
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
        
        
        if self.alumnosPapa.count > 0 {
            
            
            for alumnoId in self.alumnosPapa {
                
                let queryCalificacionesAlumno = PFQuery(className: "Calificaciones")
                print(" alumnoactual \(alumnoId)")
                
                queryCalificacionesAlumno.whereKey("alumnoId", equalTo: alumnoId)
                queryCalificacionesAlumno.includeKey("tareasId")
                queryCalificacionesAlumno.includeKey("alumnoId")
                queryCalificacionesAlumno.limit = 20
                
                do {
                    
                    let calif = try queryCalificacionesAlumno.findObjects()
                    
                    print("got it")
                    print(calif)
                    print(alumnoId["nombre"])
                    
                    let nombreAlumno = alumnoId["nombre"] as! String
                
                    print(nombreAlumno)
                    
                    calificacionesArray = calif
                    
                } catch let error {
                    print(error)
                }
            }
            
            
        }
            
            
        
        
        
            
    }
    
    func getTareas() {
        
        
        if self.alumnosPapa.count > 0 {
            
            for alumnoId in alumnosPapa {
                
                let queryTareasAlumno = PFQuery(className: "Tareas")
                
                print("este alumno \(alumnoId)")
                
                queryTareasAlumno.whereKey("alumnoId", equalTo: alumnoId)
                queryTareasAlumno.includeKey("alumnoId")
            
                queryTareasAlumno.limit = 20
                
                do {
                    
                    let tareas = try queryTareasAlumno.findObjects()
                    
                    print(tareas)
                    print(alumnoId["nombre"])
                    
                    let nombreAlumno = alumnoId["nombre"] as! String
                    
                    print(nombreAlumno)
                    
                    tareasDictionaryAlumno = tareas
                    
                    
                } catch let error {
                    
                    print(error)
                }
            }
        }
    }
    
    func getPrivados() {
        
    
        if self.alumnosPapa.count > 0 {
            
            for alumnoId in alumnosPapa {
                
                
                let queryPrivados = PFQuery(className: "AvisosPrivados")
                
                print("estos privados son de \(alumnoId)")
                
                queryPrivados.whereKey("alumnoId", equalTo: alumnoId)
                queryPrivados.includeKey("maestroId")
                queryPrivados.includeKey("alumnoId")
                queryPrivados.limit = 20
                
                do {
                    
                    let privados = try queryPrivados.findObjects()
                    
                    print(privados)
                    print(alumnoId["nombre"])
                    
                    let nombreAlumno = alumnoId["nombre"] as! String
                    
                    print(nombreAlumno)
                    
                    privadosDictionaryAlumno = privados
                    
                    
                    
                } catch let error {
                    
                    print(error)
                }
            }
            
        }
        
    }
    
    func getAvisos() {
        
        if self.alumnosPapa.count > 0 {
            
            
            print("Estos avisos son para los grupos")
            
            
            for alumnoInGrupo in alumnosPapa {
            
                let queryGrupos = PFQuery(className: "Alumnos")
                print(alumnoInGrupo.objectId!)
                queryGrupos.whereKey("objectId", equalTo: alumnoInGrupo.objectId!)
                
                queryGrupos.includeKey("grupoId")
                
                do {
                    
                    let grupoObject = try queryGrupos.getFirstObject()
                    print(grupoObject["grupoId"]! as! PFObject)
                    let grupoAlumno = grupoObject["grupoId"]! as! PFObject
                    print("this is the object to use \(grupoAlumno)")
                    
                    
                    let queryAvisoAlumno = PFQuery(className: "Avisos")
                    
                    queryAvisoAlumno.whereKey("grupoId", equalTo: grupoAlumno)
                    queryAvisoAlumno.includeKey("alumnoId")
                    queryAvisoAlumno.includeKey("maestroId")
                    queryAvisoAlumno.limit = 20
                    
                    do {
                        
                        let avisos = try queryAvisoAlumno.findObjects()
                        
                        print(avisos)
                        
                        if avisos.count > 0 {
                        
                            let nombreAlumno = alumnoInGrupo["nombre"]! as! String
                            print(nombreAlumno)
                            
                            avisosDictionaryAlumno = avisos
                            
                        } else {
                            
                            displayError("Advertencia", message: "No tienes ningun aviso por el momento.")
                        }
                        
                    } catch let error {
                        
                        print(error)
                        
                    }
                    
                    print("stop")
                    
                } catch let error {
                 
                    print(error)
                    
                }
                
            }
        }
    }
    
    
    func displayError(error: String, message: String) {
        
        let alert: UIAlertController = UIAlertController(title: error, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { alert in
            
            //self.dismissViewControllerAnimated(true, completion: nil)
            })
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func findAlumnos() {
        
        if papa == PFUser.currentUser()! {
            
            let queryHijos = PFQuery(className: "PapaList")
            queryHijos.whereKey("papa", equalTo: papa)
            queryHijos.includeKey("hijos")
            print("papa = \(papa)")
            do {
                
                hijos = try queryHijos.findObjects()
                
                let hijosIdx = "hijos"
                let nombre = "nombre"
                let objectId = "objectId"
                
                let hijoOne = hijos[0][hijosIdx]
                print("\(hijos[0].valueForKey(hijosIdx)?.valueForKey(nombre)!)")
                print("primer hijo \(hijoOne)")
                
                for alumno in hijos {
                    
                    print("\(alumno.valueForKey(hijosIdx)![0] as! PFObject)")
                    
                    
                    let objectAlumno = alumno.valueForKey(hijosIdx)![0] as! PFObject
                    
                    alumnosPapa.append(objectAlumno)
                    
                    print(self.alumnosPapa)
                    
                    
                    print("\(alumno.valueForKey(hijosIdx)!.valueForKey(nombre)![0] as! String)")
                    print("\(alumno.valueForKey(hijosIdx)!.valueForKey(objectId)![0] as! String)")
                    
                    let nombreAlumno = alumno.valueForKey(hijosIdx)!.valueForKey(nombre)![0] as! String
                    let objectAlumnoId = alumno.valueForKey(hijosIdx)!.valueForKey(objectId)![0] as! String
                    
                    print("\(nombreAlumno) \(objectAlumnoId)")
                    
                    self.nombres.append(nombreAlumno)
                    self.alumnosObjetosId.append(objectAlumnoId)
                    
                    print("test \(nombres) \(alumnosObjetosId)")
                    
                    
                }
                
            } catch let error {
                
                print(error)
                
                displayError("Error", message: "No tienes hijos en el sistema aun.")
                
            }
            
        }
    }

}


