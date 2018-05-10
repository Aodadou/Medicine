//
//  BindPhoneVC.swift
//  MedicineBox
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit

class BindPhoneVC: ViewController {
    
    var count = 59
    var repeatTimer:Timer?
    var errorDescription:String?
    
    
    var uuid:String = ""
    var phone:String?=""
    var code = ""
    
    
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnGetCode: UIButton!
    
    @IBOutlet weak var tfAccount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if phone == nil || phone!.isEmpty {
            self.title = "绑定手机";
            btnOk.setTitle("完成绑定", for: UIControlState())
            tfAccount.text = ""
            tfAccount.isEnabled = true
        }else{
            self.title = "解绑手机";
            btnOk.setTitle("完成解绑", for: UIControlState())
            tfAccount.text = phone
            tfAccount.isEnabled = false
        }
    }
    
    @IBOutlet weak var tfCode: UITextField!
    @IBAction func ActionGetCode(_ sender: UIButton) {
        if tfAccount.text!.isEmpty {
            Util.toast("手机号不能为空")
            return
        }
        
        hideKeyBall()
        startTimer()
        phone = tfAccount.text!
        let val = (btnOk.titleLabel!.text!.contains("解绑") ? 0 : 1)
        
        let cmd  = CMDB9_GetVerificationCode(phone: phone, action: Int32(val))
       
        sm.sendCmd(cmd)
        
    }
    func hideKeyBall(){
        tfAccount.resignFirstResponder()
        tfCode.resignFirstResponder()
        
    }
    @IBAction func ActionOK(_ sender: AnyObject) {
        
        
        if uuid.isEmpty {
            Util.toast("请先获取验证码")
            return
        }
        
        if phone == nil || phone!.isEmpty {
            Util.toast("手机号不能为空")
            return
        }
        
        if tfCode.text!.isEmpty {
            Util.toast("验证码不能为空")
            return
        }
        
        hideKeyBall()
        
        let o = sm.userInfo
        let newUser = UserInfo(name: o?.name, pass: o?.pass, phone: o?.phone, email: o?.email, offset: (o?.offset)!, appid: (o?.appid)!, snsList: o?.snsList, nickname: o?.nickname, enableWeChatPush: (o?.enableWeChatPush)!, phoneGroup: o?.phoneGroup)
        newUser?.bindOperation = BindOperation()
        newUser?.bindOperation.phoneNo = phone
        newUser?.bindOperation.uuid = uuid
        newUser?.bindOperation.verificationCode = tfCode.text!
        let val = Int32(btnOk.titleLabel!.text!.contains("解绑") ? 8 : 7)
        print(val)
        let cmd14 = CMD14_ModifyUserInfo(modifyType:val, oldValue: o, newValue: newUser)
        sm.sendCmd(cmd14)
        
    }
    
    
    
    
    
    
    
    func getUserName() -> String {
        return tfAccount.text!
    }
    
    func getCode() -> String {
        return tfCode.text!
    }
    
    
    
    
    ///MARK:count down
    func startTimer(){
        //        phone = tfAccount.text
        count = 59
        btnGetCode.isEnabled = false
        btnGetCode.setTitle("\(count)s获取", for: UIControlState.disabled)
        repeatTimer?.invalidate()
        repeatTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(countNumber), userInfo: nil, repeats: true)
        
    }
    func cancelTimer(){
        repeatTimer?.invalidate()
        count = 59
        btnGetCode.isEnabled = true
        btnGetCode.setTitle("获取验证码", for: UIControlState())
        
    }
    func countNumber() -> Void {
        if errorDescription != nil {
            Util.toast(errorDescription)
            self.cancelTimer()
            errorDescription = nil
            return
        }
        count -= 1
        btnGetCode.setTitle("\(count)s获取", for: UIControlState.disabled)
        if count == 0 {
            self.cancelTimer()
        }
    }
    @IBAction func ActionBack(_ sender: AnyObject) {
        backVC()
    }
    
    override func receiveCMD(_ obj: Notification) {
        super.receiveCMD(obj)
        let cmd:ServerCommand = obj.object as! ServerCommand
        if cmd.getNo() == CMDBA_ServerReturnVerificationCode.commandConst() {
            uuid = (cmd as! CMDBA_ServerReturnVerificationCode).uuid
            Util.toast("短信验证码已发送，请注意查收", with: UIColor.black)
        }
        if cmd.getNo() == CMD15_ServerModifyUserResult.commandConst() {
            Util.toast("操作成功" , with: UIColor.green)
            backVC()
        }
        
    }
    
    override func receiveFF(_ obj: Notification) {
        super.receiveFF(obj)
        let cmdCode = (obj.object as AnyObject).object(forKey: "CMDCode") as? String
        if cmdCode != nil && Int(cmdCode!) == 0xB9 {
            cancelTimer()
        }
        
    }
}
