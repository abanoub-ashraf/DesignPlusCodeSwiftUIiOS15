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
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 12) {
                Text("SwiftUI")
                    .font(.largeTitle.weight(.bold))
                    ///
                    /// matchedGeometryEffect should be using on individual elements
                    ///
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("20 Sections - 3 hours".uppercased())
                    .font(.footnote.weight(.semibold))
                    ///
                    /// matchedGeometryEffect should be using on individual elements
                    ///
                    .matchedGeometryEffect(id: "subtitle", in: namespace)
                
                Text("Build an iOS app for iOS 15 with custom layouts, animations and ...")
                    .font(.footnote)
                    .matchedGeometryEffect(id: "text", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur", in: namespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            ///
            /// matchedGeometryEffect should be using on individual elements
            ///
            Image("Illustration 9")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "image", in: namespace)
        )
        .background(
            ///
            /// matchedGeometryEffect should be using on individual elements
            ///
            Image("Background 5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }
        .frame(height: 300)
        .padding(20)
    }
}

struct CourseItemView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseItemView(namespace: namespace, show: .constant(true))
    }
}
