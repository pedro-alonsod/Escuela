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
    
    var calificacionesArray: [String : [PFObject]] = [:]
    var tareasDictionaryAlumno: [String : [PFObject]] = [:]
    var privadosDictionaryAlumno: [String : [PFObject]] = [:]
    var avisosDictionaryAlumno: [String : [PFObject]] = [:]
    
    var nombresArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleMenuLabel.text = "Bienvenido \(papa.username!)"
        
        //getCalificaciones()
        
        findAlumnos()
        
        if nombres.count > 0 {
        
            getCalificaciones()
            getTareas()
            displayError("Alerta", message: "Esta cargando la informacion por favor espera.")
            getPrivados()
            getAvisos()
            
            
            
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
                
                do {
                    
                    let calif = try queryCalificacionesAlumno.findObjects()
                    
                    print("got it")
                    print(calif)
                    print(alumnoId["nombre"])
                    
                    let nombreAlumno = alumnoId["nombre"] as! String
                
                    print(nombreAlumno)
                    
                    calificacionesArray[nombreAlumno] = calif
                    
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
                queryTareasAlumno.includeKey("grupoId")
                
                do {
                    
                    let tareas = try queryTareasAlumno.findObjects()
                    
                    print(tareas)
                    print(alumnoId["nombre"])
                    
                    let nombreAlumno = alumnoId["nombre"] as! String
                    
                    print(nombreAlumno)
                    
                    tareasDictionaryAlumno[nombreAlumno] = tareas
                    
                    
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
                
                do {
                    
                    let privados = try queryPrivados.findObjects()
                    
                    print(privados)
                    print(alumnoId["nombre"])
                    
                    let nombreAlumno = alumnoId["nombre"] as! String
                    
                    print(nombreAlumno)
                    
                    privadosDictionaryAlumno[nombreAlumno] = privados
                    
                    
                    
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
                    queryAvisoAlumno.includeKey("maestroId")
                    
                    do {
                        
                        let avisos = try queryAvisoAlumno.findObjects()
                        
                        print(avisos)
                        
                        if avisos.count > 0 {
                        
                            let nombreAlumno = alumnoInGrupo["nombre"]! as! String
                            print(nombreAlumno)
                            
                            avisosDictionaryAlumno[nombreAlumno] = avisos
                            
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


