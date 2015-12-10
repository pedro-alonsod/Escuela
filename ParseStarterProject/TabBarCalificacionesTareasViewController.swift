//
//  TabBarCalificacionesTareasViewController.swift
//  Escuela
//
//  Created by Pedro Alonso on 06/12/15.
//  Copyright © 2015 Pedro. All rights reserved.
//

import UIKit

class TabBarCalificacionesTareasViewController: UITabBarController {


    var selectedItem: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Tareas y Calificaciones"
        
        let logoSats = UIImage(named: "logoSats.png")
        
        let imageView = UIImageView(image: logoSats)
        
        self.navigationItem.titleView = imageView
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    
    override func viewDidAppear(animated: Bool) {
        
        
        print("selected index \(selectedItem)")
        
        tabBarController?.selectedIndex = selectedItem
        
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
