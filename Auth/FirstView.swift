//
//  FirstView.swift
//  Zol
//
//  Created by apple on 28/12/22.
//

import SwiftUI

struct FirstView: View {
    @State var moveToCreateAccountView = false
    @State var moveToLoginView = false
    
    var body: some View {
          NavigationStack {
            ZStack(alignment: .center){
                VStack(alignment: .center,spacing: -20){
                    Image("lgog 1").resizable().scaledToFill().frame(width: 210, height: 200)
                    Text("Feastin’ like its Free").font(Font.custom("Poppins-Regular", size: 24))
                }.padding(.bottom ,120)
                VStack(spacing: 20){
                    Spacer()
                    Button(action: {
                        self.moveToCreateAccountView = true
                    }) {
                        Text("Get Started").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color.white).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                    }
                    
                    Button(action: {
                        self.moveToLoginView = true
                    }) {
                        Text("Already Have an Account").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color.white).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                    }.padding(.bottom, 30.0)
                    
                }.padding([.leading, .trailing], 30.0)
            }.navigationBarHidden(true)
        }
        .navigationDestination(isPresented: self.$moveToCreateAccountView) {
            SignUpContentView(comingFrom: "FirstView")
        }.navigationDestination(isPresented: self.$moveToLoginView) {
            LoginContentView()
        }
    }
}

