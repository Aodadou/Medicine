//
//  CycleSetView.swift
//  MedicineBox
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 jxm. All rights reserved.
//

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

let cycles = ["每一天","每二天","每三天","每四天","每五天","每六天","每七天"]
protocol CycleSetViewDelegate {
    func willCloseCallBack(_ cycle:Int,str:String,view:UIView)
}
//typealias BlockCycleSet = (cycle:Int,str:String,)->Void
class CycleSetView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var myPicker: UIPickerView!
    var block:CycleSetViewDelegate?
    var superView:UIView?
    var offset:Int?
    
    var cycle:Int = 0
    
    func initView(_ cycle:Int?,callback:CycleSetViewDelegate){
        var temp = cycle
        block = callback
        if cycle == nil || temp < 0 || temp > 6 {
            temp = 0
        }
        self.cycle = temp!
        myPicker.selectRow(temp!, inComponent: 0, animated: false)
    }
    
    
    func show() -> Void {
        if superView == nil {
            superView = UIView(frame: UIScreen.main.bounds)
            superView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.frame = CGRect(x: 0, y: 0, width: superView!.frame.width, height: superView!.frame.height)
            superView?.addSubview(self)
            let window = UIApplication.shared.keyWindow
            window!.addSubview(superView!)
        }
        
    }
    func disMiss() -> Void {
        
        self.removeFromSuperview()
        superView?.removeFromSuperview()
        superView = nil
    }
    
    
    ///MARK:-Delegate
    ///MARK:touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        self.disMiss()
        let cyc = myPicker.selectedRow(inComponent: 0)
        block?.willCloseCallBack(cyc,str: cycles[cyc], view: self)
    }
    ///MARK:Picker
    //    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    //        return self.frame.size.width
    //    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cycles[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cycle = row
    }
}
