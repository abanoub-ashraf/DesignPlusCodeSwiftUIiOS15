//
//  CourseView.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 17/02/2023.
//

import SwiftUI

struct CourseView: View {
    ///
    /// animate the opacity of the elements once they start appearing on the screen
    ///
    @State var appear = [false, false, false]
    @State var viewState: CGSize = .zero
    ///
    /// this is to make the drag happens on deman so we avoid the animation delay
    /// that keep happening after the card is closed already
    ///
    @State var isDraggable = true
    @Binding var show: Bool
    @EnvironmentObject var model: Model
    ///
    /// this is how to send these variables to this view from the caller site
    ///
    var namespace: Namespace.ID
    
    var course: Course = courses[0]
    
    var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(course.title)
                .font(.largeTitle.weight(.bold))
                ///
                /// - matchedGeometryEffect should be using on individual elements
                /// - matchedGeometryEffect shouldn't be used on a vstack or after a frame espcially when ther's a position/size change
                ///
                .matchedGeometryEffect(id: "title\(course.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(course.subtitle.uppercased())
                .font(.footnote.weight(.semibold))
                ///
                /// matchedGeometryEffect should be using on individual elements
                ///
                .matchedGeometryEffect(id: "subtitle\(course.id)", in: namespace)
            
            Text(course.text)
                .font(.footnote)
                .matchedGeometryEffect(id: "text\(course.id)", in: namespace)
            
            Divider()
                .opacity(appear[0] ? 1 : 0)
            
            HStack {
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
                
                Text("Taught by Meng To")
                    .font(.footnote)
            }
            .opacity(appear[1] ? 1 : 0)
        }
        .padding(20)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
        )
        .offset(y: 250)
        .padding(20)
    }
    
    var cover: some View {
        GeometryReader { proxy in
            ///
            /// we didn't use .global here because when this view is in a sheet, there's some blur that happens
            /// and we don't want that
            ///
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            ///
            /// - to expand the height as we scroll
            /// - check for greater rhan 0 becuase we don't wanna any effect when we scroll up
            ///
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .foregroundStyle(.black)
            .background(
                ///
                /// matchedGeometryEffect should be using on individual elements
                ///
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(maxWidth: 500)
                    .matchedGeometryEffect(id: "image\(course.id)", in: namespace)
                    ///
                    /// move the image as we scroll in some speed
                    ///
                    .offset(y: scrollY > 0 ? scrollY * -0.8 : 0)
            )
            .background(
                ///
                /// matchedGeometryEffect should be using on individual elements, even colors, not styles
                ///
                Image(course.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
                    ///
                    /// move the image as we scroll in some speed
                    ///
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    ///
                    /// this makes rthe background image expand in a scaled way
                    ///
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    ///
                    /// change the blur as we scroll
                    ///
                    .blur(radius: scrollY / 10)
            )
            .mask {
                ///
                /// apply the corner radius only after the loading is done
                ///
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(course.id)", in: namespace)
                    ///
                    /// move the rectangle that holds the background as we scroll in some speed
                    ///
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            }
            .overlay(
                overlayContent
                    ///
                    /// move the overlay content as we scroll in some speed
                    ///
                    .offset(y: scrollY > 0 ? scrollY * -0.6 : 0)
            )
        }
        .frame(height: 500)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Label label Label label Label label Label label Label label Label label Label label")
                .font(.title3)
                .fontWeight(.medium)
            
            Text("This course")
                .font(.title)
                .bold()
            
            Text("Label label Label label Label label Label label Label label Label label Label label Label label Label label Label label Label label")
            
            Text("Label label Label label Label label Label label Label label Label label Label label Label label Label label Label label Label label")
            
            Text("Multiplatform app")
                .font(.title)
                .bold()
            
            Text("Label label Label label Label label Label label Label label Label label Label label Label label Label label Label label Label label")
        }
        .padding(20)
    }
    
    var button: some View {
        Button {
            withAnimation(.closeCard) {
                show.toggle()
                model.showDetail.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
    
    ///
    /// this is gesture not a view
    ///
    var drag: some Gesture {
        ///
        /// these params for avoid the view to be hanging if the user dragged it in some way
        ///
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                
                ///
                /// - this makes the user only able to swip from the first 100 points of the x axis
                /// - only start swipping from the first 100 points space on the x axis
                ///
                if value.startLocation.x < 100 {
                    withAnimation(.closeCard) {
                        ///
                        /// this value will be used in all the modifiers above this one
                        ///
                        viewState = value.translation
                    }
                }
                
                ///
                /// we wanna close the card while dragging, if the space is more than 120
                ///
                if viewState.width > 120 {
                    close()
                }
            }
            .onEnded { value in
                ///
                /// close the card if the dragging kept on going for space that's more than 80 points
                /// otherwise put the view back as it was
                ///
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.closeCard) {
                        viewState = .zero
                    }
                }
            }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    
    func close() {
        withAnimation(.closeCard.delay(0.3)) {
            show.toggle()
            model.showDetail.toggle()
        }
        
        withAnimation(.closeCard) {
            viewState = .zero
        }
        
        isDraggable = false
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
                    .offset(y: 120)
                    .padding(.bottom, 200)
                    .opacity(appear[2] ? 1 : 0)
            }
            .coordinateSpace(name: "scroll")
            ///
            /// these 2 modifiers is because when this view show up it toggles shoing the tab bar  and we don't want that
            ///
            .onAppear {
                model.showDetail = true
            }
            .onDisappear {
                model.showDetail = false
            }
            .background(Color("Background"))
            ///
            /// to have corner radius for the entire view after we drag and the scale efect started
            ///
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
            ///
            /// shadow for after the scale effect started after the drag
            ///
            .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
            ///
            /// using the value we got from the drag gesture, we will change the scale for however we want
            ///
            .scaleEffect(viewState.width / -500 + 1)
            ///
            /// has to be after the scale effect cause it's a background for after the scale is applied
            ///
            .background(.black.opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            ///
            /// - when we drag we get the value of that drag and hold it into state variable
            ///   so we can use it for the scale affect above it
            /// - this variable is to make the drag on demand so we avoid the delay in the animation
            ///   that still happens after the card is already closed
            ///
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()
            
            button
        }
        .onAppear {
            ///
            /// animate this array in different timing for the elemnts to show up
            /// in different timing
            ///
            fadeIn()
        }
        ///
        /// to animate the close state of the course view when then valuse of show changes
        ///
        .onChange(of: show) { newValue in
            fadeOut()
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseView(show: .constant(true), namespace: namespace)
            .environmentObject(Model())
    }
}
