//
//  PushSetViewController.swift
//  MedicineBox
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit

class PushSetViewController: ViewController {
    @IBAction func ActionBack(_ sender: AnyObject) {
        backVC()
    }
    @IBOutlet weak var switch1: UISwitch!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var lbBind2: UILabel!
    @IBOutlet weak var lbBind1: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
    }
    func initView() -> Void {
        switch1.setOn(sm.userInfo.enableWeChatPush, animated: false)
        let phones = sm.userInfo.phoneGroup
        if phones != nil {
            setPhoneView((phones?.count)! > 0 ? phones?[0] : nil , btn: btnPhone0, lb: lbBind1)
            setPhoneView((phones?.count)! > 1 ? phones?[1] : nil , btn: btnPhone1, lb: lbBind2)
        }
    }
 
    func setPhoneView(_ ph1:String?,btn:UIButton,lb:UILabel){
        if ph1 == nil || ph1!.isEmpty {
            lb.text = "未绑定手机号"
//            btn.setTitle("", forState: .Normal)
            btn.setImage(UIImage(named: "添加手机按钮"), for: UIControlState())
            btn.setImage(UIImage(named: "添加手机按钮按下"), for: .highlighted)
        }else{
            lb.text = ph1!
//            btn.setTitle(ph1!, forState: .Normal)
            btn.setImage(UIImage(named: "删除手机按钮"), for: UIControlState())
            btn.setImage(UIImage(named: "删除手机按钮按下"), for: .highlighted)
        }
    }
    @IBOutlet weak var btnPhone0: UIButton!
    
    @IBOutlet weak var btnPhone1: UIButton!

    
    @IBAction func ActionPhone(_ sender: UIButton) {
        
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "bind")) as! BindPhoneVC
        if sender == btnPhone0 {
            if sm.userInfo.phoneGroup != nil && sm.userInfo.phoneGroup.count>0 {
                vc.phone = sm.userInfo.phoneGroup[0]
            }
            
        }else{
            if sm.userInfo.phoneGroup != nil && sm.userInfo.phoneGroup.count>1 {
                vc.phone = sm.userInfo.phoneGroup[1]
            }
            
        }
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func SwitchChange(_ sender: UISwitch) {
        
        
    }
        
    override func receiveLater(_ cmdCode: Int, cmd: ServerCommand) {
        if cmdCode == 0x15 {
             initView()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if switch1.isOn != sm.userInfo.enableWeChatPush {
            let o = sm.userInfo
            let newUser = UserInfo(name: o?.name, pass: o?.pass, phone: o?.phone, email: o?.email, offset: (o?.offset)!, appid: (o?.appid)!, snsList: o?.snsList, nickname: o?.nickname, enableWeChatPush: (o?.enableWeChatPush)!, phoneGroup: o?.phoneGroup)
            newUser?.enableWeChatPush = switch1.isOn
            let cmd14 = CMD14_ModifyUserInfo(modifyType: 6, oldValue: o, newValue: newUser)
            sm.sendCmd(cmd14)
        }
    }

}
