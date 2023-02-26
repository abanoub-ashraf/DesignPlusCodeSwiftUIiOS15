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
    @State var show = false
    @State var selectedIndex = 0
    
    @Namespace var namespace
    
    ///
    /// - a binding to the current presentation mode of the view
    ///   associated with this environment
    /// - use this env variable to dismiss the sheet we presents
    ///
    @Environment(\.presentationMode) var presentationMode
    
    var content: some View {
        ///
        /// this is to convert the courses array int an array that have index and value in it,
        /// because we need to use the index of each course to update the selected index state
        /// so we can give the proper course to the sheet when it's presented
        ///
        ForEach(Array(courses.enumerated()), id: \.offset) { index, item in
            ///
            /// this means show the filtered courses list or show the whole list of courses
            ///
            if item.title.contains(text) || text == "" {
                if index != 0 {
                    Divider()
                }
                
                Button {
                    ///
                    /// this is to show the course details for the course we clicked on in a sheet
                    ///
                    show = true
                    ///
                    /// stored the index of the course we clicked on in this state variable
                    ///
                    selectedIndex = index
                } label: {
                    HStack(alignment: .top, spacing: 12) {
                        Image(item.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .background(Color("Background"))
                            .mask(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .bold()
                                .foregroundColor(.primary)
                            
                            Text(item.text)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    content
                }
                .padding(20)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .strokeStyle(cornerRadius: 30)
                .padding(20)
                ///
                /// this background is for the navigation bar area on top
                /// because it's hard to read in the search bar
                ///
                .background(
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity, alignment: .top)
                        .blur(radius: 20)
                        .offset(y: -300)
                )
                ///
                /// this background is for the rest of the content
                ///
                .background(
                    Image("Blob 1")
                        .offset(x: -100, y: -200)
                )
            }
            ///
            /// - marks this view as searchable, which configures the display of a search field
            /// - text: the text to display and edit in the search field
            /// - placement: make the search bar always visible
            /// - prompt: placeholder for the search bar
            /// - suggestions: what shows up in the list when we start typing
            ///
            .searchable(
                text: $text,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("SwiftUI, React, UI Design"),
                suggestions: {
                    ForEach(suggestions) { suggestion in
                        Button {
                            text = suggestion.text
                        } label:{
                            Text(suggestion.text)
                                .searchCompletion(suggestion.text)
                        }
                    }
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
            ///
            /// this sheep better be outside the for loop that's inside the content, and just get the index of the selected course
            /// in a state variable and pass it to this courseview to give it the course it needs
            ///
            .sheet(isPresented: $show) {
                CourseView(show: $show, namespace: namespace, course: courses[selectedIndex])
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
//            .preferredColorScheme(.dark)
    }
}
