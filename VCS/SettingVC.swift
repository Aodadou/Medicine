//
//  SettingVC.swift
//  MedicineBox
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit

class SettingVC: ViewController {
    
    @IBAction func ActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        // Do any additional setup after loading the view.
//        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ;
        let version:String =  (Bundle.main.infoDictionary! as NSDictionary).object(forKey: "CFBundleShortVersionString") as! String
        btnVersion.setTitle(version, for: UIControlState())
        
        sm.sendCmd(CMD04_GetAllDeviceList())
    }


    @IBAction func actionAboutUs(_ sender: Any) {
        UIApplication.shared.openURL(URL(string:"http://www.vanhitech.com/")!)
    }
    
    @IBOutlet weak var btnVersion: UIButton!
    @IBAction func ActionExit(_ sender: AnyObject) {
        manualExitLogin()
        
    }
}
