//
//  TareasViewController.swift
//  Escuela
//
//  Created by Pedro Alonso on 06/12/15.
//  Copyright © 2015 Pedro. All rights reserved.
//

import UIKit
import Parse

class TareasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tareasTabBarCell = "TareasTabBarCell"
    var tareasAlumno: [PFObject]!
    var alumnosData: [PFObject]!

    
    let formatter = NSDateFormatter()
    
    
    var item: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        print(tareasAlumno[0])
//        
//        tareasAlumno.sortInPlace({ $0.createdAt > $1.createdAt })
//        
//        print(tareasAlumno[0])
//        
        
        

        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        
        print("tareas tab \(tabBarController!.selectedIndex)")
        
        print("tareas item gotten \(item)")
        
        print(" we have # \(tareasAlumno.count)")
        
        print("Tareas object \(tareasAlumno)")
        
        print(tareasAlumno[0])
        
        tareasAlumno.sortInPlace({ $0.createdAt > $1.createdAt })
        
        print(tareasAlumno[0])
        
        print("Los hijos de este papa son \(alumnosData.count)")
                


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        
        return tareasAlumno.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tareasTabBarCell, forIndexPath: indexPath) as! TabBarTareasTableViewCell
        
        // Configure the cell...
        
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        let tareaNombre = "nombre", fechaEntrega = "fechaEntrega", grupoNombre = "nombre", grupoId = "grupoId", materia = "materia", tareaDescripcion = "descripcion"
        
        let dateString = tareasAlumno[indexPath.row][fechaEntrega]! as! NSDate
        
        
        print("La fecha es: \(formatter.stringFromDate(dateString))")
        
        cell.titleLabel.text = "\(tareasAlumno[indexPath.row][tareaNombre]!)"
        cell.materiaLabel.text = "\(tareasAlumno[indexPath.row][materia]!)"
        cell.subtitleLabel.text = "\(tareasAlumno[indexPath.row][grupoId]!.valueForKey(grupoNombre)!)"
        cell.tareaDescripcionLabel.text = "\(tareasAlumno[indexPath.row][tareaDescripcion]!)"
        
        formatter.dateFormat = "dd  MMMM"
        cell.fechaLabel.text = "\(formatter.stringFromDate(dateString))"
        
        let colorOfGrupo = tareasAlumno[indexPath.row][grupoId]!.valueForKey("color") as! String
        
        let rgb = colorOfGrupo.componentsSeparatedByString(",")
        
        let colorForText = UIColor(red: CGFloat(Int(rgb[0])!) / 255.0, green: CGFloat(Int(rgb[1])!) / 255.0, blue: CGFloat(Int(rgb[2])!) / 255.0, alpha: 0.1)
        
        //cell.backgroundColor = UIColor(red: CGFloat(Int(rgb[0])!) / 255.0, green: CGFloat(Int(rgb[1])!) / 255.0, blue: CGFloat(Int(rgb[2])!) / 255.0, alpha: 0.1)
        cell.materiaLabel.backgroundColor = colorForText
        //cell.fechaLabel.textColor = colorForText
        cell.subtitleLabel.backgroundColor = colorForText
        //cell.subtitleLabel.textColor = UIColor(red: CGFloat(Int(rgb[0])!) / 255.0, green: CGFloat(Int(rgb[1])!) / 255.0, blue: CGFloat(Int(rgb[2])!) / 255.0, alpha: 0.1)
        
        
        print("\(CGFloat(Int(rgb[0])!) / 255.0) \(CGFloat(Int(rgb[1])!)) \(CGFloat(Int(rgb[2])!))")
        
        //print(UIColor(red: CGFloat(Int(rgb[0])!), green: CGFloat(Int(rgb[1])!), blue: CGFloat(Int(rgb[2])!), alpha: 1.0))
        
        
        for avatarAlumnos in alumnosData {
            
            if tareasAlumno[indexPath.row][grupoId].objectId == avatarAlumnos[grupoId].objectId {
                
                print("para el renglon \(indexPath.row) este  \(avatarAlumnos[tareaNombre])")
                
                
                let avatar = avatarAlumnos["foto"] as! PFFile
                
                avatar.getDataInBackgroundWithBlock {
                    
                    (imageData: NSData?, error: NSError?) -> Void in
                    
                    if error == nil {
                        
                        if let image = imageData {
                            
                            let imgData = UIImage(data: image)
                            
                            //self.schoolLogo.image = imgData
                            
                            cell.avatarAlumno.image = imgData
                            
//                            let imageView = UIImageView(image: imgData)
                            
//                            self.navigationItem.titleView = imageView
//                            
//                            print("got something")
//                            
                        }
                    } else {
                        
                        print("\(error?.description)")
                    }
                }
                
                
            }
        }
        
//        cell.tareaNombreLabel.text = "\(tareasAlumno[indexPath.row][tareaNombre]!) \(tareasAlumno[indexPath.row][materia]!)"
//        cell.descripcionLabel.text = "Esto es para \(tareasAlumno[indexPath.row][alumnoId]!.valueForKey(alumnoNombre)!)"
//        cell.fechaEntregaLabel.text = "Entregar: \(tareasAlumno[indexPath.row][fechaEntrega]!)  \(tareasAlumno[indexPath.row][codigo]!)"

        //let gbDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "en-GB"))

        
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let rowSelected = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRowAtIndexPath(rowSelected!)! as! TabBarTareasTableViewCell
        
        let mensaje = tareasAlumno[indexPath.row]["tipo"] as! String
        
        let tareaDescripcion = tareasAlumno[indexPath.row]["descripcion"] as! String
        let fechaEntrega = tareasAlumno[indexPath.row]["fechaEntrega"] as! NSDate
        
        print(mensaje)
        
        formatter.dateStyle = NSDateFormatterStyle.LongStyle

        
        let texto = "Nombre: \(currentCell.subtitleLabel.text!) \n Tipo: \(mensaje) \n Descripcion: \(tareaDescripcion) \n Entrega: \(formatter.stringFromDate(fechaEntrega))"
        
        print(texto)
        
        print("Cell title: \(currentCell.titleLabel.text) Subtitle: \(currentCell.subtitleLabel.text)")
        
        displayAlert(currentCell.titleLabel.text!, message: texto)
    }
    
    
    
    func displayAlert(title: String, message: String) {
        
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { alert in
            
            //self.dismissViewControllerAnimated(true, completion: nil)
            })
        presentViewController(alert, animated: true, completion: nil)
        
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
