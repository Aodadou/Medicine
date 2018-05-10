//
//  LoginVIew.swift
//  MedicineBox
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit

protocol MyLoginViewDelegate:NSObjectProtocol{
    func doLogin(_ account:String,password:String)
    
}
class LoginVIew: UIView,UITextFieldDelegate {

    var delegate:MyLoginViewDelegate?

    @IBOutlet weak var imgSelectedPwd: UIImageView!
    @IBOutlet weak var imgSelected: UIImageView!
    
    @IBOutlet weak var btnShowPwd: UIButton!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfAccount: UITextField!
    @IBAction func ActionLogin(_ sender: AnyObject) {
        guard !(tfAccount.text!.isEmpty||tfPassword.text!.isEmpty) else {
            Util.toast("用户名或密码不能为空")
            return
        }
        tfPassword.resignFirstResponder()
        tfAccount.resignFirstResponder()
        delegate?.doLogin(tfAccount.text!, password: tfPassword.text!)
        ///MARK:-TEST
//        delegate?.doLogin("15359222193", password: "q")
    }

    @IBAction func ActionShowPwd(_ sender: AnyObject) {
        btnShowPwd.isSelected = !btnShowPwd.isSelected
        tfPassword.isSecureTextEntry = !btnShowPwd.isSelected
    }
    func initView(_ userName:String?, userPwd:String?){
        tfAccount.text = userName
        tfPassword.text = userPwd
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
            imgSelected.isHidden = textField.tag == 1
            imgSelectedPwd.isHidden = textField.tag != 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            imgSelectedPwd.isHidden = true
        }else{
            imgSelected.isHidden = true
        }

    }
    func setAccount(_ acc:String?){
        tfAccount.text = acc
    }
    func setPassword(_ pwd:String?){
        tfPassword.text = pwd
    }
    func getAccount()->String{
        return tfAccount.text!
    }
    func getPassword()->String{
        return tfPassword.text!
    }
}
