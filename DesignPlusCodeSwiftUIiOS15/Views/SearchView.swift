//
//  SearchView.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 25/02/2023.
//

import SwiftUI

struct SearchView: View {
    ///
    /// use this state variable to search
    ///
    @State var text = ""
    
    ///
    /// - a binding to the current presentation mode of the view
    ///   associated with this environment
    /// - use this env variable to dismiss the sheet we presents
    ///
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ///
                /// this means show the filtered courses list or show the whole list of courses
                ///
                ForEach(courses.filter { $0.title.contains(text) || text == "" }) { item in
                    Text(item.title)
                }
            }
            ///
            /// - marks this view as searchable, which configures the display of a search field
            /// - text: the text to display and edit in the search field
            /// - placement: make the search bar always visible
            /// - prompt: placeholder for the search bar
            /// - suggestions:
            ///
            .searchable(
                text: $text,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("SwiftUI, React, UI Design") {
                    
                }
            )
            .navigationTitle("Search")
            ///
            /// this stope the navigation title from getting inside the navigation bar area
            /// when we scroll up
            ///
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(action: {
                    ///
                    /// close the sheet we presented when we clicked on the search button from home screen
                    ///
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done").bold()
                })
            )
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
