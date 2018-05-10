//
//  EditTimeSchemeVC.swift
//  MedicineBox
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 jxm. All rights reserved.
//  编辑具体定时

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


class EditTimeSchemeVC: ViewController,DateTimeViewDelegate,BirthViewDelegate,CycleSetViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var lbEndTime: UILabel!
    @IBOutlet weak var lbStartTime: UILabel!
    @IBOutlet weak var lbCycle: UILabel!
    
    var schemeTimes:DrugTimeScheme?
    
    var rfid:String?
    
    var medicine:MedicineInfo?
    var times = [SchemeTime]()
    var cycle:Int = 1
    
    var cycleView:CycleSetView?
    var dateView:BirthView?
    var timeView:DateTimeView?
    var drugTimeTemp:DrugTimeScheme?
     var edView:EDDateSetView?
    var maxDateCount:Int?//预计最多吃多少天
    
    
    var endMaxDate:Date?
    func checkSchemeTimeValid()->Bool{
        var valid = true;
        for time in times {
            if time.hour < 0 || time.minute < 0 {
                valid = false
                break
            }
        }
        return valid && times.count > 0
    }
    @IBAction func ActionSave(_ sender: UIButton) {
        if !checkSchemeTimeValid() {
            
            Util.toast("需要设置\(times.count)个时间点")
            return
        }
        
        
        var startTime:String = Util.dateFormatter(Date())
        if !lbStartTime.text!.contains("今天") {
            startTime = lbStartTime.text!
        }
        
        if lbEndTime.text!.isEmpty {
            Util.toast("结束时间未设置")
            return
        }
        
        
        
        let drugTime = DrugTimeScheme(rfid: rfid!, cycle: Int32(cycle), prompTone: 0, beginDay: startTime, endDay: lbEndTime.text!, schemeList:  UtilSw.sortStrTime(times))
        
        for info in sm.getCurrentDevice().list {
            if info.rfid.contains(rfid!) {
                drugTimeTemp = info.scheme
                info.scheme = drugTime
                let cmd9f = CMD9F_EditMedicine(modifyType:1, info: info)
                sm.sendCmd(cmd9f)
                break
            }
        }
        
        
        
        
    }
    @IBAction func ActionTimeOrCycle(_ sender: UIButton) {
        let tag:Int = sender.tag
        if tag == 0 {
            //start
            
            let time =  (schemeTimes!.beginDay == "FFFF-FF-FF") ? "" : schemeTimes!.beginDay
            showDateView(time, type: 0,minDate: Date(),maxDate: nil)
        }else if tag == 1{
            var minDate = Date()
            if !lbStartTime.text!.isEmpty  && !lbStartTime.text!.contains("今天"){
                minDate = Util.dateFormatter(by: lbStartTime.text!)
            }
            //calcEndTime()
            showEndDateView(lbEndTime!.text,  minDate: minDate, maxDate:endMaxDate! )

        }else if tag == 2{
            //cycle
           
                showCycleView(cycle - 1)
            
            
        }
        
    }
    @IBAction func ActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var myTableView: UITableView!
    
    //    var block:onClick?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.tableFooterView = UIView()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    
    func loadData(){
        
        let infos:(drugTime:DrugTimeScheme?,info:MedicineInfo?)? = getDrugTimeScheme(sm.currentDid, rfid: rfid!)
        schemeTimes = infos?.drugTime
        medicine = infos?.info
        
        times.removeAll()
        
        if schemeTimes != nil && schemeTimes?.schemeList != nil && schemeTimes!.schemeList!.count > 0{
            times = times + (schemeTimes!.schemeList )
            //times = UtilSw.sortStrTime(times)
            cycle = Int(schemeTimes!.cycle)
            lbStartTime.text = schemeTimes?.beginDay
            lbEndTime.text = schemeTimes?.endDay
            
        }else{
            lbStartTime.text = "今天"
            cycle = 1
        }
//        lbStartTime.text = "今天"
        if cycle > 0 && cycle <= 7 {
            lbCycle.text = cycles[cycle-1]
        }else{
            cycle = 1
            lbCycle.text = cycles[cycle-1]
        }
        
        calcEndTime()
        if medicine != nil {
          
            if times.count == 0 {
                times = Array.init(repeating: SchemeTime(hour: -1, minute: -1), count: Int(medicine!.times))
            }
        }
 
        
    }
    
    
    
    ///MARK:-显示周期设置视图
    func showCycleView(_ cycle:Int?) -> Void {
        
        if cycleView == nil {
            let  views = Bundle.main.loadNibNamed("DateTimeView", owner: self, options: nil)
            cycleView = views![1] as? CycleSetView
        }
        cycleView?.initView(cycle,callback: self)
        
        cycleView?.show()
    }
    ///MARK:-显示开始或结束日期设置视图
    func showDateView(_ time:String?,type:Int,minDate:Date,maxDate:Date?) -> Void {
        if dateView == nil {
            let  views = Bundle.main.loadNibNamed("BirthView", owner: self, options: nil)
            dateView = views![0] as? BirthView
            dateView?.delegate = self
        }
        dateView?.show(time, type: type ,minDate: minDate,maxDate:maxDate)
    }
    
    func showEndDateView(_ time:String?,minDate:Date,maxDate:Date) -> Void {
        if edView == nil {
            let  views = Bundle.main.loadNibNamed("EDDateSetView", owner: self, options: nil)
            edView = views![0] as? EDDateSetView
            //edView?.delegate = self
        }
        edView?.show(cycle, start: minDate, end: maxDate)
        edView?.delegate = {(date:String) in Void()
            self.lbEndTime.text = date
        };
    }
    ///MARK:-显示时间设置视图
    func showTimeView(_ row:Int,hour:Int,min:Int) -> Void {
        if timeView == nil {
            let  views = Bundle.main.loadNibNamed("DateTimeView", owner: self, options: nil)
            timeView = views![0] as? DateTimeView
            timeView?.delegate = self
        }
        timeView?.viewDidLoadRow(row)
        
        timeView?.show()
        
        if hour >= 0 && min >= 0{
            timeView?.setHour(hour, minute: min)
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:SchemeTimeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "schemeTime") as? SchemeTimeTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("SchemeTimeTableViewCell", owner: self, options: nil)![0] as? SchemeTimeTableViewCell
        }
        let row = indexPath.row
        var mTime:SchemeTime?
        if row < times.count {
            mTime = times[row]
        }
        
        cell?.initView(mTime, row: row, block: { (pos:Int)->Void in
            if pos >= self.times.count {
                self.showTimeView(pos, hour: 0, min: 0)
            }else{
                let time = self.times[pos]
                
                self.showTimeView(pos, hour:time.hour, min: time.minute)
            }
            
            
        })
        return cell!
    }
    
    func calcEndTime() -> Void {
        let count = Int(medicine!.currentCount)!
        let unit = (medicine!.dosage * medicine!.times)
        if unit > 0 {
            maxDateCount = count/unit + ((count % unit) > 0 ? 1 : 0) - 1
            var startDate = Date()
            if !lbStartTime.text!.contains("今天") {
                startDate = Util.dateFormatter(by: lbStartTime.text!)
            }
            endMaxDate = startDate.addingTimeInterval(Double((maxDateCount!) * 24 * cycle * 60 * 60) )
            lbEndTime.text = Util.dateFormatter(endMaxDate)
            
        }

    }
    func getSchemeTime(_ drugInfo:DrugTimeScheme?,row:Int)->SchemeTime?{
        if drugInfo != nil && drugInfo?.schemeList != nil && drugInfo?.schemeList.count > row && row >= 0 {
            return drugInfo!.schemeList[row]
        }
        return nil
    }
    

    ///MARK:_Delegate
    ///MARK:
    func close(_ bview: BirthView!) {
        let date = Util.dateFormatter(bview.datePicker.date)
        let type = bview.type
        //         NSString *dateS = [Util dateFormatter:_datePicker.date];
        if type == 0 {
            lbStartTime.text = date
            if Util.dateFormatter(Date()) == date {
                 lbStartTime.text = "今天"
            }
            
            calcEndTime()
            
        }else{
            lbEndTime.text = date
        }
    }
    func dateTimeView(_ superView: DateTimeView!) {
        let hour = superView.hour
        let min = superView.minute
        let row = superView.row
        let time = SchemeTime(hour: hour, minute: min)//String.init(format: "%.2d:%.2d", hour,min)
        
        
        let temp:(result:Bool,ts:[SchemeTime]) = checkTimeIsAvaliable(time!, times: times, row: row)
        
        if temp.result {
            times[row] = time!
//            times[row].hour = hour;
//            times[row].minute = min;
//            times = temp.ts
            myTableView.reloadData()
            
        }else{
            Util.toast("时间不能重复，或者间隔必须大于59分钟")
        }
        superView.disMiss()
        
        
    }
    
    func willCloseCallBack(_ cycle: Int, str: String, view: UIView) {
        let cyc = view as! CycleSetView
        cyc.disMiss()
        self.cycle = cycle + 1
        lbCycle.text = str
        calcEndTime()
        
    }
    
    
    ///MARK:-Util
    func checkTimeIsAvaliable(_ strTime:SchemeTime, times:[SchemeTime],row:Int)->(Bool,[SchemeTime]){//1,[]在时间段内
        let interval = 59 //10分钟
        let tempT = UtilSw.travelTime(strTime)
        var oldT:SchemeTime?
        var oldIndex = -1
        if row >= 0 && row < times.count && times.count != 0 {
            oldT = times[row]
        }
        
        var newTimes = [] + times//times//UtilSw.sortStrTime(times)
        
        var result = true
        for i in 0..<newTimes.count {
            if newTimes[i] == oldT {
                oldIndex = i
                continue
            }
            let ts = UtilSw.travelTime(newTimes[i])
            if tempT > (ts - interval) && tempT < (ts + interval){
                result = false
            }
        }
        if result == true {
//             var newTimes = [] + times//times//UtilSw.sortStrTime(times)
           
            if oldIndex != -1 {
                newTimes[oldIndex] = strTime
            }else{
                newTimes.append(strTime)
                newTimes = UtilSw.sortStrTime(newTimes)
            }
        }
        
        return (result,times)
        
        
    }
    //    ///MARK:_Receive
    //    override func receiveAllDevice(obj: NSNotification) {
    //        super.receiveAllDevice(obj)
    //        Util.toast("保存成功")
    //        self.navigationController?.popViewControllerAnimated(true)
    //
    //    }
    override func receiveLater(_ cmdCode: Int, cmd: ServerCommand) {
        if cmdCode == 0xA0 {
            Util.toast("保存成功", with: UIColor.green)
            self.navigationController?.popViewController(animated: true)
        }
    }
    override func receiveFF(_ obj: Notification) {
        super.receiveFF(obj)
        let cmdCode = (obj.object as AnyObject).object(forKey: "CMDCode") as? String
        if cmdCode != nil && Int(cmdCode!) == 0x9F {
            for info in sm.getCurrentDevice().list {
                if info.rfid.contains(rfid!) {
                    info.scheme = drugTimeTemp
                    break
                }
            }
        }
        
        
    }
    
}
