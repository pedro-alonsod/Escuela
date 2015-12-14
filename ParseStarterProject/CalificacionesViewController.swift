//
//  CalificacionesViewController.swift
//  Escuela
//
//  Created by Pedro Alonso on 06/12/15.
//  Copyright © 2015 Pedro. All rights reserved.
//

import UIKit
import Parse

class CalificacionesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
    let calificacionesCell = "CalificacionesTabBarCell"
    var calificacionesAlumno: [PFObject]!
    var nombresArray: [String] = []
    var arrayCalificaciones: [PFObject]!
    
    let formatter = NSDateFormatter()

    
    var item: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        print("tab selected \(tabBarController!.selectedIndex)")
        
        print("calificaciones item gotten \(item)")
        
        print("we have # of calif \(calificacionesAlumno.count)")
        
        calificacionesAlumno.sortInPlace({ $0.createdAt > $1.createdAt })
        
        
        
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
        
        
        
        return calificacionesAlumno.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(calificacionesCell, forIndexPath: indexPath) 
        
        // Configure the cell...
        
        let nombre = "alumnoId", valor = "valor", alumnoOTareas = "nombre", tareasId = "tareasId", mensaje = "Mensaje"
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        cell.textLabel!.text = "\(calificacionesAlumno[indexPath.row][tareasId]!.valueForKey(alumnoOTareas)!): \(calificacionesAlumno[indexPath.row][valor])"
        cell.detailTextLabel!.text = "\(calificacionesAlumno[indexPath.row][mensaje]!) \(calificacionesAlumno[indexPath.row][nombre].valueForKey(alumnoOTareas)!)"
        
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
    
    func calificadasFuncion() {
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
