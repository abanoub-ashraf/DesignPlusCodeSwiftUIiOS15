//
//  NavigationBar.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 03/01/2023.
//

import SwiftUI

struct NavigationBar: View {
    var title = ""
    
    ///
    /// use this state to show the search view in a sheet
    ///
    @State var showSearch = false
    ///
    /// use this to go to the account view
    ///
    @State var showAccount = false
    ///
    /// bind the state it was set frome home view to here
    ///
    @Binding var hasScrolled: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                ///
                /// based on this state we will fade only the background of the zstack
                ///
                .opacity(hasScrolled ? 1 : 0)
            
            Text(title)
                ///
                /// to animate this title font
                ///
                .animatableFont(
                    size: hasScrolled ? 22 : 34,
                    weight: .bold
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
                ///
                /// move the title up a bit based on this state
                ///
                .offset(y: hasScrolled ? -4 : 0)
            
            HStack(spacing: 16) {
                Button {
                    showSearch = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.body.weight(.bold))
                        .frame(width: 36, height: 36)
                        .foregroundColor(.secondary)
                        .background(
                            .ultraThinMaterial,
                            in: RoundedRectangle(cornerRadius: 14, style: .continuous)
                        )
                        .strokeStyle(cornerRadius: 14)
                }
                ///
                /// when this state variable changes, we will present the search view in a sheet
                ///
                .sheet(isPresented: $showSearch) {
                    SearchView()
                }
                
                Button {
                    showAccount = true
                } label: {
                    Image("Avatar Default")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .cornerRadius(10)
                        .padding(8)
                        .background(
                            .ultraThinMaterial,
                            in: RoundedRectangle(cornerRadius: 18, style: .continuous)
                        )
                        .strokeStyle(cornerRadius: 18)
                }
                ///
                /// when this state variable changes, we will show the account view in a sheet
                ///
                .sheet(isPresented: $showAccount) {
                    AccountView()
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .padding(.top, 20)
            ///
            /// move the the hstack up a bit based on this state
            ///
            .offset(y: hasScrolled ? -4 : 0)
        }
        ///
        /// let the height of this navigation bar based on this state variable
        ///
        .frame(height: hasScrolled ? 44 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Featured", hasScrolled: .constant(false))
    }
}
