//
//  ZolApp.swift
//  Zol
//
//  Created by apple on 26/08/22.
//

import SwiftUI
import SquareInAppPaymentsSDK
import Branch
@main
struct ZolApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @State var showAlert = false
    @State var message = ""
    @State var navigationStackID = UUID()
    
    init() {
        AppDefaults.is_new = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowImage = nil
        appearance.titleTextAttributes =  [.foregroundColor: UIColor.white,.font: UIFont.init(name: "Poppins-SemiBold", size: 16) as Any]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont.init(name: "Poppins-SemiBold", size: 16) as Any]
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance =  appearance
        UINavigationBar.appearance().scrollEdgeAppearance =  appearance
        //        MARK: SANDBOX
        //        SQIPInAppPaymentsSDK.squareApplicationID = "sq0idb-QgZMD0OPPggaKzN1b3QYhg"
        //        MARK: LIVE
        SQIPInAppPaymentsSDK.squareApplicationID = "sq0idp-AokcHCXMCeE6cplRCZOASQ"
        UITableView.appearance().backgroundColor = UIColor.white
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().showsVerticalScrollIndicator = false
        
    }
    var body: some Scene {
        WindowGroup {
            if AppDefaults.token != nil{
                NavigationStack {
                    if AppDefaults.token != nil{
                        if AppDefaults.role == "2"{
                            ResturantTabBarView().onOpenURL(perform: { url in
                                Branch.getInstance().handleDeepLink(url)
                            })
                        }
                        else{
                            if AppDefaults.is_new == true{
                                IntroduceView().onOpenURL(perform: { url in
                                    Branch.getInstance().handleDeepLink(url)
                                })
                            }
                            else{
                                TabBarView().onOpenURL(perform: { url in
                                    Branch.getInstance().handleDeepLink(url)
                                })
                            }
                        }
                    }
                    else{
                        FirstView().onOpenURL(perform: { url in
                            Branch.getInstance().handleDeepLink(url)
                        })
                    }
                }.id(self.navigationStackID).onReceive(NotificationCenter.default.publisher(for: .autoLogout), perform: { _ in
                    AppDefaults.token = nil
                    AppDefaults.userName = nil
                    AppDefaults.userID = nil
                    AppDefaults.role = nil
                    AppDefaults.is_new = false
                    self.navigationStackID = UUID()
                }).onReceive(NotificationCenter.default.publisher(for: .showAlert), perform: { dict in
                    self.showAlert = true
                    self.message = dict.object as? String ?? ""
                }).overlay(overlayView: Toast.init(dataModel: Toast.ToastDataModel.init(title: self.message, image: "checkmark"), show: self.$showAlert), show: self.$showAlert)
            }
            else{
                NavigationStack {
                    FirstView().onOpenURL(perform: { url in
                        Branch.getInstance().handleDeepLink(url)
                    })
                }.id(self.navigationStackID).onReceive(NotificationCenter.default.publisher(for: .autoLogout), perform: { _ in
                    AppDefaults.token = nil
                    AppDefaults.userName = nil
                    AppDefaults.userID = nil
                    AppDefaults.role = nil
                    AppDefaults.is_new = false
                    self.navigationStackID = UUID()
                }).onReceive(NotificationCenter.default.publisher(for: .showAlert), perform: { dict in
                    self.showAlert = true
                    self.message = dict.object as? String ?? ""
                }).overlay(overlayView: Toast.init(dataModel: Toast.ToastDataModel.init(title: self.message, image: "checkmark"), show: self.$showAlert), show: self.$showAlert)
            }
        }
    }
}

extension NSNotification.Name {
    static let autoLogout = Notification.Name("autoLogout")
    static let showAlert = Notification.Name("showAlert")
}


