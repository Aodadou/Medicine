//
//  InputDrugInHandVC.swift
//  MedicineBox
//
//  Created by 吴杰平 on 2017/9/15.
//  Copyright © 2017年 jxm. All rights reserved.
//

import UIKit

class InputDrugInHandVC: UIViewController,UITextFieldDelegate {
    
    var tfInput:UITextField!
    var imgTFBack:UIImageView!
    let sm = SessionManger.share()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(InputDrugInHandVC.save))
        
        self.title = "手动输入"
        self.view.backgroundColor = UIColor.white
        
        self.initView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveFF(_:)), name: NSNotification.Name(rawValue: NTF_REC_FF), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveCMD(_:)), name: NSNotification.Name(rawValue: "kReceiveCMD"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func initView(){
        
        self.tfInput = UITextField()
        self.tfInput.delegate = self
        self.tfInput.placeholder = "在此处输入药品编码"
        
        self.imgTFBack = UIImageView()
        self.imgTFBack.image = UIImage(named: "输入框常态")
        
        
        self.view.addSubview(self.imgTFBack)
        self.view.addSubview(self.tfInput)
        
        self.imgTFBack.mas_makeConstraints { (make) in
            //make!.edges.equalTo()(self.view)?.with().insets()(UIEdgeInsetsMake(10, 10, 10, 10))
            make!.top.equalTo()(self.view)?.offset()(100)
            make?.width.equalTo()(self.view.frame.width * 0.75)
            make?.height.equalTo()(50)
            make?.centerX.equalTo()(self.view)
        }
    
        self.imgTFBack.layoutIfNeeded()
        
        
        print("img的宽度是：" + String(describing: self.imgTFBack.frame.width))
        
        self.tfInput.mas_makeConstraints { (make) in
            
            make?.center.equalTo()(self.imgTFBack)
            make?.width.equalTo()(self.imgTFBack.frame.width * 0.8)
            make?.height.equalTo()(self.imgTFBack.frame.height)
            
            
        }
        
        
    }
    
//    setNeedsLayout：告知页面需要更新，但是不会立刻开始更新。执行后会立刻调用layoutSubviews。
//    
//    layoutIfNeeded：告知页面布局立刻更新。所以一般都会和setNeedsLayout一起使用。如果希望立刻生成新的frame需要调用此方法，利用这点，动画可以在更新布局后直接使用这个方法让动画生效。
//    
//    layoutSubviews：系统重写布局
//    
//    setNeedsUpdateConstraints：告知需要更新约束，但是不会立刻开始
//    
//    updateConstraintsIfNeeded：告知立刻更新约束
//    
//    updateConstraints：系统更新约束

    
    
    func save(){
    
        let text = self.tfInput.text
        if text == nil || text == ""{
            GlobalMethod.toast("输入不能为空")
            return
        }
        
        sm!.sendCmd(CMDBC_QueryDrugInfoByBarCode(barcode: text))
        
    }
    
    func receiveFF(_ obj: Notification) {
        
        let code = Int((obj.object! as AnyObject).object(forKey: "code") as! String)
        if code == 62 {
            //GlobalMethod.toast("输入不能为空")
            let alert = UIAlertView(title: "未发现该药品的信息", message: nil, delegate: self, cancelButtonTitle: "确定")
            alert.tag = 10
            alert.show()
        }else{
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    func receiveCMD(_ obj:Notification){
        let cmd:ServerCommand = obj.object as! ServerCommand
        if cmd.getNo() == CMD03_ServerLoginRespond.commandConst() {
            GlobalMethod.closePressDialog()
            
        }
        
        
        if cmd.getNo() == 0xBD {
            //let cmdbd = cmd as! CMDBD_ServerReturnMedicineInfo
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.tfInput.resignFirstResponder()
        
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.tfInput.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}
