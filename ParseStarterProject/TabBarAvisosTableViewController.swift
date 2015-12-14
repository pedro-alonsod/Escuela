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
        
        self.automaticallyAdjustsScrollViewInsets = true
    }
    
    override func viewWillAppear(animated: Bool) {
        
        avisosAlumno.sortInPlace({ $0.createdAt > $1.createdAt })
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
        let cell = tableView.dequeueReusableCellWithIdentifier(tabBarAvisosCell, forIndexPath: indexPath) as! TabBarAvisosTableViewCell

        // Configure the cell...
        
        let texto = "texto", tittulo = "titulo", grupoId = "grupoId", maestroId = "maestroId", nombreMaestro = "nombre", grupoNombre = "nombre"
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        cell.titleAvisosCell.text = "Grupo \(avisosAlumno[indexPath.row][grupoId]!.valueForKey(grupoNombre)!): \(avisosAlumno[indexPath.row][tittulo]!)"
        cell.detailAvisosCell.text = "\(avisosAlumno[indexPath.row][texto]!) de \(avisosAlumno[indexPath.row][maestroId]!.valueForKey(nombreMaestro)!)"
        
        let colorOfGroup = avisosAlumno[indexPath.row][grupoId]!.valueForKey("color") as! String
        
        let rgb = colorOfGroup.componentsSeparatedByString(",")
        
        let colorForText = UIColor(red: CGFloat(Int(rgb[0])!) / 255.0, green: CGFloat(Int(rgb[1])!) / 255.0, blue: CGFloat(Int(rgb[2])!) / 255.0, alpha: 0.1)
        
        cell.titleAvisosCell.backgroundColor = colorForText
        
        
        
        if let avatarProffesor = avisosAlumno[indexPath.row]["img"] as! PFFile? {
            
            avatarProffesor.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                
                if error == nil {
                    
                    if let image = imageData {
                        
                        let avatarData = UIImage(data: image)
                        
                        cell.avatarAvisosProfessor.image = avatarData
                        
                        print("done the image")
                    }
                } else {
                    
                    print("Something odd happened")
                }
            }
        } else {
            
            print("apparently there is no file yet check it out")
        }
        
        

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let rowSelected = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRowAtIndexPath(rowSelected!)! as! TabBarAvisosTableViewCell
        
        print("Cell title: \(currentCell.textLabel?.text) Subtitle: \(currentCell.detailTextLabel?.text)")
        
        displayAlert(currentCell.titleAvisosCell.text!, message: currentCell.detailAvisosCell.text!)
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
