

import UIKit

let NOTIFY_GETALLDEVICE = "getAllDevice"
let NTF_REC_FF = "Receive_FF"
//let NTF_REC_CMDA = "after receive cmd"
let NTF_REFRESH_UPHOTO = "refresh"

let HAS_VALIDATE_ALERT = "hasValidateAlert"
let HAS_NO_ENOUGH_ALERT = "hasNoEnoughAlert"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{

    var window: UIWindow?
    var view:UIView?
    
    //==================================================
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let data = NSData(data: deviceToken)
        let token:String = data.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>" ))
        let t = token.replacingOccurrences(of: " ", with: "")
        print("deviceToken:" + t)
        
        UserDefaults.standard.set(t, forKey: "DEVICE_TOKEN")
        
        //482f8ba3 8dce348e a2423a43 cba9e015 5b39d0b3 2300c24c 7cd11238 4d52dfca
        
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("=======================================")
    }
    func application(_ application: UIApplication,didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //可选
        NSLog("did Fail To Register For Remote Notifications With Error: \(error)")
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("前台收到远程通知")
        
        let userInfo = response.notification.request.content.userInfo
        let request = response.notification.request // 收到推送的请求
        let content = request.content; // 收到推送的消息内容
        let badge = content.badge;  // 推送消息的角标
        let body = content.body;    // 推送消息体
        let sound = content.sound;  // 推送消息的声音
        let subtitle = content.subtitle;  // 推送消息的副标题
        let title = content.title;  // 推送消息的标题
        
        if(response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()))! {
            print("iOS10 收到远程通知:%@" )
            
            //00 sos
            //01 吃药
            //02 过期
            let hasValidateAlert:Bool = UserDefaults.standard.bool(forKey: HAS_VALIDATE_ALERT)
            
            
            //03 药品不足
            let hasNoEnoughAlert:Bool = UserDefaults.standard.bool(forKey: HAS_NO_ENOUGH_ALERT)
            
            
            
        }else {
            print("iOS10 收到本地通知")
            
            
            
        }
        
       
        completionHandler()  // 系统要求执行这个方法
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("---------------------------------------")
        
        completionHandler([.badge,.sound,.alert]);
        
        
    }
    //==================================================
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //系统自带推送
        //iOS10特有
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            // 必须写代理，不然无法监听通知的接收与点击
            center.delegate = self
            
            center.requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted, error) in
                
                if granted {
                    
                    print("注册成功")
                    center.getNotificationSettings(completionHandler: { (settings) in
                        print(settings)
                    })
                    
                }else{
                    print("注册失败")
                }
                
            })
            

        } else if #available(iOS 8.0, *){
            
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil))

        }else{
        
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil))
            
        }
        
        application.registerForRemoteNotifications()
        application.applicationIconBadgeNumber = 0
        
        
        
        
        //极光推送
//      ,JPUSHRegisterDelegate
 
//
//        //通知类型（这里将声音、消息、提醒角标都给加上）
//        let userSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
//                                                    categories: nil)
//        let version = UIDevice.current.systemVersion
//        let arr = version.components(separatedBy: ".")
//        if (Double(arr[0])! >= 8.0) {
//            //可以添加自定义categories
//            JPUSHService.register(forRemoteNotificationTypes: userSettings.types.rawValue,
//                                  categories: nil)
//        }else {
//            //categories 必须为nil
//            JPUSHService.register(forRemoteNotificationTypes: userSettings.types.rawValue,
//                                  categories: nil)
//        }
//        
//        // 启动JPushSDK
//        JPUSHService.setup(withOption: nil, appKey: "efc43d539a8ece1f5d644f8d",
//                           channel: "Publish Channel", apsForProduction: false)
        
        return true
    }
    
    
//    //MARK:JPush加入的方法
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        JPUSHService.registerDeviceToken(deviceToken)
//    }
//    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        JPUSHService.handleRemoteNotification(userInfo)
//        completionHandler(UIBackgroundFetchResult.newData)
//    }
//    func application(_ application: UIApplication,
//                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        //可选
//        NSLog("did Fail To Register For Remote Notifications With Error: \(error)")
//    }
//    
//    //MARK: - JPUSHRegisterDelegate
//    @available(iOS 10.0, *)
//    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
//        
//    }
//    
//    
//    @available(iOS 10.0, *)
//    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
//        
//    }
    
    
    
        
        
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

    func showMask(){
        if view == nil{
            view = UIView()
            view!.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 64)
            view!.backgroundColor = UIColor.black
            view!.alpha = 0.5
            self.window!.addSubview(view!)
        }
    }
    func dismissMask(){
        if let _ = view{
            view!.removeFromSuperview()
            view = nil
        }
    }

    
    
    
    
    
}

