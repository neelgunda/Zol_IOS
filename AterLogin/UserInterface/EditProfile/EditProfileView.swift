//
//  EditProfileView.swift
//  Zol
//
//  Created by apple on 30/08/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView
import SDWebImageSwiftUI
struct EditProfileView: View {
    @Environment(\.presentationMode) private var presentation
    @State var image: UIImage?
    @State private var showGallery: Bool = false
    @State private var showCamera: Bool = false
    @State private var showActionSheet: Bool = false
    @StateObject var  userViewModel = UserViewModel()
    @StateObject var userModel:UserModel
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack {
                    ZStack(alignment:.trailing){
                        if self.image != nil{
                            Image(uiImage: self.image!).resizable().scaledToFill().frame(width: 154, height: 154, alignment: .center).cornerRadius(77.5, antialiased: true).padding(.bottom, 7)
                        }
                        else{
                            WebImage(url: URL(string: self.userModel.image ?? ""),options: .continueInBackground).placeholder(Image("ic_profile_ph").resizable()).resizable().scaledToFill().frame(width: 154, height: 154, alignment: .center).cornerRadius(77.5, antialiased: true).padding(.bottom, 7)
                        }
                        Button(action: {
                            self.showActionSheet = true
                        }) {
                            Image("Group 36").resizable().padding(.bottom, 7)
                        }.frame(width: 41, height: 47).padding(.top,90).padding(.trailing,-5)
                    }.padding(.vertical,30)
                    
                    Text("First Name").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 25).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        TextField("First Name", text: self.$userModel.first_name)
                            .padding(.horizontal, 15.0)
                            .frame(height: 50.0)
                            .keyboardType(.alphabet)
                            .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                    }.padding(.horizontal, 15).padding(.bottom, 20)
                    
                    Text("Last Name").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 25).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        TextField("Last Name", text: self.$userModel.last_name)
                            .padding(.horizontal, 15.0)
                            .frame(height: 50.0)
                            .keyboardType(.alphabet)
                            .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                    }.padding(.horizontal, 15).padding(.bottom, 20)
                    
                    Text("Email Address").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 25).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        TextField("Email", text: self.$userModel.email)
                            .padding(.horizontal, 15.0)
                            .frame(height: 50.0)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18)).disabled(true)
                    }.padding(.horizontal, 15).padding(.bottom, 20)
                    
                    
                    
                    Text("Phone Number(Optional)").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 25).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        TextField("Phone Number", text: self.$userModel.phone)
                            .padding(.horizontal, 15.0)
                            .frame(height: 50.0)
                            .keyboardType(.phonePad)
                            .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                    }.padding(.horizontal, 15).padding(.bottom, 20)
                    
                    Button(action: {
                        self.userViewModel.UpdateUserDetail(userDetal: self.userModel, userImage: self.image?.pngData(), dissmissView: self.presentation)
                    }) {
                        Text("Save").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                    }.padding([.top, .leading, .trailing], 15).padding(.bottom,80)
                    
                }
                ActivityIndicatorView(isVisible: self.$userViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98"))
                    .frame(width: 50.0, height: 50.0)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image("BackIcon").padding(.leading, 5)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Edit Profile").font(Font.custom("Poppins-SemiBold", size: 26)).foregroundColor(Color.black).padding(.leading, 10.0)
                }
            }.navigationBarBackButtonHidden(true)
        }.sheet(isPresented: self.$showCamera) {
            CameraView(showCameraView: self.$showCamera, pickedImage: self.$image.toUnwrapped(defaultValue: UIImage()),sourceType: .camera)
        }
        .sheet(isPresented: self.$showGallery) {
            CameraView(showCameraView: self.$showGallery, pickedImage: self.$image.toUnwrapped(defaultValue: UIImage()),sourceType: .photoLibrary)
        }.alert("Choose image", isPresented: self.$showActionSheet) {
            Button("Camera", role: .destructive) {
                self.showCamera = true
            }
            Button("Gallery", role: nil) {
                self.showGallery = true
            }
            Button("Cancel", role: .cancel) { }
        }
    }
}


extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
