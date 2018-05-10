//
//  ResFindVIew.swift
//  MedicineBox
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit
protocol MyResFidViewDelegate:NSObjectProtocol{
    func doRegFind(_ type:Int,account:String,password:String, code:String)
    func doGetCode(_ type:Int, account:String)
}
class ResFindVIew: UIView,UITextFieldDelegate {
    //
    var count = 59
    var repeatTimer:Timer?
    var errorDescription:String?
//    var phone:String?
    //
    fileprivate var type = 1
    var delegate:MyResFidViewDelegate?
    //MARK: 选中显示
    @IBOutlet weak var selectedCOde: UIImageView!
    @IBOutlet weak var selctedPwd: UIImageView!
    @IBOutlet weak var selctedAPwd: UIImageView!
    @IBOutlet weak var selctedAcc: UIImageView!

    @IBOutlet weak var imgDisablePwd: UIImageView!
    @IBOutlet weak var imgDIsableAPwd: UIImageView!
    
    @IBOutlet weak var btnShowPwd: UIButton!
    @IBOutlet weak var btnShowAPwd: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnGetCode: UIButton!
    
    @IBOutlet weak var tfAccount: UITextField!
    @IBOutlet weak var tfAPwd: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    
    @IBOutlet weak var tfCode: UITextField!
    @IBAction func ActionGetCode(_ sender: UIButton) {
        if tfAccount.text!.isEmpty {
            Util.toast("手机号不能为空")
            return
        }
    
        hideKeyBall()
        delegate?.doGetCode(type, account: tfAccount.text!)
        
    }
    func hideKeyBall(){
        tfAccount.resignFirstResponder()
        tfPwd.resignFirstResponder()
        tfAPwd.resignFirstResponder()
        tfCode.resignFirstResponder()
        
    }
    @IBAction func ActionOK(_ sender: AnyObject) {
        if tfAccount.text!.isEmpty {
            Util.toast("手机号不能为空")
            return
        }
        
        //校验
        if !Util.isMobileNumber(tfAccount.text){
            GlobalMethod.toast("手机号码格式错误")
            return
        }
        
        if tfCode.text!.isEmpty {
            Util.toast("验证码不能为空")
            return
        }
        if tfPwd.text!.isEmpty {
            Util.toast("密码不能为空")
            return
        }
        if tfPwd.text != tfAPwd.text {
            Util.toast("输入的密码不一致")
            return
        }

        hideKeyBall()
        delegate?.doRegFind(type, account: tfAccount.text!, password: tfPwd.text!, code: tfCode.text!)
        
    }
    
    

    @IBAction func ActionShowPwd(_ sender: UIButton) {
        if sender.tag == btnShowPwd.tag {
            btnShowPwd.isSelected = !btnShowPwd.isSelected
            tfPwd.isSecureTextEntry = !btnShowPwd.isSelected
        }else{
            btnShowAPwd.isSelected = !btnShowAPwd.isSelected
            tfAPwd.isSecureTextEntry = !btnShowAPwd.isSelected
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedCOde.isHidden = textField.tag != 1
        selctedPwd.isHidden = textField.tag != 2
        selctedAPwd.isHidden = textField.tag != 3
        selctedAcc.isHidden = textField.tag != 0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            selctedAcc.isHidden = true
        }else if(textField.tag == 1){
            selectedCOde.isHidden = true
        }else if textField.tag == 2{
            selctedPwd.isHidden = true
        }else{
            selctedAPwd.isHidden = true
        }
    }
    
    func getUserName() -> String {
        return tfAccount.text!
    }
    
    func getCode() -> String {
        return tfCode.text!
    }
    
    func getPwd() -> String {
        return tfPwd.text!
    }
    func getPwdA() -> String {
        return tfAPwd.text!
    }
    
    /// type为1时是注册界面，为2时是找回密码
    func setTypeView(_ typeValue:Int){
        type = typeValue
        btnOk.setTitle(type == 1 ? "注册" : "找回密码", for: UIControlState())
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
        btnGetCode.setTitle("获取验证码", for: UIControlState.normal)
        
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
}
