//
//  TabBarAvisosTableViewController.swift
//  Escuela
//
//  Created by Pedro Alonso on 09/12/15.
//  Copyright © 2015 Pedro. All rights reserved.
//

import UIKit
import Parse

class TabBarAvisosTableViewController: UITableViewController {

    let tabBarAvisosCell = "TabBarAvisosCell"
    
    var avisosAlumno: [PFObject]!

    let formatter = NSDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        print("We have so many avisos \(avisosAlumno.count)")
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
        return avisosAlumno.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tabBarAvisosCell, forIndexPath: indexPath)

        // Configure the cell...
        
        let texto = "texto", tittulo = "titulo", grupoId = "grupoId", maestroId = "maestroId", nombreMaestro = "nombre", grupoNombre = "nombre"
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        cell.textLabel!.text = "Grupo \(avisosAlumno[indexPath.row][grupoId]!.valueForKey(grupoNombre)!): \(avisosAlumno[indexPath.row][tittulo]!)"
        cell.detailTextLabel!.text = "\(avisosAlumno[indexPath.row][texto]!) de \(avisosAlumno[indexPath.row][maestroId]!.valueForKey(nombreMaestro)!)"

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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

}
