//
//  EditMedicineInfoVC.swift
//  MedicineBox
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 jxm. All rights reserved.
//  编辑药品

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class EditMedicineInfoVC: ViewController,UITextFieldDelegate,BirthViewDelegate {

    
    @IBAction func ActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        var image = UIImage(named:"默认头像")
        let img = sm.pationImages.object(forKey: sm.currentDid)
        if img != nil{
            image = img as? UIImage
        }
        self.addRightBarButton(withFirstImage: image, action: nil)
        
        tfSumCount.delegate = self
        tfName.delegate = self
        tfNumber.delegate = self
        tfDayData.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
    }
    var medicine:MedicineInfo?
    var dateView:BirthView?
    @IBOutlet weak var tfNumber: UITextField!
    
    @IBOutlet weak var tfSumCount: UITextField!
    
    @IBOutlet weak var lbValidDate: UIButton!
    
    @IBOutlet weak var btnRFID: UIButton!

    @IBOutlet weak var tfName: UITextField!

    
    @IBOutlet weak var switch1: UISwitch!
    
    @IBOutlet weak var switch2: UISwitch!
    
    var validateDate:String = ""{
        
        
        
        willSet(newValue){
            
            let isOverDate = UtilSw.isOverDate(dateStr: newValue)
            if isOverDate{
                self.lbValidDate.setTitle("(药品即将过期)" + newValue, for: .normal)
                self.lbValidDate.setTitleColor(.red, for: .normal)
                
                let attrString = NSMutableAttributedString(string: self.lbValidDate.titleLabel!.text!)
                let font = UIFont.systemFont(ofSize: 16)
                attrString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0,7))
            }else{
                self.lbValidDate.setTitleColor(UIColor(red: 100/255.0, green: 147/255.0, blue: 235/255.0, alpha: 1.0), for: .normal)
            }
            
        }
        
    }
    
    var medicineCount:Int = 0{
        
        willSet(newValue){
            
            if newValue < (dayTimes! * onceData!) * 2 || newValue == 0{
                self.tfSumCount.textColor = .red
                
                let str = "(尽快添药)" + String(newValue)
                
                let attrString = NSMutableAttributedString(string: str)
                let font = UIFont.systemFont(ofSize: 14)
                attrString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0,5))
                self.tfSumCount.attributedText = attrString
                
            }else{
                
                self.tfSumCount.textColor = UIColor(red: 100/255.0, green: 147/255.0, blue: 235/255.0, alpha: 1.0)
                var str = self.tfSumCount.text!
                if str.contains("(尽快添药)"){
                    
                    let range = str.startIndex ..< str.index(str.startIndex, offsetBy: 6)
                    str.removeSubrange(range)
                    
                    self.tfSumCount.text = str
                    
                }
                
            }
        }
    }
    
    var dayTimes:Int? = 0
    {
        didSet{
            medicineCount += 0
        }
    }
    var onceData:Int? = 0
    {
        didSet{
            medicineCount += 0
        }
    }
    
    
    @IBAction func ActionSetPassDate(_ sender: AnyObject) {
        tfNumber.resignFirstResponder()
        tfNumber.resignFirstResponder()
        tfSumCount.resignFirstResponder()
        tfDayData.resignFirstResponder()
        
        if lbValidDate.currentTitle!.contains("(药品即将过期)"){
            let dateStr = lbValidDate.currentTitle!
            let newStr = dateStr.substring(from: dateStr.index(dateStr.startIndex, offsetBy: 8))
            
            self.showDateView(newStr, minDate: Date())
            return
        }
        
        self.showDateView(lbValidDate.titleLabel!.text, minDate: Date())
    }
    
    
    func showDateView(_ time:String?,minDate:Date) -> Void {
        if dateView == nil {
            let  views = Bundle.main.loadNibNamed("BirthView", owner: self, options: nil)
            dateView = views![0] as? BirthView
            dateView?.delegate = self
        }
        dateView?.show(time, type: -1 ,minDate: minDate,maxDate: nil)
    }

    var isEdit:Bool = false
    @IBAction func ActionSwitchChange(_ sender: UISwitch) {
        tfNumber.resignFirstResponder()
        tfNumber.resignFirstResponder()
        tfSumCount.resignFirstResponder()
        tfDayData.resignFirstResponder()
        let tag:Int = sender.tag
        if tag == 0 {
//            let dosage = Int(tfNumber.text!)
//            let sum = Int(tfSumCount.text!)
//            if dosage != 0 && sum > dosage{
//                return
//            }else{
//                Util.toast("每次用量不能为0，且当前药品数量必须大于每次用量")
//                sender.setOn(false, animated: true)
//            }
        }else{
            if lbValidDate.currentTitle!.contains("未") || lbValidDate.currentTitle!.isEmpty {
                Util.toast("需要先设置药品有效期")
                sender.setOn(false, animated: true)
                return
            }
        }
    }
    
    func close(_ bview: BirthView!) {
//        bview.disMiss()
        lbValidDate.setTitle(Util.dateFormatter(bview.datePicker.date), for: UIControlState())
        self.validateDate = Util.dateFormatter(bview.datePicker.date)
    }
    
    @IBAction func ActionScan(_ sender: UIButton) {
//         tfName.resignFirstResponder()
//        tfNumber.resignFirstResponder()
//        tfSumCount.resignFirstResponder()
//        Util.toast("即将推出。。。")
        let qr = ScanQRCodeVC()
        self.navigationController?.pushViewController(qr, animated: true)
//        tfName.becomeFirstResponder()
    }

    @IBOutlet weak var tfDayData: UITextField!
    @IBAction func ActionSetDayData(_ sender: UIButton) {
        tfName.resignFirstResponder()
        tfNumber.resignFirstResponder()
        tfSumCount.resignFirstResponder()
        tfDayData.resignFirstResponder()
        isEdit = true
        let tag:Int = sender.tag
        var value = Int.init(tfDayData.text!)
        if value == nil {
            tfDayData.text = "1"
            self.dayTimes = 1
            return
        }
        if tag == 0 {
            value = value! - 1
        }else{
            value = value! + 1
        }
        if value < 1 {
            value = 1
        }
        if value > 12 {
            value = 12
        }
        self.dayTimes = value!
        tfDayData.text = String.init(value!)
    }
    @IBAction func ActionSetNum(_ sender: UIButton) {
        tfName.resignFirstResponder()
        tfNumber.resignFirstResponder()
        tfSumCount.resignFirstResponder()
        tfDayData.resignFirstResponder()
        
        isEdit = true
        let tag:Int = sender.tag
        var value = Int.init(tfNumber.text!)
        if value == nil {
            tfNumber.text = "1"
            self.onceData = 1
            return
        }
        if tag == 0 {
            value = value! - 1
        }else{
            value = value! + 1
        }
        if value < 1 {
            value = 1
        }
        
        self.onceData = value!
        tfNumber.text = String(value!)
    }
    
    
    @IBAction func ActionSave(_ sender: AnyObject) {
        if medicine == nil
        {
            return
        }
        let name = tfName.text!
        
        for item in sm.medicineBoxs {
            if medicine!.macId != (item as AnyObject).macId {
                continue
            }
            for item1 in (item as AnyObject).list! as [MedicineInfo] {
                if name == item1.name && medicine!.rfid != item1.rfid {
                    Util.toast("药品名称已存在")
                    return;
                }
            }
        }
        if tfName.text!.isEmpty {
            Util.toast("未设置药品名称")
            return
        }
        
        let dos = Int(tfNumber.text!)
        if  dos == nil || dos == 0 {
            Util.toast("未设置每次用量")
            return
        }
        let dos1 = Int(tfDayData.text!)
        if  dos1 == nil || dos1 == 0 {
            Util.toast("未设置每天服药次数")
            return
        }
        
        var sum = 0
        if self.tfSumCount.text!.contains("(尽快添药)"){
            
            let sunStr = self.tfSumCount.text!
            let newStr = sunStr.substring(from: sunStr.index(sunStr.startIndex, offsetBy: 6))
            
            sum = Int(newStr)!
            
        }else{
            sum = Int(tfSumCount.text!)!
        }
        if  sum == 0 {
            Util.toast("未设置当前药品数量")
            return
        }
        if sum < dos1! * dos! {
            Util.toast("当前药品数量不能低于每日服用的总数量")//（每天服药次数＊每次用量）
            return
        }
            
        
        
        
        
        if  lbValidDate.currentTitle!.contains("未设置") {
            if switch2.isOn {
                Util.toast("未设置药品过期时间")
                return
            }
        }else{
            
            if lbValidDate.currentTitle!.contains("(药品即将过期)"){
                let dateStr = lbValidDate.currentTitle!
                let newStr = dateStr.substring(from: dateStr.index(dateStr.startIndex, offsetBy: 8))
                medicine!.validityPeriod = newStr
                
            }else{
                medicine!.validityPeriod = lbValidDate.currentTitle
            }
            
            
            
        }
        
        medicine!.addReminder = switch1.isOn
        medicine!.overdueReminder = switch2.isOn
        medicine!.name = tfName.text
        
        let total = String(sum)
        let dosage = Int(tfNumber.text!)!
        let times = Int(tfDayData.text!)!
        
        
      
        
        if total != medicine!.total || dosage != medicine?.dosage || times != medicine?.times{
            
            showAlertView()
            return
        }
        medicine!.total = total
        medicine!.dosage = Int(tfNumber.text!)!
        medicine!.times = Int(tfDayData.text!)!
//        medicine!.remark = Util.dateFormatter(NSDate(),format: "yyyy-MM-dd HH:mm:ss")
        sm.sendCmd(CMD9F_EditMedicine(modifyType: 0,info: medicine))
        
    }
    func showAlertView() -> Void {
        let alert = UIAlertView.init(title: "如果该药品设置过定时提醒，该修改将会清除其所有定时提醒", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alert.show()
    }
    override func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 1 {
            //medicine?.scheme = nil
            
            var sum = 0
            if self.tfSumCount.text!.contains("(尽快添药)"){
                
                let sunStr = self.tfSumCount.text!
                let newStr = sunStr.substring(from: sunStr.index(sunStr.startIndex, offsetBy: 6))
                
                sum = Int(newStr)!
                
            }else{
                sum = Int(tfSumCount.text!)!
            }
            
            medicine!.total = String(sum)
            medicine!.dosage = Int(tfNumber.text!)!
            medicine!.times = Int(tfDayData.text!)!
            sm.sendCmd(CMD9F_EditMedicine(modifyType: 2,info: medicine))
        }
    }
    func initView(){
       
        if medicine != nil {
            let mInfo:MedicineInfo = medicine!
            
            tfName.text = mInfo.name
            
            tfNumber.text = "\(mInfo.dosage)"
            self.onceData = mInfo.dosage
            
            tfDayData.text = "\(mInfo.times)"
            self.dayTimes = mInfo.times
            
            tfSumCount.text = (mInfo.currentCount.isEmpty ? "0" : mInfo.currentCount)
            self.medicineCount = Int(mInfo.currentCount)!
            
            if !mInfo.validityPeriod.isEmpty {
                lbValidDate.setTitle(mInfo.validityPeriod, for: UIControlState())
                self.validateDate = mInfo.validityPeriod
            }
            
            btnRFID.setTitle(mInfo.rfid, for: UIControlState())
            switch1.setOn(mInfo.addReminder, animated: true)
            switch2.setOn(mInfo.overdueReminder, animated: true)
        }
        if infoQR != nil {
            tfName.text = infoQR?.name
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfSumCount{
//            var str:String?
//            if (textField.text!.contains("(尽快添药)")){
//                str = textField.text!.substring(from: textField.text!.index(of: ")")!)
//
//                if str!.characters.count == 0 {
//                    textField.text = "0"
//                }else{
//                    let value = Int(textField.text!)!
//
//                    textField.text = "\(value)"
//                    self.medicineCount = value
//                }
//                return
//            }
            if textField.text == nil || textField.text == ""{
                textField.text = "0"
                return
            }
            let count = Int(textField.text!)
            medicineCount = count!

            return
        }
        
        if textField == tfNumber || textField == tfDayData{
            
            if textField.text?.count == 0 {
                textField.text = "0"
            }else{
                var value = Int(textField.text!)!
                if textField == tfDayData {
                    if value > 12 {
                        value = 12
                    }
                }
                textField.text = "\(value)"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        
    override func receiveLater(_ cmdCode: Int, cmd: ServerCommand) {
        switch cmdCode {
        case 0xA0:
            Util.toast("修改成功！", with: UIColor.green)
            self.navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
    
    override func receiveAllDevice(_ obj: Notification) {
        super.receiveAllDevice(obj)
        initView()
    }
    
    override func receiveFF(_ obj: Notification) {
        super.receiveFF(obj)
        let cmdCode = (obj.object as AnyObject).object(forKey: "CMDCode") as? String
        if cmdCode != nil && Int(cmdCode!) == 0x9F {
            sm.sendCmd(CMDA1_GetAllMedicineBox())
        }
//        let cmdcode = (obj.object as! NSDictionary).objectForKey("CMDCode") as! Int
//        if cmdcode == 0x9F {
//            
//        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.tfName.resignFirstResponder()
        self.tfNumber.resignFirstResponder()
        self.tfDayData.resignFirstResponder()
        self.tfSumCount.resignFirstResponder()
        
    }
}
