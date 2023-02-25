//
//  TabBarView.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 05/12/2022.
//

import SwiftUI

struct TabBarView: View {
    ///
    /// A property wrapper type that reflects a value from UserDefaults and invalidates
    /// a view on a change in value in that user default
    ///
    @AppStorage("selectedTab") var selectedTab: TabEnum = .home
    
    @State var color: Color = .teal
    ///
    /// we will use this variable so set the width od the background and the horizontal shape for each tab item
    ///
    @State var tabItemWidth: CGFloat = 0
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Button {
                withAnimation(
                    .spring(response: 0.3, dampingFraction: 0.7)
                ) {
                    ///
                    /// change the state variable so we can use the new change for displaying different screen
                    ///
                    selectedTab = item.tab
                    color = item.color
                }
            } label: {
                VStack(spacing: 0) {
                    Image(systemName: item.icon)
                        .symbolVariant(.fill)
                        .font(.body.bold())
                        .frame(width: 44, height: 29)
                    Text(item.text)
                        .font(.caption2)
                        .lineLimit(1)
                }
                ///
                /// to adjust the width of every tab bar item
                ///
                .frame(maxWidth: .infinity)
            }
            .foregroundStyle(
                selectedTab == item.tab ? .primary : .secondary
            )
            .blendMode(selectedTab == item.tab ? .overlay : .normal)
            .overlay(
                ///
                /// - A container view that defines its content as a function of its own size and coordinate space
                /// - putting this geometry on top of the button to get the width of the button dynamically
                ///
                GeometryReader { proxy in
                    ///
                    /// store the width of the button dynamically in preference key
                    ///
                    Color.clear.preference(key: TabPreferenceKey.self, value: proxy.size.width)
                }
            )
            ///
            /// when the stored preference key changes give the new value to the state variable
            ///
            .onPreferenceChange(TabPreferenceKey.self) { value in
                tabItemWidth = value
            }
        }
    }
    
    var background: some View {
        ///
        /// background color behind each tab bar item
        ///
        HStack {
            if selectedTab == .library {
                Spacer()
            }
            
            if selectedTab == .explore {
                Spacer()
            }
            
            if selectedTab == .notifications {
                Spacer()
                Spacer()
            }
            
            Circle()
                .fill(color)
                .frame(width: tabItemWidth)
            
            if selectedTab == .home {
                Spacer()
            }
            
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            
            if selectedTab == .notifications {
                Spacer()
            }
        }
        .padding(.horizontal, 8)

    }
    
    var overlay: some View {
        ///
        /// the small line on top of the tab bar item
        ///
        HStack {
            if selectedTab == .library {
                Spacer()
            }
            
            if selectedTab == .explore {
                Spacer()
            }
            
            if selectedTab == .notifications {
                Spacer()
                Spacer()
            }
            
            Rectangle()
                .fill(color)
                .frame(width: 28, height: 5)
                .cornerRadius(3)
                .frame(width: tabItemWidth)
                .frame(maxHeight: .infinity, alignment: .top)
            
            if selectedTab == .home {
                Spacer()
            }
            
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            
            if selectedTab == .notifications {
                Spacer()
            }
        }
        .padding(.horizontal, 8)
    }
    
    var body: some View {
        GeometryReader { proxy in
            ///
            /// - if this is true then the current device has a home indicator in the bottom
            /// - bottom is for the home indicator and top is for the notch
            ///
            let hasHomeIndicator = proxy.safeAreaInsets.bottom > 20
            
            ///
            /// this is a custom tab bar instead of using the tabview
            ///
            HStack {
                buttons
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: hasHomeIndicator ? 88 : 62, alignment: .top)
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: hasHomeIndicator ? 34 : 0, style: .continuous)
            )
            .background(background)
            .overlay(overlay)
            .strokeStyle(cornerRadius: hasHomeIndicator ? 34 : 0)
            ///
            /// alignment bottom cause it's the tabbar it has to be at the bottom
            ///
            .frame(maxHeight: .infinity, alignment: .bottom)
            ///
            /// for this to work, the hstack has to take the full height of the screen
            ///
            .ignoresSafeArea()
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
