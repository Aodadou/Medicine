//
//  EatDrugRecord.swift
//  MedicineBox
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 jxm. All rights reserved.
//    吃药记录界面

import UIKit

class EatDrugRecordVC: ViewController,DSLCalendarViewDelegate {


    var myCalendarView:MyCalendar?

    var records = [MedicationRecord]()
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var lbYMDate: UILabel!
    
    @IBOutlet weak var lbDDate: UILabel!
    
    var isFirst = true;
    
    var mDate:DateComponents!
    @IBAction func ActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = Calendar.current
        mDate = (now as NSDate).dslCalendarView_day(with: calendar)
        
        var image = UIImage(named:"默认头像")
        let img = sm.pationImages.object(forKey: sm.currentDid)
        if img != nil{
            image = img as? UIImage
        }
        self.addRightBarButton(withFirstImage: image, action: nil)
        
        myCalendarView = Bundle.main.loadNibNamed("MyCalendar", owner: self, options: nil)![0] as? MyCalendar
        myCalendarView!.dsCalendar.delegate = self
    }
    
    @IBOutlet weak var lbNoRecord: UILabel!
    func initView(){
        var date = mDate.date!
        date = date.addingTimeInterval(-8 * 60 * 60)
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: date)
        lbDDate.text = dateStr.substring(8, end: 9)
        
        //lbDDate.text = "\(mDate.day!)"
        lbYMDate.text = "\(mDate.year!)年\(mDate.month!)月"
        if records.count == 0  {
            myTableView.isHidden = true;
            lbNoRecord.isHidden = false;
        }else{
            myTableView.isHidden = false;
            lbNoRecord.isHidden = true;
            myTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initData()
        
    }
    
    
    func initData() -> Void {
        if !checkCurDeviceIsExist() {
            return;
        }
        
        if sm.isConnected {
            let cmd = CMDA3_QueryMedicationRecord.init(macId: sm.getCurrentDevice().macId, date: Util.dateFormatter((mDate as NSDateComponents).date))
            sm.sendCmd(cmd)
            isFirst = false
            initView()
        }
        
    }
    
    
    @IBAction func ActionSetDate(_ sender: UIButton) {
        let tag:Int = sender.tag
        var dTemp:Date?
        if tag == 1 {
            dTemp = mDate.date?.addingTimeInterval(24*60*60)
            
        }else{
            dTemp = mDate.date?.addingTimeInterval(-24*60*60)
        }


        if dTemp!.timeIntervalSince1970 > now.timeIntervalSince1970{
            GlobalMethod.toast("未到此日期")
            return
        }else{
            mDate = (dTemp! as NSDate).dslCalendarView_day(with: Calendar.current)
        }
        
        let cmd = CMDA3_QueryMedicationRecord.init(macId: sm.getCurrentDevice().macId, date: Util.dateFormatter(mDate.date))
        sm.sendCmd(cmd)
        initView()
    }
    @IBAction func ActionCalender(_ sender: AnyObject) {
        myCalendarView?.show()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell:RecordTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "record") as? RecordTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("RecordTableViewCell", owner: self, options: nil)![0] as? RecordTableViewCell
        }
        let row = indexPath.row
//        cell?.setViewHeadOrEnd(row == 0 ? -1 : 0)
        if row<records.count {
            cell?.initView(row, sum: records.count, record: records[row])
        }
        
        return cell!
    }
    
    ///MARK:-CalenderViewDelegate
    func calendarView(_ calendarView: DSLCalendarView!, didSelect range: DSLCalendarRange!) {
        
    }
    
    func calendarView_disMiss(_ calendarView: DSLCalendarView!) {
        myCalendarView?.disMiss()
        
        initView()
        if (mDate as NSDateComponents).date!.compare(Date()) != ComparisonResult.orderedDescending {
            sendDateRequest(mDate)
        }
    }
    func calendarView(_ calendarView: DSLCalendarView!, willChangeToVisibleMonth month: DateComponents!, duration: TimeInterval) {
        print("Will show \(month) in \(duration) seconds")
    }
    func calendarView(_ calendarView: DSLCalendarView!, didChangeToVisibleMonth month: DateComponents!) {
        print("Now showing \(month)")
    }
    func calendarView(_ calendarView: DSLCalendarView!, didDragToDay day: DateComponents!, selecting range: DSLCalendarRange!) -> DSLCalendarRange! {
        
        let today = (now as NSDate).dslCalendarView_day(with: calendarView.visibleMonth.calendar)
        print("Now didDragToDay \(day)")
        
        
        let tempDate = day.date!
        let zone = TimeZone(secondsFromGMT: +28800)
        let time = zone!.secondsFromGMT(for: tempDate)
        let newDate = tempDate.addingTimeInterval(TimeInterval(time))
        let theDay = (newDate as NSDate).dslCalendarView_day(with: calendarView.visibleMonth.calendar)
        
        if day.date!.timeIntervalSince1970 > now.timeIntervalSince1970{
            GlobalMethod.toast("未到此日期")
        }else{
            mDate = theDay!
        }
        
        return DSLCalendarRange(startDay: (Date.init(timeIntervalSince1970: 0) as NSDate).dslCalendarView_day(with: calendarView.visibleMonth.calendar), endDay: today)
        
    }
    
    func sendDateRequest(_ day:DateComponents){
        records.removeAll()
        let cmd = CMDA3_QueryMedicationRecord.init(macId: sm.getCurrentDevice().macId, date: Util.dateFormatter((day as NSDateComponents).date!))
        sm.sendCmd(cmd)
    }
    
    override func receiveCMD(_ obj: Notification) {
        super.receiveCMD(obj)
        let cmd:ServerCommand = obj.object as! ServerCommand
        if cmd.getNo() == CMDA4_ServerQueryRecordResult.commandConst() {
            let cmda4 = cmd as! CMDA4_ServerQueryRecordResult
            records = cmda4.list.reversed()
            initView()
        }
    }
    
}
