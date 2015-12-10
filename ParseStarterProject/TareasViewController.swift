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

    
    let formatter = NSDateFormatter()
    
    
    var item: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        
        print("tareas tab \(tabBarController!.selectedIndex)")
        
        print("tareas item gotten \(item)")
        
        print(" we have # \(tareasAlumno.count)")
        
        print("Tareas object \(tareasAlumno)")

        
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
        let cell = tableView.dequeueReusableCellWithIdentifier(tareasTabBarCell, forIndexPath: indexPath) 
        
        // Configure the cell...
        
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let tareaNombre = "nombre", fechaEntrega = "fechaEntrega", grupoNombre = "nombre", grupoId = "grupoId", materia = "materia", codigo = "codigo"
        let dateString = tareasAlumno[indexPath.row][fechaEntrega]! as! NSDate
        
        
        print("La fecha es: \(formatter.stringFromDate(dateString))")
        
        cell.textLabel!.text = "\(tareasAlumno[indexPath.row][tareaNombre]!) \(tareasAlumno[indexPath.row][materia]!)"
        cell.detailTextLabel!.text = "Grupo: \(tareasAlumno[indexPath.row][grupoId]!.valueForKey(grupoNombre)!) Entregar: \(formatter.stringFromDate(dateString))"
        
//        cell.tareaNombreLabel.text = "\(tareasAlumno[indexPath.row][tareaNombre]!) \(tareasAlumno[indexPath.row][materia]!)"
//        cell.descripcionLabel.text = "Esto es para \(tareasAlumno[indexPath.row][alumnoId]!.valueForKey(alumnoNombre)!)"
//        cell.fechaEntregaLabel.text = "Entregar: \(tareasAlumno[indexPath.row][fechaEntrega]!)  \(tareasAlumno[indexPath.row][codigo]!)"

        
        
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let rowSelected = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRowAtIndexPath(rowSelected!)! as UITableViewCell
        
        print("Cell title: \(currentCell.textLabel?.text) Subtitle: \(currentCell.detailTextLabel?.text)")
        
        displayAlert(currentCell.textLabel!.text!, message: currentCell.detailTextLabel!.text!)
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
