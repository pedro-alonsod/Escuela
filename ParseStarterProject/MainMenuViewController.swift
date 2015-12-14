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
    let tabBarSegue = "TabBarSegue"
    let tabBarTareas = "TabBarTareasSegue"
    let tabBarCalificaciones = "TabBarCalificacionesSegue"
    let tabBarCalificacionesTareas = "TabBarCalificacionesTareasSegue"
    let tabBarAvisosSegue = "TabBarAvisosSegue"
    
    @IBOutlet weak var infoSchoolLabel: UILabel!
    @IBOutlet weak var salirButton: UIButton!
    @IBOutlet weak var calificacionesButton: UIButton!
    @IBOutlet weak var tareasButton: UIButton!
    @IBOutlet weak var avisosButton: UIButton!
    @IBOutlet weak var privadosButtton: UIButton!
    @IBOutlet weak var logoEnView: UIImageView!
    
    
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
    
    var item = 0
    
    
    @IBOutlet weak var calificacionesNumeroLabel: UILabel!
    @IBOutlet weak var tareasNumeroLabel: UILabel!
    @IBOutlet weak var avisosNumeroLabel: UILabel!
    @IBOutlet weak var privadosNumeroLabel: UILabel!
    @IBOutlet weak var schoolLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //salirButton.backgroundColor = UIColor.clearColor()
        salirButton.layer.cornerRadius = 5
        salirButton.layer.borderWidth = 1
        salirButton.layer.borderColor = UIColor.clearColor().CGColor

        
        
        
        //tareasButton.backgroundColor = UIColor.clearColor()
        tareasButton.layer.cornerRadius = 5
        tareasButton.layer.borderWidth = 1
        tareasButton.layer.borderColor = UIColor.clearColor().CGColor

        
        //avisosButton.backgroundColor = UIColor.clearColor()
        avisosButton.layer.cornerRadius = 5
        avisosButton.layer.borderWidth = 1
        avisosButton.layer.borderColor = UIColor.clearColor().CGColor

        
        
        
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        let qos_user_class = QOS_CLASS_USER_INITIATED
        
        dispatch_async(dispatch_get_global_queue(qos_user_class, 0)) { [unowned self] in
            
            //this goes on and on in the backgorund I may need it when queries are damn bad it took until "role ok" to run
            for var i = 0; i < 10; i++ {
                
                print(i)
            }
            
            //to go back to the main queue outside this maybe queues QOS_CLASS_USER_INTERACTIVE, QOS_CLASS_UTILITY or QOS_CLASS_BACKGROUND.
//            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
//                self.tableView.reloadData()
//            }
            
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
        
        if let test = PFUser.currentUser() {
            
            print("a Pop \(test.username!)")
            
            self.papa = test
            
            
        } else {
            
            displayError("Error!", message: "Ha habido un error, por favor sal y vuelve a entrar a la aplicacion.")
        }
        
    
        
        PFConfig.getConfigInBackgroundWithBlock {
            
            (config: PFConfig?, error: NSError?) -> Void in
            
            if error == nil {
                
                let ciclo = config!["Ciclo"]
                //let mensaje = config!["Mensaje"]
                //let fechaFin = config!["FechaFin"]
                let descripcion = config!["Descripcion"]
                let nombre = config!["Nombre"]
                
                print("\(ciclo!):  \n \(descripcion!)")
                
                self.infoSchoolLabel.text = "Al ciclo: \(ciclo!) en la escuela \(nombre!) \n \(descripcion!)."
                
                let schoolImage = config!["Logotipo"] as! PFFile
                
                schoolImage.getDataInBackgroundWithBlock {
                    
                    (imageData: NSData?, error: NSError?) -> Void in
                    
                    if error == nil {
                        
                        if let image = imageData {
                            
                            let imgData = UIImage(data: image)
                            
                            //self.schoolLogo.image = imgData
                            
                            let imageView = UIImageView(image: imgData)
                            
                            self.navigationItem.titleView = imageView
                            
                            print("got something")
                            
                        }
                    } else {
                        
                        print("\(error?.description)")
                    }
                }
                
            } else {
                
                self.displayError("Error", message: "Ha habido un problema al obtener la configuracion.")
            }
        }
        
        //titleMenuLabel.text = "Bienvenido \(papa.username!)"
        titleMenuLabel.text = "Bienvenido \(PFUser.currentUser()!.username!)"
        //getCalificaciones()
        
        findAlumnos()
        
        if nombres.count > 0 {
        
            getCalificaciones()
            getTareas()
            
            //displayError("Alerta", message: "Esta cargando la informacion por favor espera.")
            getPrivados()
            getAvisos()
            
            //config escuela
            getConfigSchool()
            
            //calificacionesNumeroLabel.text = (calificacionesArray.count > 0) ? "\(calificacionesArray.count)":"0"
            
//            tareasNumeroLabel.text = (tareasDictionaryAlumno.count > 0) ? "\(tareasDictionaryAlumno.count + calificacionesArray.count)":"0"
//            
//            avisosNumeroLabel.text = (avisosDictionaryAlumno.count > 0) ? "\(avisosDictionaryAlumno.count + privadosDictionaryAlumno.count)":"0"
//            
            //privadosNumeroLabel.text = (privadosDictionaryAlumno.count > 0) ? "\(privadosDictionaryAlumno.count)":"0"
            
            
            
        } else {
            
            displayError("Error", message: "Hay un problema con tus alumnos asignados.")
        }
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        tareasNumeroLabel.text = ((tareasDictionaryAlumno.count + calificacionesArray.count) > 0) ? "\((tareasDictionaryAlumno.count + calificacionesArray.count))":"0"
        print(" numero de calificaciones y tareas aki \((tareasDictionaryAlumno.count + calificacionesArray.count))")
        
        avisosNumeroLabel.text = (avisosDictionaryAlumno.count > 0) ? "\(avisosDictionaryAlumno.count + privadosDictionaryAlumno.count)":"0"
        
        
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
        } else if segue.identifier == tabBarSegue {
            
            
        } else if segue.identifier == tabBarCalificacionesTareas {
            
            //look how to set the view to tareastabbar
            
            let tabBarTareasVC = segue.destinationViewController as! TabBarCalificacionesTareasViewController
            
            tabBarTareasVC.selectedIndex = 1
            
            tabBarTareasVC.selectedItem = 1
            
            print("number sent \(item)")
            
            let tabBarVC = tabBarTareasVC.viewControllers![1] as! TareasViewController
            
            
            if tareasDictionaryAlumno.count > 0 {
                
                tabBarVC.tareasAlumno = tareasDictionaryAlumno
                tabBarVC.alumnosData = alumnosPapa
                tabBarVC.calificacionesAlumnos = calificacionesArray
                
            } else {
                
                tabBarVC.tareasAlumno = []
                
            }
            
            
        
            let tabBarVCSecond = tabBarTareasVC.viewControllers![0] as! CalificacionesViewController
            
            if calificacionesArray.count > 0 {
                
                tabBarVCSecond.calificacionesAlumno = calificacionesArray
                
                
            } else {
                
                tabBarVCSecond.calificacionesAlumno = []
                
                
            }
            
        } else if segue.identifier == tabBarAvisosSegue {
            
            let tabBarAvisosVC = segue.destinationViewController as! TabBarAvisosViewController
            
            
            tabBarAvisosVC.selectedItem = item
            
            print("Avisos number sent \(item)")
            
            let tabBarAvisosFirst = tabBarAvisosVC.viewControllers![0] as! TabBarAvisosTableViewController
            
            if avisosDictionaryAlumno.count > 0 {
            
                tabBarAvisosFirst.avisosAlumno = avisosDictionaryAlumno
            } else {
                
                tabBarAvisosFirst.avisosAlumno = []
                
            }
            
            let tabBarPrivadosSecond = tabBarAvisosVC.viewControllers![1] as! TabBarPrivadosTableViewController
            
            if privadosDictionaryAlumno.count > 0 {
                
                tabBarPrivadosSecond.privadosAlumno = privadosDictionaryAlumno
                
            } else {
                
                tabBarPrivadosSecond.privadosAlumno = []
                
         
            }
            
            tabBarAvisosVC.selectedIndex = 0
            
            
            
        }
        
    }
    

    //

    @IBAction func calificacionesTapped(sender: UIButton) {
        
        item = 0

    
        self.performSegueWithIdentifier(tabBarCalificacionesTareas, sender: self)
    
    }
    
    @IBAction func tareasTapped(sender: UIButton) {
        
        item = 1
   
        self.performSegueWithIdentifier(tabBarCalificacionesTareas, sender: self)
    
    }
    
    @IBAction func avisosTapped(sender: UIButton) {
        
        item = 0
    
        self.performSegueWithIdentifier(tabBarAvisosSegue, sender: self)
        
    
    }
    
    @IBAction func privadosTapped(sender: UIButton) {
        
        item = 1
  
        self.performSegueWithIdentifier(tabBarAvisosSegue, sender: self)
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
                    print(" el num de calificaciones \(calif.count)")
                    print(alumnoId["nombre"])
                    
                    let nombreAlumno = alumnoId["nombre"] as! String
                
                    print(nombreAlumno)
                    
                    for clf in calif {
                        
                        print(clf)
                        
                        calificacionesArray.append(clf)
                        
                    }
                    
                    //calificacionesArray = calif
                    
                } catch let error {
                    print(error)
                }
            }
            
            
        }
            
            
        
        
        
            
    }
    
    func getTareas() {
        
        
        if self.alumnosPapa.count > 0 {
            
            print(alumnosPapa)
            
            for alumnoInGrupo in alumnosPapa {
                
                let queryGrupos = PFQuery(className: "Alumnos")
                
                print("este alumno \(alumnoInGrupo.objectId!)")
                
                queryGrupos.whereKey("objectId", equalTo: alumnoInGrupo.objectId!)
                queryGrupos.includeKey("grupoId")
                
                
                
                do {
                    
                    let grupoObject = try queryGrupos.getFirstObject()
                    
                    print(grupoObject["grupoId"]! as! PFObject)
                    
                    let grupoAlumno = grupoObject["grupoId"]! as! PFObject
                    
                    print("this is the grupo of the student \(grupoAlumno) of \(alumnoInGrupo)")
   
                    let queryTareasAlumno = PFQuery(className: "Tareas")
                    
                    queryTareasAlumno.whereKey("grupoId", equalTo: grupoAlumno)
                    queryTareasAlumno.includeKey("maestroId")
                    queryTareasAlumno.includeKey("grupoId")
                    //queryTareasAlumno.includeKey("alumnoId")
                    queryTareasAlumno.orderByDescending("fechaEntrega")
                    queryTareasAlumno.limit = 50
                    
                    do {
                        
                        let tareas = try queryTareasAlumno.findObjects()
                        
                        print("el numero de tareas es \(tareas.count)")
                        
                        if tareas.count > 0 {
                            
                            let nombreAlumno = alumnoInGrupo["nombre"]! as! String
                            
                            print(nombreAlumno)
                            
                            for trs in tareas {
                                
                                tareasDictionaryAlumno.append(trs)
                            }
                        }
                    } catch let errorInner {
                        
                        print(errorInner)
                        
                    }
                
                    
                    
                    
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
                queryPrivados.orderByDescending("createdAt")
                queryPrivados.limit = 20
                
                do {
                    
                    let privados = try queryPrivados.findObjects()
                    
                    print(privados)
                    print(alumnoId["nombre"])
                    
                    let nombreAlumno = alumnoId["nombre"] as! String
                    
                    print(nombreAlumno)
                    
                    for prv in privados {
                        
                        privadosDictionaryAlumno.append(prv)
                    }
                    
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
                    queryAvisoAlumno.orderByDescending("createdAt")
                    queryAvisoAlumno.limit = 20
                    
                    do {
                        
                        let avisos = try queryAvisoAlumno.findObjects()
                        
                        print(avisos)
                        
                        if avisos.count > 0 {
                        
                            let nombreAlumno = alumnoInGrupo["nombre"]! as! String
                            print(nombreAlumno)
                            
                            for avs in avisos {
                                
                                avisosDictionaryAlumno.append(avs)
                            }
                            
                            //avisosDictionaryAlumno = avisos
                            
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
        
        print(PFUser.currentUser()?.username!)
        
        if papa == PFUser.currentUser()! {
            
            let queryHijos = PFQuery(className: "PapaList")
            queryHijos.whereKey("papa", equalTo: papa)
            queryHijos.includeKey("hijos")
            print("papa = \(papa)")
            do {
                
                hijos = try queryHijos.findObjects()
                print(hijos)
                
                let hijosIdx = "hijos"
                let nombre = "nombre"
                let objectId = "objectId"
                
                print("conteo de objetos \(hijos.count)")
                
                let hijoOne = hijos[0][hijosIdx]
                print("\(hijos[0].valueForKey(hijosIdx)?.valueForKey(nombre)!)")
                print("primer hijo \(hijoOne)")
                
                print("lista de alumnos \(hijos[0].valueForKey(hijosIdx)!)")
                
                let alumnosList: [PFObject] = hijos[0].valueForKey(hijosIdx)! as! [PFObject]
                
                print("alumnos list has \(alumnosList.count)")
                
                for alumno in alumnosList {
                    
                    print("\(alumno.valueForKey(nombre)!)")
                    
                    
                    let objectAlumno = alumno
                    
                    alumnosPapa.append(objectAlumno)
                    
                    print(self.alumnosPapa)
                    
                    print("printing one alumno")
                    
                    print("\(alumno.valueForKey(nombre)! as! String)")
                    print("\(alumno.valueForKey(nombre)! as! String)")
                    
                    let nombreAlumno = alumno.valueForKey(nombre)! as! String
                    let objectAlumnoId = alumno.valueForKey(objectId)! as! String
                    
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
    
    func getConfigSchool() {
        
        if papa == PFUser.currentUser()! {
            
            
            let queryConfig = PFQuery(className: "Config")
            
            var nombreEscuela: String!, tipo: String!, ciclo: String!, cicloInicio: String!, cicloFin: String!
            
            
            queryConfig.getFirstObjectInBackgroundWithBlock {
                
                (object: PFObject?, error: NSError?) -> Void in
                
                if error == nil || object != nil {
                    
                    print("object retieved \(object)")
                    // self.infoSchoolLabel.text = (object!["Ciclo"] as! String) + "\n" + (object!["Info"] as! String) + ",  " + (object!["Institucion"] as! String)
                    
                    let displayLogo = object!["display"] as! PFFile
                    
                    displayLogo.getDataInBackgroundWithBlock {
                        
                        (imageData: NSData?, error: NSError?) -> Void in
                        
                        if error == nil {
                            
                            if let image = imageData {
                                
                                let imgData = UIImage(data: image)
                                
                                //self.schoolLogo.image = imgData
                                
                                //let imageView = UIImageView(image: imgData)
                                
                                //self.navigationItem.titleView = imageView
                                
                                self.logoEnView.image = imgData
                                
                                print("got something")
                                
                            }
                        } else {
                            
                            print("\(error?.description)")
                        }
                    }
                    
                } else {
                    
                    print("error somewhere \(error)")
                }
            }
            
        }
    }
    
    
    func getConfigTable() {
        
        
        if papa == PFUser.currentUser() {
            
            
        }
    }
    
    

}


