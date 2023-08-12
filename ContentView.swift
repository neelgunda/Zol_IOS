//
//  ContentView.swift
//  Zol
//
//  Created by apple on 26/08/22.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//          NavigationStack {
//            VStack {
//                Text("Hello World  nyfjhfhmyjfyhfr ")
//
//            }
//        }
//    }
//}

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button(
            "Here is Detail View. Tap to go back.",
            action: { self.presentationMode.wrappedValue.dismiss() }
        )
    }
}

struct RootView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: DetailView())
            { Text("I am Root. Tap for Detail View.") }
        }
    }
}

struct ContentView: View {
    var body: some View {
          NavigationStack {
            RootView()
        }
    }
}
