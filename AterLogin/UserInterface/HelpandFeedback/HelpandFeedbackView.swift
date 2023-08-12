//
//  HelpandFeedbackView.swift
//  Zol
//
//  Created by apple on 01/09/22.
//

import Foundation
import SwiftUI

struct HelpandFeedbackView: View {
    var dataArray:[HelpandFeedbackModel] = [HelpandFeedbackModel(title: "Help", row: [HelpandFeedbackFieldModel(text: "FAQ", image: "faq (3) 1"),HelpandFeedbackFieldModel(text: "Contact Support", image: "customer-support (2) 1")]),HelpandFeedbackModel(title: "Feedback", row: [HelpandFeedbackFieldModel(text: "Give Feedback", image: "Vector-11")]),HelpandFeedbackModel(title: "About", row: [HelpandFeedbackFieldModel(text: "Privacy Policy", image: "shield (2) 1"),HelpandFeedbackFieldModel(text: "Terms of service", image: "Vector-10")])]
    
    @Environment(\.presentationMode) var presentation
    @State private var willMoveToFeedbackView: Bool = false
    @State private var willMoveToContactView: Bool = false
    @State var Url : String = ""
    @State var title : String = ""
    @State private var willMoveToWedView:Bool = false

    var body: some View {
          NavigationStack {
            List {
                ForEach(0..<self.dataArray.count, id: \.self) { each in
                    Section(header:
                                HelpandFeedbackHeightView(title: self.dataArray[each].title)
                    ){
                        ForEach(0..<self.dataArray[each].row.count, id: \.self) { index in
                            HelpandFeedbackCellView(cellImage: self.dataArray[each].row[index].image ?? "", tileText: self.dataArray[each].row[index].text ?? "").onTapGesture {
                                if each == 0 {
                                    if index == 0{
                                        if let url = URL(string: "https://www.zolcard.com") {
                                            UIApplication.shared.open(url)
                                        }
                                        print("Its FAQ")
                                    }else{
                                        self.willMoveToContactView = true
                                    }
                                }else  if each == 1{
                                    if index == 0{
                                        self.willMoveToFeedbackView = true
                                    }else{
                                        print("Its FAQ")
                                    }
                                } else if each == 2{
                                    if index == 0{
                                        self.title = "Privacy Policy"
                                        self.Url = "https://zol-tech.com/Webservices/privacy_policy.php"
                                        self.willMoveToWedView = true
                                        print("Its Privacy")
                                    }else{
                                        print("Its terms of services")
                                        self.title = "Terms of service"
                                        self.Url = "https://zol-tech.com/Webservices/term_and_condition.php"
                                        self.willMoveToWedView = true
                                    }
                                }
                            }
                        }
                    }.listRowSeparatorTint(.clear)
                    
                    
                }
            }.modifier(ListBackgroundModifier()).onAppear {
                    UITableView.appearance().sectionHeaderTopPadding = 0                
            }.padding([.leading,.top], 10).listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.presentation.wrappedValue.dismiss()
                        }) {
                            Image("BackIcon").padding(.leading, 5)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Help and Feedback").font(Font.custom("Poppins-SemiBold", size: 26)).foregroundColor(Color.black).padding(.leading, 15)
                    }
                }.navigationBarBackButtonHidden(true)
        }.navigationDestination(isPresented: self.$willMoveToFeedbackView) {
            FeedbackView()
        }.navigationDestination(isPresented: self.$willMoveToContactView) {
            ContactSupportView()
        }.navigationDestination(isPresented: self.$willMoveToWedView) {
            WebView(url: self.Url, title: self.title)
        }
    }
}

