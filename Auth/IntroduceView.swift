//
//  IntroduceView.swift
//  Zol
//
//  Created by apple on 28/12/22.
//

import SwiftUI


class EnvironmentVariables: ObservableObject {
    @Published var currentIndexforPosts: Int = 0
}

struct IntroduceView: View {
    var imageArray = ["Image 2","Image 3","Image"]
    var titleArray = ["BUY  ZOL CARD TO GET OFFERS","EXPLORE OUR PARTNERS","SCAN QR CODE AND FEAST"]
    @StateObject  var environmentVariables = EnvironmentVariables()
    @State var userLogin:Bool = false
    @State var resturantLogin:Bool = false
    @State var title = String()
    @State var discription = String()

    var body: some View {
          NavigationStack {
            VStack {
                ScrollView(.horizontal,showsIndicators: false) {
                    ScrollViewReader { value in
                        HStack {
                            ForEach(Array(self.imageArray.enumerated()), id: \.offset) { index, element in
                                UserView(user: element).frame(width: UIScreen.screenWidth,height: UIScreen.screenWidth - 60)
                            }
                        }.padding(.top, 10).onChange(of: environmentVariables.currentIndexforPosts) { _ in
                            if environmentVariables.currentIndexforPosts >= 0 {
                                withAnimation {
                                    value.scrollTo(environmentVariables.currentIndexforPosts, anchor: .leading)
                                }
                            }
                        }
                    }
                }.isPagingEnabled().disabled(true)
                
                VStack{
                    HStack(spacing: 20){
                        Circle().frame(width: 10,height: 10).foregroundColor(Color.white)
                        if self.environmentVariables.currentIndexforPosts  >= 1{
                            Circle().frame(width: 10,height: 10).foregroundColor(Color.white)
                        }
                        else{
                            RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 1).frame(width: 10,height: 10)
                        }
                        if self.environmentVariables.currentIndexforPosts == 2{
                            Circle().frame(width: 10,height: 10).foregroundColor(Color.white)
                        }
                        else{
                            RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 1).frame(width: 10,height: 10)
                        }
                    }
                    Spacer()
                    Text(self.titleArray[environmentVariables.currentIndexforPosts]).font(Font.custom("Poppins-SemiBold", size: 22)).foregroundColor(Color.white).multilineTextAlignment(.center).padding(.vertical,5)
                    if environmentVariables.currentIndexforPosts == 0{
                        HStack(spacing: 2, content: {
                            Text("Navigate to the ").font(Font.custom("Poppins-regural", size: 20)).foregroundColor(Color.white)
                            Image("Group 17")
                        })
                    }
                    else if environmentVariables.currentIndexforPosts == 1{
                        HStack(spacing: 2, content: {
                            Text("Navigate to the ").font(Font.custom("Poppins-regural", size: 20)).foregroundColor(Color.white)
                            Image("Group 34")
                        })
                    }
                    else{
                        Text("Navigate to the \(Text(Image("Group 3"))) and click on the desired location.").font(Font.custom("Poppins-regural", size: 20)).foregroundColor(Color.white).multilineTextAlignment(.center)
                    }
                    Text("").padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity,maxHeight: 2).background((Color.white)).padding(.vertical,40)
                    HStack(spacing: 15){
                        if environmentVariables.currentIndexforPosts == 0{
                            Button(action: {
                                if environmentVariables.currentIndexforPosts < 2{
                                    environmentVariables.currentIndexforPosts += 1
                                }
                                
                            }) {
                                Text("Continue").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color.white).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity,maxHeight: 50).background((Color.clear))
                            }.overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            ).padding(.horizontal,50)
                        }
                        else{
                            
                            Button(action: {
                                if environmentVariables.currentIndexforPosts > 0{
                                    environmentVariables.currentIndexforPosts -= 1
                                }
                            }) {
                                Text("Back").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color.white).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity,maxHeight: 50).background(Color.clear)
                            }.overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            Button(action: {
                                if environmentVariables.currentIndexforPosts < 2{
                                    environmentVariables.currentIndexforPosts += 1
                                }
                                else{
                                    if AppDefaults.role == "2"{
                                        self.resturantLogin = true
                                    }
                                    else{
                                        self.userLogin = true
                                    }
                                }
                            }) {
                                Text("Continue").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color.white).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity,maxHeight: 50).background((Color.clear))
                            }.overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        }
                    }
                    
                }.padding(20)
            }.navigationBarTitleDisplayMode(.inline).navigationBarHidden(true).environmentObject(environmentVariables).background(Color("#F5F5F5").ignoresSafeArea())
        }
        .navigationDestination(isPresented: self.$resturantLogin) {
            ResturantTabBarView()
        }.navigationDestination(isPresented: self.$userLogin) {
            TabBarView()
        }
    }
}


struct UserView: View {
    let user: String
    var body: some View {
        VStack {
            Image(user).resizable().scaledToFill().padding([.all],40)
        }
    }
}

extension ScrollView {
    func isPagingEnabled() -> some View {
        modifier(ScrollViewPagingModifier())
    }
}
struct ScrollViewPagingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
    }
}
  
