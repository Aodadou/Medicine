//
//  LogResFPwdVC.swift
//  MedicineBox
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit

class LogResFPwdVC: ViewController,MyLoginViewDelegate,MyResFidViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var viewCase: UIView!
    @IBOutlet weak var btnToLogin: UIButton!
    @IBOutlet weak var btnToRegist: UIButton!
    @IBOutlet weak var btnToFindPwd: UIButton!
    
//    var sm:SessionManger?
    var helper:CMDHelper?
    var sendCmdTimer:Timer?
    var user:UserDefaults = UserDefaults.standard
    var remember:Bool? = false
//    var appupdate:appup
    var views:Array<UIView>?
    var mainAcionType = 0//0登录,1注册,2找回
    var stepFlag = 0
    
    var uuid:String?
    var reconnectTimer:Timer?
    
    var loginView:LoginVIew?
    var resFindView:ResFindVIew?
    
    var coverView:UIView?
    
    @IBAction func ActionLoginResFind(_ sender: UIButton) {
        chooseMainAction(sender.tag)
    }
    
    func chooseMainAction(_ type:Int) -> Void {
        if type == mainAcionType {
            return
        }
        mainAcionType = type
        resFindView?.cancelTimer()
        btnToLogin.isSelected = type == 0
        btnToRegist.isSelected = type == 1
        btnToFindPwd.isSelected = type == 2
        
        viewCase.subviews[0].removeFromSuperview()
        let view = views![type != 0 ? 1:0]
        if type != 0 {
            (view as! ResFindVIew).setTypeView(type)
            (view as! ResFindVIew).tfAPwd.delegate = self
            (view as! ResFindVIew).tfPwd.delegate = self
        }
        viewCase.addSubview(view)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sm = SessionManger.share()
        sm.closeSocket()
        helper = CMDHelper.shareInstance() as? CMDHelper
        
        
        loginView?.tfAccount.delegate = self
        loginView?.tfPassword.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(receiveFF(_:)), name: "Receive_FF", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(receiveCMD(_:)), name: "kReceiveCMD", object: nil)
      
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFF:) name:NOTIFY_REC_FF object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveAllDevice:) name:NOTIFY_GETALLDEVICE object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveAllTimer:) name:NOTIFY_RECEIVE_ALL_TIMER object:nil];
        remember = user.bool(forKey: "remember")
        
        loginView?.setAccount(user.string(forKey: "account"))
        loginView?.setPassword(user.string(forKey: "password"))
        
        
        if views == nil {
            views = Bundle.main.loadNibNamed("LogResForViews", owner: self, options: nil) as? Array<UIView>
            
            let mFrame = UtilSw.calcViewRectInParent(viewCase, subView: views![0], diction: 3)
            for itemView in views! {
                itemView.frame = mFrame
                if itemView.isKind(of: LoginVIew.self) {
                    loginView = (itemView as! LoginVIew)
                    loginView!.delegate = self
                }else if itemView.isKind(of: ResFindVIew.self) {
                    resFindView = (itemView as! ResFindVIew)
                    resFindView!.delegate = self
                }
            }
            viewCase.addSubview(views![0])
            loginView?.initView(user.string(forKey: "account"), userPwd: user.string(forKey: "password"))
        }
        remember = user.value(forKey: "remember") as? Bool
        if remember == nil{
            loginView?.setPassword("")
            return
        }
        
        if remember! && mainAcionType == 0 && !(loginView!.getPassword().isEmpty){
            self.createCoverView()
            doLogin(loginView!.getAccount(), password: loginView!.getPassword())
        }
        if !remember! {
            loginView?.setPassword("")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func createCoverView(){
        coverView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        coverView?.backgroundColor = UIColor.white
        coverView?.tag = 10001
        UIApplication.shared.keyWindow!.addSubview(coverView!)
        
        let iconView = UIImageView()
        iconView.image = UIImage(named: "logo")
        coverView?.addSubview(iconView)
        iconView.mas_makeConstraints { (make) in
            make?.width.mas_equalTo()(150)
            make?.height.mas_equalTo()(120)
            make?.centerX.mas_equalTo()(self.coverView?.mas_centerX)
            make?.centerY.mas_equalTo()(self.coverView!.mas_centerY)
        }
        
        
    }
    
    func removeCoverView(){
        coverView?.removeFromSuperview()
    }
    
    func startTimerDown() -> Void {
        sendCmdTimer?.invalidate()
        sendCmdTimer = Timer.scheduledTimer(timeInterval: 45, target: self, selector: #selector(sendCmdTimeOut), userInfo: nil, repeats: false)
    }
    
    func sendCmdTimeOut() -> Void {
        sm.closeSession(true)
        sendCmdTimer?.invalidate()
        GlobalMethod.closePressDialog()
        Util.toast("请求超时，请检查网络")
    }
    //MARK:代理实现
    func doLogin(_ account: String, password: String) {
        loginView?.tfAccount.resignFirstResponder()
        loginView?.tfPassword.resignFirstResponder()
//        self.navigationController?.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("dList"), animated: true)
        sm.closeSession(true)
        sm.mode = "login"
        sm.username = account
        sm.password = password
        sm.startSession()
        user.set(account, forKey: "account")
        user.set(password, forKey: "password")
        user.set(true, forKey: "remember")
        user.synchronize()
        GlobalMethod.showProgressDialog("加载中...")
        self.startTimer()
        
//        let token = UserDefaults.standard.value(forKey: "DEVICE_TOKEN") as! String
//        let dict:[String:String] = ["platform":"i","username":account,"password":password,"deviceToken":token]
//        do{
//            let dictData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
//            let json = String(data: dictData, encoding: .utf8)
//            print("JSON:" + json!)
//            let data = json!.data(using: .utf8)
//            
//            let tokenSocket = TokenSocket(data:data!)
//            tokenSocket.connectAndSend()
//        }catch{
//            GlobalMethod.toast("JSON转换失败")
//        }
        
        
    }
    func doRegFind(_ type: Int, account: String, password: String, code: String) {
        loginView?.tfAccount.resignFirstResponder()
        loginView?.tfPassword.resignFirstResponder()
        
        stepFlag = 2
        
        resFindView?.startTimer()
        
        //sm.closeSession(true)
        sm.mode = nil;
        sm.host = nil;
        sm.isLogin = false;
        if sm.isConnected {
            waittingConnectServer2()
            
        }else{
            sm.startSession()
            reconnectTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(waittingConnectServer2), userInfo: nil, repeats: false)
        }
        
    }
    func doGetCode(_ type: Int, account: String) {
        stepFlag = 1
        sm.closeSession(true)
        sm.mode = nil;
        sm.host = nil;
        sm.isLogin = false;
//        sm.startSession()
//        waittingConnectServer()
//        resFindView?.startTimer()
        
        if sm.isConnected {
            waittingConnectServer()
        }else{
            sm.startSession()
            reconnectTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(waittingConnectServer), userInfo: nil, repeats: false)
        
        }
        
        
        
        
    }
    
    var timer_login:Timer?
    func startTimer(){
        self.timer_login = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(LogResFPwdVC.loginTimeout), userInfo: nil, repeats: false)
        
    }
    
    func loginTimeout(){
        if timer_login != nil {
            sm.closeSocket()
            self.cancelLoginTimer()
            GlobalMethod.toast("登陆超时")
            self.removeCoverView()
        }
    }
    func cancelLoginTimer(){
        timer_login?.invalidate()
        timer_login = nil
        GlobalMethod.closePressDialog()
    }
    
    
//    -(void)sendCMDTimerOut{
//    [self cancelTimer];
//    [sm closeSession:YES];
//    [sendCmdTimer invalidate];
//    [GlobalMethod closePressDialog];
//    [GlobalMethod toast:NSLocalizedString(@"server_no_response_try", nil)];
//    }
//    -(void)waittingConnectServer{
//    [reconnectTimer invalidate];
//    //    [GlobalMethod closePressDialog];
//    sendCmdTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(sendCMDTimerOut) userInfo:nil repeats:NO];
//    [sm sendCmd:[[CMD68_RegisterWithVerifySetup1 alloc] initWithUsername:_phone_text.text Email:@"" Phone:_phone_text.text]];
//    //[publicCmdHelper sendCMD68WithUsername:@"" Email:@"" Phone:_phone_text.text];
//    }
   
    func sendCMDTimerOut() -> Void {
        resFindView?.cancelTimer()
        sm.closeSession(true)
        sendCmdTimer?.invalidate()
        GlobalMethod.closePressDialog()
        Util.toast("响应超时，请检查网络是否正常")
    }
    
    func sendCMDTimerOut2() -> Void {
        sendCmdTimer?.invalidate()
        GlobalMethod.closePressDialog()
        Util.toast("响应超时，请检查网络是否正常")
    }
    
    func waittingConnectServer(){
        sendCmdTimer?.invalidate()
        reconnectTimer?.invalidate()
        
        sendCmdTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(sendCMDTimerOut), userInfo: nil, repeats: false)
        if mainAcionType == 1 {
            sm.sendCmd(CMD68_RegisterWithVerifySetup1(username: resFindView?.getUserName(), email: "", phone: resFindView?.getUserName()))
        }else if(mainAcionType == 2){
            sm.sendCmd(CMD62_ForgetPassWithVerifySetup1(username: resFindView?.getUserName(), email: "", phone: resFindView?.getUserName() ))
        }
    }
    
    func waittingConnectServer2(){
        sendCmdTimer?.invalidate()
        reconnectTimer?.invalidate()
        
        sendCmdTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(sendCMDTimerOut2), userInfo: nil, repeats: false)
        if mainAcionType == 1 {
            sm.sendCmd(CMD6A_RegisterWithVerifySetup2(username: resFindView?.getUserName(), pass: resFindView?.getPwd(), phone: resFindView?.getUserName(), email: "", uuid: uuid, code: resFindView?.getCode()))
        }else if(mainAcionType == 2){
            sm.sendCmd(CMD64_ForgetPassWithVerifySetup2(username: resFindView?.getUserName(), email: "", phone: resFindView?.getUserName(), pass: resFindView?.getPwd(), uuid: uuid, code: resFindView?.getCode()))
        }
    }
    //MARK:通知处理
    override func receiveCMD(_ obj:Notification) -> Void {
        let cmd:ServerCommand = obj.object as! ServerCommand
       
        if (cmd.getNo() == CMD63_ServerReturnValidateCode.commandConst()) {
            let cmd63 = cmd as! CMD63_ServerReturnValidateCode
            uuid = cmd63.uuid
            GlobalMethod.closePressDialog()
            sendCmdTimer?.invalidate()
            sm.closeSession(true)
            Util.toast("验证码已发送，注意查收")
        }
        
        if (cmd.getNo() == CMD69_ServerReturnValidateCode.commandConst()) {
            let cmd69 = cmd as! CMD69_ServerReturnValidateCode
            uuid = cmd69.uuid
            GlobalMethod.closePressDialog()
            sendCmdTimer?.invalidate()
            sm.closeSession(true)
            Util.toast("验证码已发送，注意查收", with: UIColor.black)
        }
        if (cmd.getNo() == CMD74_ServerReturnParameter.commandConst()) {
            if mainAcionType > 0 {
                if (stepFlag == 1) {
                    self.waittingConnectServer()
                }else if stepFlag == 2{
                    self.waittingConnectServer2()
                }
                resFindView?.startTimer()
            }
        }
        if (cmd.getNo() == CMD65_ServerForgetPassSucc.commandConst()) {
            sendCmdTimer?.invalidate()
            GlobalMethod.closePressDialog()
            sm.closeSession(true)
            
            Util.toast("找回密码成功!", with: UIColor.green)
            loginView?.setAccount((resFindView?.getUserName())!)
            loginView?.setPassword((resFindView?.getPwd())!)
            chooseMainAction(0)
            resFindView?.cancelTimer()
//            doLogin((resFindView?.getUserName())!, password: (resFindView?.getPwd())!)
            //            self.writeDefault()
            //            self.navigationController!.popToRootViewControllerAnimated(true)
        }
        if (cmd.getNo() == CMD6B_ServerRegisterSucc.commandConst()) {
            sendCmdTimer?.invalidate()
            GlobalMethod.closePressDialog()
            //sm.closeSession(true)
            Util.toast("注册成功!", with: UIColor.green)
            
            loginView?.setAccount((resFindView?.getUserName())!)
            loginView?.setPassword((resFindView?.getPwd())!)
            chooseMainAction(0)
            doLogin((resFindView?.getUserName())!, password: (resFindView?.getPwd())!)
            resFindView?.cancelTimer()
//            self.writeDefault()
//            self.navigationController!.popToRootViewControllerAnimated(true)
        }
    }
    func receiveAllTimer(_ obj:Notification) -> Void {
        self.removeCoverView()
    }
    override func receiveAllDevice(_ obj:Notification) -> Void {
        
        //self.removeCoverView()
        self.cancelLoginTimer()
        GlobalMethod.closePressDialog()
        self.navigationController?.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "dList"), animated: true)
    }
    override func receiveFF(_ obj:Notification) -> Void {
        resFindView?.cancelTimer()
        sendCmdTimer?.invalidate()
        GlobalMethod.closePressDialog()
        Util.toast((obj.object as! NSDictionary).object(forKey: "info") as! String)
        self.removeCoverView()
        self.cancelLoginTimer()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginView?.tfAccount.resignFirstResponder()
        loginView?.tfPassword.resignFirstResponder()
        
        if resFindView != nil{
            resFindView?.tfPwd.resignFirstResponder()
            resFindView?.tfAPwd.resignFirstResponder()
            resFindView?.tfCode.resignFirstResponder()
            resFindView?.tfAccount.resignFirstResponder()
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginView?.tfAccount.resignFirstResponder()
        loginView?.tfPassword.resignFirstResponder()
        
        if resFindView != nil{
            resFindView?.tfPwd.resignFirstResponder()
            resFindView?.tfAPwd.resignFirstResponder()
            resFindView?.tfCode.resignFirstResponder()
            resFindView?.tfAccount.resignFirstResponder()
        }
    }
}
