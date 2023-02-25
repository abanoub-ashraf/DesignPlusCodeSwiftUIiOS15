//
//  CourseItemView.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 17/02/2023.
//

import SwiftUI

struct CourseItemView: View {
    ///
    /// this is how to pass these variables from the caller of this view
    ///
    var namespace: Namespace.ID
    @Binding var show: Bool
    var course: Course = courses[0]
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 12) {
                Text(course.title)
                    .font(.largeTitle.weight(.bold))
                    ///
                    /// - matchedGeometryEffect should be using on individual elements
                    /// - every matchedGeometryEffect should have a unique id
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
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            ///
            /// matchedGeometryEffect should be using on individual elements
            ///
            Image(course.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .matchedGeometryEffect(id: "image\(course.id)", in: namespace)
        )
        .background(
            ///
            /// matchedGeometryEffect should be using on individual elements
            ///
            Image(course.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(course.id)", in: namespace)
        }
        .frame(height: 300)
    }
}

struct CourseItemView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseItemView(namespace: namespace, show: .constant(true))
    }
}
