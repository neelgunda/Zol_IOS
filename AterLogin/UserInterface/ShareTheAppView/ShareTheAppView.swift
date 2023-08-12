//
//  ShareTheAppView.swift
//  Zol
//
//  Created by apple on 02/09/22.
//

import Foundation
import SwiftUI
import MobileCoreServices
import FacebookShare
import FacebookCore


struct ShareTheAppView: View {
    
    @Environment(\.presentationMode) var presentation
    @State var showAlert:Bool = false
    @State var showMessage:String = ""
    var body: some View {
          NavigationStack {
            VStack(alignment: .center, spacing: 10, content: {
                Text("Invite friends to download the app").font(Font.custom("Poppins-Medium", size: 19)).multilineTextAlignment(.center).padding(.bottom, 26.0)
                Text("App download link").font(Font.custom("Poppins-Regular", size: 16)).foregroundColor(Color("#818181"))
                HStack{
                    Text("https://s54e6.app.link/nXyXB27yQtb").accentColor(Color.black).font(Font.custom("Poppins-Regular", size: 17)).lineLimit(1)
                    Text("Copy").font(Font.custom("Poppins-SemiBold", size: 16)).foregroundColor(Color("#3DEE98")).onTapGesture(count: 1) {
                        UIPasteboard.general.setValue("https://s54e6.app.link/nXyXB27yQtb",forPasteboardType: kUTTypePlainText as String)
                        self.showMessage = "Copied"
                        self.showAlert = true
                    }
                }
                .padding(.horizontal, 10.0)
                .frame(height:50).overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(style: StrokeStyle(lineWidth: 0.7, dash: [6])).foregroundColor(Color("#3DEE98"))
                )
                Text("Or").font(Font.custom("Poppins-Regular", size: 16)).padding(.vertical, 10.0).foregroundColor(Color("#818181"))
                HStack{
                    Button(action: {
                        let content = ShareLinkContent()
                        content.contentURL = URL(string: "https://s54e6.app.link/nXyXB27yQtb")!
                        let vc = ShareDialog()
                        vc.shareContent = content
                        vc.mode  = .web
                        if vc.canShow{
                            vc.show()
                        }
                    }) {
                            Image("Group 23").frame(width: 50, height: 50).padding(.trailing,13).padding(.leading,5)
                        }
                    
                    Button(action: {
                        let appScheme = "https://twitter.com/intent/tweet?url=https://s54e6.app.link/nXyXB27yQtb"
                        let appUrl = URL(string: appScheme)
                        
                        if UIApplication.shared.canOpenURL(appUrl! as URL) {
                            UIApplication.shared.open(appUrl!)
                        } else {
                            self.showMessage = "Twitter not installed"
                            self.showAlert = true
                        }}) {
                            Image("Group 24").frame(width: 50, height: 50).padding(.trailing,13).padding(.leading,5)
                        }
                    
                    Button(action: {
                        let appScheme = "https://in.pinterest.com/pin/create/button/?url=https://s54e6.app.link/nXyXB27yQtb&description=Download%20our%20app%20and%20enjoy%20latest%20offers&media=https://dharmani.com///zol///Webservices///profileimage///636e3db19a7b01668169137.png"
                        let appUrl = URL(string: appScheme)
                        
                        if UIApplication.shared.canOpenURL(appUrl! as URL) {
                            UIApplication.shared.open(appUrl!)
                        } else {
                            self.showMessage = "Pinterest not installed"
                            self.showAlert = true
                        }}) {
                            Image("Group 25").frame(width: 50, height: 50).padding(.trailing,13).padding(.leading,5)
                        }
                }
//                VStack(alignment: .leading, spacing: 25, content: {
//                    Text("How its works ?").font(Font.custom("Poppins-Medium", size: 22)).padding(.vertical, 10.0).foregroundColor(Color.black)
//
//                    HStack(spacing:20){
//                        Image("Group 26")
//                        Text("Invite your friends").foregroundColor(Color("#979797")).font(Font.custom("Poppins-Medium", size: 18))
//                    }
//
//                    HStack(spacing:20){
//                        Image("Group 27")
//                        Text("They hit the road with $10 off").foregroundColor(Color("#979797")).font(Font.custom("Poppins-Medium", size: 18))
//                    }
//
//                }).padding(.top, 20.0).frame(minWidth: 100, maxWidth: .infinity,  maxHeight: 250, alignment: .leading)
                Spacer()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                self.presentation.wrappedValue.dismiss()
                            }) {
                                Image("BackIcon").padding(.leading, 15.0)
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Share the App").font(Font.custom("Poppins-SemiBold", size: 26)).foregroundColor(Color.black).padding(.leading, 10.0)
                        }
                    }.navigationBarBackButtonHidden(true)
            }).padding([.top, .leading, .trailing], 30.0)
        }.overlay(overlayView: Toast.init(dataModel: Toast.ToastDataModel.init(title: self.showMessage, image: "checkmark"), show: self.$showAlert), show: self.$showAlert)
    }
}

