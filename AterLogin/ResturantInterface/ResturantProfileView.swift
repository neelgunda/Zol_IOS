//
//  ResturantProfileView.swift
//  Zol
//
//  Created by apple on 11/10/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct ResturantProfileView: View {
    let textArray = ["Scanned Cards", "Privacy Policy", "Terms of service","Logout"]
    let imageArray = ["Vector 4", "shield (2) 2", "Vector-1 1","Vector-5"]
    @StateObject var userViewModel = UserViewModel()
    @State private var willMoveToMyCardView: Bool = false
    
    @State private var willMoveToHelpandFeedbackView: Bool = false
    @State private var willMoveToEditProfileView: Bool = false
    @State private var isAlert = false
    @State private var willMoveToWedView:Bool = false
    @State var Url : String = ""
    @State var title : String = ""
    
    var body: some View {
        ZStack{
            VStack {                
                Text("Profile").font(Font.custom("Poppins-SemiBold", size: 30)).textCase(.none).foregroundColor(Color.black).frame(minWidth: 15, maxWidth: .infinity,alignment: .leading).padding([.top,.leading], 15).frame(height:50)
                
                List {
                    Section(header:
                                ResturantProfileHeaderView(userModel:  self.userViewModel.userDetailModel ?? UserModel())
                    ) {
                        ForEach(0..<self.textArray.count, id: \.self) { each in
                            if each != 0{
                                ProfileCellView(cellImage: imageArray[each], tileText: self.textArray[each]).tag(each).onTapGesture {
                                    switch each{
                                    case 0 :
                                        return
                                    case 1 :
                                        self.title = "Privacy Policy"
                                        self.Url = "https://zol-tech.com/Webservices/privacy_policy.php"
                                        self.willMoveToWedView = true
                                        return
                                    case 2 :
                                        self.title = "Terms of service"
                                        self.Url = "https://zol-tech.com/Webservices/term_and_condition.php"
                                        self.willMoveToWedView = true
                                        
                                        return
                                    case 3 :
                                        self.isAlert = true
                                        return
                                    default:
                                        return
                                    }
                                }
                            }
                            else{
                                HStack{
                                    ProfileCellView(cellImage: imageArray[each], tileText: self.textArray[each]).tag(each)
                                    Spacer()
                                    if self.userViewModel.scannedCount != ""{
                                        Text(self.userViewModel.scannedCount).font(Font.custom("Poppins-Regular", size: 11)) .padding(5).background(Color("#3DEE98")).clipShape(Circle())
                                    }
                                }
                            }
                        }.listRowSeparator(.hidden).listRowSeparatorTint(.clear)
                    }
                }.modifier(ListBackgroundModifier()).listStyle(.grouped).onAppear {
                    self.userViewModel.fetchRestaurantDetail()
                }.navigationBarHidden(true).navigationBarTitleDisplayMode(.inline)
            }
            ActivityIndicatorView(isVisible: self.$userViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98")).frame(width: 50.0, height: 50.0)
            
        }.navigationBarTitleDisplayMode(.inline).navigationBarHidden(true).navigationBarHidden(true).navigationBarTitleDisplayMode(.inline).alert(isPresented: $isAlert) { () -> Alert in
            Alert(title: Text("Zol"), message: Text("Are you sure to logout?"), primaryButton: .destructive(Text("No")), secondaryButton: .default(Text("Yes"),action: {
                self.userViewModel.logout()
            }))}.navigationDestination(isPresented: self.$willMoveToWedView) {
            WebView(url: self.Url, title: self.title)
        }
    }
}
