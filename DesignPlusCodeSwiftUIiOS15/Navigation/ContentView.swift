//
//  ContentView.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 19/11/2022.
//

import SwiftUI

struct ContentView: View {
    ///
    /// A property wrapper type that reflects a value from UserDefaults
    /// and invalidates a view on a change in value in that user default
    ///
    @AppStorage("selectedTab") var selectedTab: TabEnum = .home
    ///
    /// this sub view has to have this variable
    ///
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ///
            /// this is how to make custom tab bar that navigates to different screens
            ///
            switch selectedTab {
                case .home:
                    HomeView()
                case .explore:
                    AccountView()
                case .notifications:
                    AccountView()
                case .library:
                    AccountView()
            }
            
            TabBarView()
                ///
                /// this will move the tab bar away to make it hidden based on this sync variable
                /// that will be toggled from when you open each card
                ///
                .offset(y: model.showDetail ? 200 : 0)
        }
        ///
        /// to not let the content in the middle gets behind the tab bar like safe area in uikit
        ///
        .safeAreaInset(edge: .bottom) {
            Color
                .clear
                .frame(height: 44)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(Model())
        
//        ContentView()
//            .preferredColorScheme(.dark)
//            .environment(\.dynamicTypeSize, .accessibility5)
//            .previewDevice("iPhone 13 mini")
    }
}
