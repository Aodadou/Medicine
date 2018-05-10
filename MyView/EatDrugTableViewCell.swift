//
//  EatDrugTableViewCell.swift
//  MedicineBox
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit
///定时提醒 item
class EatDrugTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewMBox: UIView!
    @IBOutlet weak var viewAddMBox: UIView!
    
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbNameA: UILabel!
    
    @IBOutlet weak var lbCycweek: UILabel!
    
    
    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var nextTime: UILabel!
    
    @IBOutlet weak var durationDate: UILabel!
    
    var parentVC:UIViewController?
    var mInfo:MedicineInfo?
//    var 
    
    @IBAction func ActionEdit(_ sender: AnyObject) {
        if mInfo!.isEdited {
            let vc = parentVC?.storyboard?.instantiateViewController(withIdentifier: "editTimeScheme") as! EditTimeSchemeVC
            vc.rfid = mInfo!.rfid
            vc.schemeTimes = mInfo?.scheme
            parentVC?.navigationController?.pushViewController(vc, animated: true)
        }else{
            Util.toast("请先进入药品管理界面编辑药品")
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func initViewSetting(_ mcInfo:MedicineInfo,pVC:UIViewController){
        mInfo = mcInfo
        parentVC = pVC
        if !mcInfo.isEdited {
            lbNameA.text = "未编辑的新药品"
//            lbName.text = mcInfo.name
            viewMBox.isHidden = true
            viewAddMBox.isHidden = false
            return;
        }
        
        let timeScheme = mcInfo.scheme
        lbNameA.text = mcInfo.name
        lbName.text = mcInfo.name
        
        if timeScheme == nil || timeScheme?.schemeList.count == 0{// || timeScheme.endDay.isEmpty{
            viewMBox.isHidden = true
            viewAddMBox.isHidden = false
            return
        }else{
            viewMBox.isHidden = false
            viewAddMBox.isHidden = true
        }
        timeCount.text = "\(timeScheme!.schemeList.count)"

       
        
        let pos = Int(timeScheme!.cycle) - 1
        if pos>=0 && pos < 7 {
            lbCycweek.text = "\(cycles[pos])"
        }
        
        
        
 
        parentVC = pVC
        let  te = getNextTime(timeScheme!)
        if te != nil {
            nextTime.text = String(format: "%.2d:%.2d", Int(te!.hour),Int(te!.minute))//"\():\(Int(te!.minute))"
        }else{
            
        }
        Util.showDifColorLabel(durationDate, text: "从 \(timeScheme!.beginDay!) 到 \(timeScheme!.endDay!)", color: UIColor.init(red: 100/255.0, green: 147/255.0, blue: 235/255.0, alpha: 1.0), rang: NSMakeRange(2, 10), rang1: NSMakeRange(15, 10))
        
        
//        durationDate.text = "从\(timeScheme!.beginDay)到\(timeScheme!.endDay)"
    }
    
    
    func getNextTime(_ info:DrugTimeScheme)->SchemeTime?{
        if info.beginDay.isEmpty || info.endDay.isEmpty || info.schemeList.count == 0 {
            return nil
        }
        
        
        
        
        
//        let beginTime = Util.dateFormatter(by: info.beginDay)
//        var cycle = info.cycle
//        cycle = cycle + 1//＊24
//        let nowTime = Calendar.current
        
        let n = NSDate().dslCalendarView_day(with: Calendar.current)
        let hour = n!.hour
        let minute = n!.minute
        let totalTime = hour! * 60 + minute!
        
        var minTime:SchemeTime? = info.schemeList[0]
        for i in 0 ..< info.schemeList.count {
            let h = info.schemeList[i].hour
            let m = info.schemeList[i].minute
            let t = h * 60 + m
            
            if t > totalTime{
                minTime = info.schemeList[i]
                break
            }
        }
        return minTime
        
        
        
//        let now0Date = (nowTime as NSCalendar).date(bySettingHour: 0, minute: 0, second: 0, of: Date(), options: .wrapComponents)
//
//        let begin0Date = (nowTime as NSCalendar).date(bySettingHour: 0, minute: 0, second: 0, of: beginTime!, options: .wrapComponents)
//
//        let timeBN:Double = begin0Date!.timeIntervalSince(now0Date!)
//
//        let duration = Int32(timeBN/Double(24.0 * 60.0 * 60)) % cycle
//
//        if duration == 0 {
//            let c = (Date.init() as NSDate).dslCalendarView_hour(with: Calendar.current)
//
//            let now = SchemeTime(hour: (c?.hour!)!, minute: (c?.minute!)!)
//
//            var array:[SchemeTime] = []+info.schemeList
////            for i in 0..<info.schemeList.count {
////                array.append(info.schemeList[i] )
////            }
//
//            var mT:SchemeTime?
//            for a in array {
//                if (UtilSw.travelTime(a) - UtilSw.travelTime(now)) > 0 {
//                    mT = a
//                    break;
//                }
//            }
//            if mT == nil {
//                mT = array[0]
//            }
//            return mT!
//        }else{
//            var minTime = info.schemeList[0]
//            for i in 1..<info.schemeList.count {
//                if UtilSw.travelTime(minTime ) > UtilSw.travelTime(info.schemeList[i] ) {
//                    minTime = info.schemeList[i]
//                    continue
//                }
//            }
//            return minTime
//        }
    }
    
}
