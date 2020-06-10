//
//  HomeViewController.swift
//  CustomLogin
//
//  Created by Chris Meile on 2020-06-08.
//  Copyright © 2020 Chris Meile. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var firstName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let label = UILabel()
        label.text = "Hello"
        label.frame = CGRect(x: 150, y: 200, width: 100, height: 20)
        view.addSubview(label)
        
        

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
