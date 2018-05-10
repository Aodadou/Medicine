//
//  ChangePwdVC.swift
//  MedicineBox
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit

class ChangePwdVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var tfOld: UITextField!
    
    @IBOutlet weak var tfNewA: UITextField!
    @IBOutlet weak var tfNew: UITextField!
    @IBOutlet weak var btnSHow: UIButton!
    
    @IBOutlet weak var btnShow0: UIButton!
    
    @IBAction func ActionBack(_ sender: AnyObject) {
        backVC()
    }
    @IBAction func Actionshow(_ sender: UIButton) {
        let tag:Int = sender.tag
        if tag == 1 {
            btnShow0.isSelected = !btnShow0.isSelected
            tfOld.isSecureTextEntry = !btnShow0.isSelected
        }else{
            btnSHow.isSelected = !btnSHow.isSelected
            tfNew.isSecureTextEntry = !btnSHow.isSelected
             tfNewA.isSecureTextEntry = !btnSHow.isSelected
        }
        
    }
    @IBAction func ActionOK(_ sender: AnyObject) {
        if tfOld.text!.isEmpty {
            Util.toast("旧密码不能为空")
            return
        }
        if tfNew.text!.isEmpty {
            Util.toast("新密码不能为空")
            return
        }
        if tfNew.text!.compare(tfNewA.text!) != ComparisonResult.orderedSame{
            Util.toast("新密码不一致")
            return
        }
        
        let cmd = CMD58_ChangePwd(username: sm.username, oldPass: tfOld.text!, newPass: tfNew.text!)
        sm.sendCmd(cmd)
        
        
    }
    
    override func receiveLater(_ cmdCode: Int, cmd: ServerCommand) {
        if cmdCode == 0x59 {
            Util.toast("修改密码成功", with: UIColor.green)
             manualExitLogin()
        }
    }
    
//    override func receiveCMD(obj: NSNotification) {
//        super.receiveCMD(obj)
//        let cmd:ServerCommand = obj.object as! ServerCommand
//        if cmd.getCommandNo() == CMD59_ServerChangePwdResponse.commandConst() {
//            manualExitLogin()
//        }
//    }
    
}
