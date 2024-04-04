//
//  taxi_driverApp.swift
//  taxi_driver
//
//  Created by CodeForAny on 17/09/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth



class AppDelegate: NSObject, UIApplicationDelegate {
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        let _ = SocketViewModel.shared
        let _  = DBHelper.shared
                
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Auth.auth().setAPNSToken(deviceToken, type: .sandbox)
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(.noData)
            return
        }
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if Auth.auth().canHandle(url) {
            return true
            
        }
        
        return false
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        SocketViewModel.shared.socket.disconnect()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        SocketViewModel.shared.socket.connect()
    }
    
}


@main
struct taxi_driverApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var mainVM = MainViewModel.shard
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if(mainVM.showType == 0) {
                    ChangeLanguageView()
                }else if (mainVM.showType == 1) {
                    ProfileImageView()
                }else if ( mainVM.showType == 2) {
                    EditProfileView()
                }else if ( mainVM.showType == 3){
                    HomeView()
                }else if (mainVM.showType == 4) {
                    UserHomeView()
                }
            }
            
            .navigationViewStyle(.stack)
        }
        
    }
}
