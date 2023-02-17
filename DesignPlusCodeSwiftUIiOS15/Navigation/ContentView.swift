//
//  ContentView.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 19/11/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: TabEnum = .home
    
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
        ContentView()
            .preferredColorScheme(.light)
        
        ContentView()
            .preferredColorScheme(.dark)
        
//        ContentView()
//            .preferredColorScheme(.dark)
//            .environment(\.dynamicTypeSize, .accessibility5)
//            .previewDevice("iPhone 13 mini")
    }
}
