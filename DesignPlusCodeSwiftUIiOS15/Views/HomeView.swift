//
//  HomeView.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 02/01/2023.
//

import SwiftUI

struct HomeView: View {
    @State var hasScrolled = false
    ///
    /// this is used for connecting two state of animation the start and the end
    ///
    @Namespace var namespace
    ///
    /// state variable for animation
    ///
    @State var show = false
    @State var showStatusBar = true
    
    var scrollDetection: some View {
        ///
        /// we will take the value of the space from the top of the screen until the beginning of the scroll view
        /// and store it in a preference key
        ///
        GeometryReader { proxy in
            Color
                .clear
                .preference(
                    key: ScrollPreferenceKey.self,
                    value: proxy.frame(in: .named("scroll")).minY
                )
        }
        ///
        /// sometimes the geometry takes a height that we don't want it to have
        ///
        .frame(height: 0)
        ///
        /// set the bool state variable based on the chagne that happens in the space we saved in the preference key
        ///
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
    }
    
    var featured: some View {
        ///
        /// this is how to make horizontal scroll list of items
        ///
        TabView {
            ForEach(courses) { course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    
                    FeaturedItemView(course: course)
                        ///
                        /// this padding is because geometry reader takes the minimum size and it clips stuff like shadows
                        ///
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
                        ///
                        /// abs to make the number always positive, cause the min x value sometimes is negative
                        ///
                        .blur(radius: abs(minX / 40))
                        ///
                        /// - ui elements that gets on top of the current ui
                        /// - this is for adding an image on top of the card
                        ///
                        .overlay {
                            Image(course.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 230)
                                .offset(x: 32, y: -80)
                                .offset(x: minX / 2)
                        }
                }
            }
        }
        .tabViewStyle(
            ///
            /// this is for hiding the pagination dots underneath
            ///
            .page(indexDisplayMode: .never)
        )
        .frame(height: 430)
        .background(
            Image("Blob 1")
                .offset(x: 250, y: -100)
        )
    }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                scrollDetection
                
                featured
                
                Text("Courses".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                if !show {
                    ///
                    /// namespace conects between two state of animation, this is the start state
                    /// and CourseView() down there is the end state
                    ///
                    CourseItemView(namespace: namespace, show: $show)
                        .onTapGesture {
                            withAnimation(.openCard) {
                                show.toggle()
                                showStatusBar = false
                            }
                        }
                }
            }
            ///
            /// to get the space from the beginning of the screen till this point of the scroll view
            ///
            /// assigns a name to the view’s coordinate space, so other code can operate on dimensions like points and sizes relative to the named space
            ///
            .coordinateSpace(name: "scroll")
            ///
            /// Shows the specified content above or below the modified view
            ///
            .safeAreaInset(edge: .top) {
                Color.clear
                    .frame(height: 70)
            }
            .overlay {
                NavigationBar(title: "Featured", hasScrolled: $hasScrolled)
            }
            
            if show {
                CourseView(namespace: namespace, show: $show)
            }
        }
        .statusBarHidden(!showStatusBar)
        ///
        /// - this adds a modifier for this view that fires an action when a specific value changes.
        /// - set the showStatusBar based on the change that happens in the show state variable
        ///
        .onChange(of: show) { newValue in
            withAnimation(.closeCard) {
                if newValue {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
