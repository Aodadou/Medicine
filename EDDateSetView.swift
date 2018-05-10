//
//  EDDateSetView.swift
//  MedicineBox
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit
typealias ClickOkBlock = (_ date:String)->Void

class EDDateSetView: UIView,UIPickerViewDataSource,UIPickerViewDelegate {
    var superView:UIView?
    var offset:Int?
    @IBOutlet weak var pickYear: UIPickerView!
    @IBOutlet weak var pickMonth: UIPickerView!
    @IBOutlet weak var pickDate: UIPickerView!
    
    var delegate:ClickOkBlock?
    var cycle = 1
    var startDate = DateComponents()
    var endDate = DateComponents()
    //var total = 1//总药量天数
    
    
    var minDateOfMonth = 0
    var minMonthOfYear = 0
    var minYear = 0
    
//    var yearNum = 0
//    var monthNum = 12
//    var dayNum = 0
    
    var years:[Int] = []
    var months:[Int] = []
    var days:[Int] = []
    
    var currentYear = 0
    var currentMonth = 0
    var currentDay = 0
    
    func refreshView(_ cyc:Int, start:Date,end:Date){
        cycle = cyc
        startDate = (start as NSDate).dslCalendarView_day()
        endDate = (end as NSDate).dslCalendarView_day()
        //total = totalDay
        if currentYear == 0 {
            currentYear = startDate.year!
            currentMonth = startDate.month!
            currentDay = startDate.day!
        }
       calcData()
    }
    
    func show(_ cyc:Int, start:Date,end:Date) -> Void {
        if superView == nil {
            superView = UIView(frame: UIScreen.main.bounds)
            superView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.frame = CGRect(x: 0, y: 0, width: superView!.frame.width, height: superView!.frame.height)
            superView?.addSubview(self)
            let window = UIApplication.shared.keyWindow
            window!.addSubview(superView!)
        }
        
        refreshView(cyc, start: start, end: end)
    }
    func disMiss() -> Void {
        
        self.removeFromSuperview()
        superView?.removeFromSuperview()
        superView = nil
    }
    
    
    @IBAction func actionSure(_ sender: Any) {
        currentYear = years[pickYear.selectedRow(inComponent: 0)]
        currentMonth = months[pickMonth.selectedRow(inComponent: 0)]
        currentDay = days[pickDate.selectedRow(inComponent: 0)]
        delegate?(String.init(format: "%.4d-%.2d-%.2d", currentYear,currentMonth,currentDay))
        disMiss()
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        disMiss()
    }
    

    @IBAction func ACtionClose(_ sender: AnyObject) {
        
    }
    func refreshYear(){
        pickYear.reloadAllComponents()
        var ms = pickYear.selectedRow(inComponent: 0)
        if ms >= years.count {
            ms = 0//years.count - 1
             pickYear.selectRow(ms, inComponent: 0, animated: true)
        }
        currentYear = years[ms]
       
    }
    func refreshMonth(){
        pickMonth.reloadAllComponents()
        var ms = pickMonth.selectedRow(inComponent: 0)
        if ms >= months.count {
            ms = 0//months.count - 1
        
            pickMonth.selectRow(ms, inComponent: 0, animated: true)
        }
        currentMonth = months[ms]
        
    }
    func refreshDay(){
        pickDate.reloadAllComponents()
        var ms = pickDate.selectedRow(inComponent: 0)
        if ms >= days.count {
            ms = 0//days.count - 1
             pickDate.selectRow(ms, inComponent: 0, animated: true)
        }
        currentDay = days[ms]
       
    }
     func  calcData() -> Void {

        
        years = getValidValues(1, s: startDate.year!, e: endDate.year!)
        refreshYear()
        
        var s = 1
        var e = 12
        if currentYear == startDate.year{
            s = startDate.month!
        }
        if currentYear == endDate.year{
            e = endDate.month!
        }
        
        months = getValidValues(1, s: s, e: e)
        refreshMonth()
       
        var sD = 1
        var eD = 30
        
        if currentMonth == 2{
            if currentYear % 100 != 0 && currentYear % 4 == 0 {
                eD = 29//dayNum = 29
            }else{
               eD = 28
            }
        }else if(currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12 ){
            eD = 31
        }else{
            eD = 30
        }
        
        
        if currentYear == startDate.year && currentMonth == startDate.month{
            sD = startDate.day!
        }else{
            let cTemp = String(format: "%.4d-%.2d-01", currentYear,currentMonth)
            let time =  Util.dateFormatter(by: cTemp).timeIntervalSince((startDate as NSDateComponents).date!)
            let dDate = time/24/60/60 ////扣掉吃药那天
            
            if Int(dDate) % cycle == 0 {
                sD = 1
            }else{
                sD = (cycle - Int(dDate) % cycle) + 1//余数是多少就从多少开始
            }
           
            //cTemp.month = currentMonth
            
            
            
        }
        if currentYear == endDate.year && currentMonth == endDate.month{
            eD = endDate.day!
        }
        

        days = getValidValues(cycle, s: sD, e: eD)
        refreshDay()
        
        
       
        
    }
    
    func getValidValues(_ cyc:Int,s:Int,e:Int)->[Int]{
        var temp = [Int]()
        
        for i in s...e {
            if (i-s) % cyc == 0{
                temp.append(i)
            }
        }
        
        return temp
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let tag = pickerView.tag
        return tag == 1 ? years.count : (tag == 2 ? months.count : days.count)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //
        let tag = pickerView.tag
        let value = tag == 1 ? years[row] : ( tag == 2 ? months[row] : days[row])
        
    
        return  String.init(format: (tag == 1 ? "%.4d年":(tag == 2 ? "%.2d月":"%.2d日")), value)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let tag = pickerView.tag
        if tag == 1 {
            currentYear = years[row]
            
        }else if tag == 2{
            currentMonth = months[row]
        }else{
            currentDay = days[row]
        }
        calcData()
        
    }
    
}
