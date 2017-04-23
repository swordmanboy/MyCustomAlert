//
//  MainViewController.swift
//  InformationAlertView
//
//  Created by ApinunWewillapp03 on 4/23/2560 BE.
//  Copyright © 2560 swordmanboy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var btnAlertYesNo: UIButton!
    @IBOutlet weak var btnAlertOk: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func onAlertOk(_ sender: Any) {
        ShipAlertView.onShowAlertOk(target: self, title: "title", message: "message", btnOKTitle: "OK") {
            
        }
    }
    
    @IBAction func onAlertYesNo(_ sender: Any) {
        ShipAlertView.onShowAlertYesNo(target: self, title: "title", message: "message", btnRightTitle: "cancel", btnLeftTitle: "OK", onActionRight: {
            
        }) {
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
