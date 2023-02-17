//
//  HexagonView.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 02/12/2022.
//

import SwiftUI

struct HexagonView: View {
    var body: some View {
        ///
        /// A view type that supports immediate mode drawing.
        ///
        /// context allows us to draw the graphics and the size gives us the size of the actual canvas
        ///
        Canvas { context, size in
            context.draw(
                Text("DesignCode")
                    .font(.largeTitle),
                at: CGPoint(x: 50, y: 20)
            )
            context.fill(
                Path(ellipseIn: CGRect(x: 20, y: 30, width: 100, height: 100)),
                with: .color(.pink)
            )
            context.draw(
                Image("Blob 1"),
                in: CGRect(x: 0, y: 0, width: 200, height: 200)
            )
            context.draw(
                Image(systemName: "hexagon.fill"),
                in: CGRect(x: 0, y: 0, width: size.width, height: size.height)
            )
        }
        .frame(width: 200, height: 212)
        .foregroundStyle(
            .linearGradient(
                colors: [.pink, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}

struct HexagonView_Previews: PreviewProvider {
    static var previews: some View {
        HexagonView()
    }
}
