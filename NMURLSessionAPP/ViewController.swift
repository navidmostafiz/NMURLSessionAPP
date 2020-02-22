//
//  ViewController.swift
//  NMURLSessionAPP
//
//  Created by Navid on 2/22/20.
//  Copyright © 2020 UnitedStar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func gotoPost(_ sender: UIButton) {
        let postVC = storyboard?.instantiateViewController(withIdentifier: "postVC") as! PostViewController
        self.navigationController?.pushViewController(postVC,animated: true)
    }
    
}
