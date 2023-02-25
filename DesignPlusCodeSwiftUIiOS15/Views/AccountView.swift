//
//  AccountView.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 25/11/2022.
//

import SwiftUI

struct AccountView: View {
    ///
    /// state is a vlaue that changes over time
    ///
    @State var isDeleted: Bool = false
    @State var isPinned: Bool = false
    ///
    /// sane thing we did in the search view
    ///
    @Environment(\.presentationMode) var presentationMode
    
    var profile: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                ///
                /// two colors because of the sf symbol we are using is set to have two colors by the .palette above
                ///
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(
                    Circle()
                        .fill(.ultraThinMaterial)
                )
                .background(
                    HexagonView()
                        .offset(x: -50, y: -100)
                )
                .background(
                    BlobView()
                        ///
                        /// Offset this view by the specified horizontal and vertical distances.
                        ///
                        .offset(x: 200, y: 0)
                        ///
                        /// Scales this view’s rendered output by the given amount in both the horizontal and vertical directions, relative to an anchor point.
                        ///
                        .scaleEffect(0.6)
                )
            
            Text("Abanoub Ashraf")
                .font(.title.weight(.semibold))
            
            HStack {
                Image(systemName: "location")
                    .imageScale(.large)
                
                Text("Egypt")
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()

    }
    
    var menu: some View {
        Section {
            ///
            /// takes your destentation and the label that will be clicked
            ///
            NavigationLink(destination: HomeView()) {
                Label("Settings", systemImage: "gear")
            }
            
            NavigationLink {
                ///
                /// the destination of the navigation
                ///
                Text("Billing")
            } label: {
                ///
                /// the ui that will be clicked to take us to the destination
                ///
                Label("Billing", systemImage: "creditcard")
            }
            
            NavigationLink {
                HomeView()
            } label: {
                Label("Help", systemImage: "questionmark")
            }
        }
        ///
        /// - the navigation link change the color of the entire ui element so this tint gives it the color we want
        /// - we can put this modifier under each navigation link but putting it here will be applied on all the navigation likks
        /// - in swiftui the stype for the parent will be inherited by the child as well
        ///
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
    
    var pinButton: some View {
        Button {
            isPinned.toggle()
        } label: {
            if isPinned {
                Label("Unpin", systemImage: "pin.slash")
            } else {
                Label("Pin", systemImage: "pin")
            }
        }
        .tint(isPinned ? .gray : .yellow)
    }
    
    var links: some View {
        Section {
            if !isDeleted {
                ///
                /// to open a link in safari rowser app
                ///
                Link(destination: URL(string: "https://apple.com")!) {
                    HStack {
                        Label("Website", systemImage: "house")
                        
                        Spacer()
                        
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                }
                ///
                /// swipe to left or right ro perform an action
                ///
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    ///
                    /// delete button
                    ///
                    /// the button that will perform the action
                    ///
                    Button {
                        ///
                        /// when this is true, this entire link will disappear because of the if condition
                        ///
                        isDeleted = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    ///
                    /// the tint for the button
                    ///
                    .tint(.red)
                    
                    pinButton
                }
            }
            
            Link(destination: URL(string: "https://youtube.com")!) {
                HStack {
                    Label("YouTube", systemImage: "tv")
                    
                    Spacer()
                    
                    Image(systemName: "link")
                        .foregroundColor(.secondary)
                }
            }
            .swipeActions {
                pinButton
            }
        }
        .accentColor(.primary)
        .listRowSeparator(.hidden)

    }
    
    var body: some View {
        NavigationView {
            List {
                profile
                
                menu
                
                links
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .navigationBarItems(
                trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done").bold()
                })
            )
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
