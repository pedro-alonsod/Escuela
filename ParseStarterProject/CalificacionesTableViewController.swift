//
//  CalificacionesTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Alonso on 29/10/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class CalificacionesTableViewController: UITableViewController {

    var calificacionesAlumno: [PFObject]!
    var calificacionesCell = "CalificacionesCell"
    var nombresArray: [String] = []
    var arrayCalificaciones: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        print(calificacionesAlumno)
        
        
        
        print(nombresArray.count)
        
        //arrayCalificaciones = Array(calificacionesAlumno.)
        
        //print(arrayCalificaciones)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
    
        return calificacionesAlumno.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(calificacionesCell, forIndexPath: indexPath) as! CalificacionesTableViewCell

        // Configure the cell...
        let nombre = "alumnoId", valor = "valor", alumnoOTareas = "nombre", tareasId = "tareasId", mensaje = "Mensaje"
        cell.examenOTareaLabel.text = "\(calificacionesAlumno[indexPath.row][tareasId]!.valueForKey(alumnoOTareas)!): \(calificacionesAlumno[indexPath.row][valor])"
        cell.messageCalificaciones.text = "\(calificacionesAlumno[indexPath.row][mensaje]!)"
        cell.nombreAlumnoLabel.text = "\(calificacionesAlumno[indexPath.row][nombre].valueForKey(alumnoOTareas)!)"
        
        let testValor = calificacionesAlumno[indexPath.row][valor] as! Int
        
        if testValor < 70 {
            
            print("cross")
            cell.calificacionIconImage.image = UIImage(named: "crossIcon")
            cell.examenOTareaLabel.textColor! = UIColor.redColor()
            
        } else {
            
            print("check")
            cell.calificacionIconImage.image = UIImage(named: "checkIcon")
            
        }
        
        
        print("el juancho \(calificacionesAlumno[indexPath.row][nombre]!.valueForKey(alumnoOTareas)!)")
        print("l tarea oe examne es \(calificacionesAlumno[indexPath.row][tareasId]!.valueForKey(alumnoOTareas)!)")
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func getNombreAlumno(indexPath: NSIndexPath) {
        
        
    }
}
