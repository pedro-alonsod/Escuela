//
//  TabBarAvisosViewController.swift
//  Escuela
//
//  Created by Pedro Alonso on 09/12/15.
//  Copyright © 2015 Pedro. All rights reserved.
//

import UIKit

class TabBarAvisosViewController: UITabBarController, UITableViewDelegate {

    var selectedItem: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("the number sent is \(selectedItem)")
        
        self.navigationItem.title = "Avisos y Privados"
        
        let logoSats = UIImage(named: "logoSats.png")
        
        let imageView = UIImageView(image: logoSats)
        
        self.navigationItem.titleView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
