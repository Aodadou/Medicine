//
//  SchemeTimeTableViewCell.swift
//  MedicineBox
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit
typealias onClick = (_ pos:Int)->Void
class SchemeTimeTableViewCell: UITableViewCell {

    var block:onClick?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lbNmae: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var lbTime: UILabel!

    var row = 0
    @IBAction func Aciotn(_ sender: AnyObject) {
        block?(row)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func initView(_ timeStr:SchemeTime?,row:Int,block:@escaping onClick){
        self.block = block
        self.row = row
        if timeStr == nil {
            
            lbNmae.text = "新增定时\(self.row+1)"
            lbTime.text = ""
            button.setImage(UIImage(named: "添加手机按钮"), for: UIControlState())
            button.setImage(UIImage(named: "添加手机按钮按下"), for: .highlighted)
        }else{
            lbNmae.text = "定时\(self.row+1)"
            if timeStr!.hour >= 0 && timeStr!.minute >= 0 {
                lbTime.text = String.init(format: "%.2d:%.2d",timeStr!.hour,timeStr!.minute )
            }else{
                lbTime.text = "--:--"
            }
            
                //"\(timeStr!.hour):\(timeStr!.minute)"
            button.setImage(UIImage(named: "选择药品箭头"), for: UIControlState())
            button.setImage(UIImage(named: "选择药品箭头右箭头"), for: .highlighted)
        }
    }
}
