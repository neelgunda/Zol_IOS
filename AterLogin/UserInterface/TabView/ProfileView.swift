//
//  ProfileView.swift
//  Zol
//
//  Created by apple on 30/08/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct ProfileView: View {
    let textArray = ["Help and Feedback","Change Password", "My cards","Share the app","Delete Account","About us","Logout"]
    let imageArray = ["Group 11","Lock", "Group-3", "Vector-6","deleteUser","Group-2","Vector-5"]
    @StateObject var userViewModel = UserViewModel()
    @State private var willMoveToMyCardView: Bool = false
    @State private var willMoveToChangePasswordView: Bool = false
    @State private var willMoveToHelpandFeedbackView: Bool = false
    @State private var willMoveToEditProfileView: Bool = false
    @State private var willMoveToShareView: Bool = false
    @State private var isAlert = false
    @State var isDelete = false
    @State private var willMoveToWedView:Bool = false
    
    var body: some View {
          NavigationStack{
            ZStack{
                VStack {
                    Text("Profile").font(Font.custom("Poppins-SemiBold", size: 30)).textCase(.none).foregroundColor(Color.black).frame(minWidth: 15, maxWidth: .infinity,alignment: .leading).padding([.top,.leading], 15).frame(height:50)
                    List {
                        Section(header:
                                    ProfileHeaderView(userModel:  self.userViewModel.userDetailModel ?? UserModel(), willMoveToEditProfileView: $willMoveToEditProfileView)
                        ) {
                            ForEach(0..<self.textArray.count, id: \.self) { each in
                                ProfileCellView(cellImage: imageArray[each], tileText: self.textArray[each]).tag(each).onTapGesture {
                                    switch each{
                                    case 0 :
                                        self.willMoveToHelpandFeedbackView = true
                                        return
                                    case 1 :
                                        self.willMoveToChangePasswordView = true
                                        return
                                    case 2:
                                        self.willMoveToMyCardView = true
                                        return
                                    case 3 :
                                        self.willMoveToShareView = true
                                        return
                                    case 4 :
                                        self.isAlert = true
                                        self.isDelete = true
                                        return
                                    case 5 :
                                        self.willMoveToWedView = true
                                        return
                                    case 6 :
                                        self.isDelete = false
                                        self.isAlert = true
                                        return
                                    default:
                                        return
                                    }
                                }
                            }
                        }.listRowSeparator(.hidden).listRowSeparatorTint(.clear)
                    }.listStyle(.grouped).modifier(ListBackgroundModifier()).onAppear {
                        self.userViewModel.fetchUserDetail()
                    }
                }.navigationBarHidden(true).navigationBarTitleDisplayMode(.inline)
                ActivityIndicatorView(isVisible: self.$userViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98")).frame(width: 50.0, height: 50.0)
            }
            .alert(isPresented: self.$isAlert) { () -> Alert in
                if self.isDelete == true{
                    return Alert(title: Text("Zol"), message: Text("Are you sure you want to delete?"), primaryButton: .destructive(Text("No")), secondaryButton: .default(Text("Yes"),action: {
                        self.userViewModel.deleteAccount()
                    }))
                }
                else{
                    return  Alert(title: Text("Zol"), message: Text("Are you sure to logout?"), primaryButton: .destructive(Text("No")), secondaryButton: .default(Text("Yes"),action: {
                        self.userViewModel.logout()
                    }))
                }
            }
        }
        .navigationDestination(isPresented: self.$willMoveToMyCardView) {
            MyCardView()
        }.navigationDestination(isPresented: self.$willMoveToChangePasswordView) {
            ChangePasswordView()
        }.navigationDestination(isPresented: self.$willMoveToHelpandFeedbackView) {
            HelpandFeedbackView()
        }.navigationDestination(isPresented: self.$willMoveToEditProfileView) {
            EditProfileView(userModel: self.userViewModel.userDetailModel  ?? UserModel())
        }.navigationDestination(isPresented: self.$willMoveToShareView) {
            ShareTheAppView()
        }.navigationDestination(isPresented: self.$willMoveToWedView) {
            WebView(url: "https://www.zolcard.com", title: "About us")
        }
    }
}
