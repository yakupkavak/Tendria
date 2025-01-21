//
//  ShapeTestUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 18.01.2025.
//

import SwiftUI

struct ShapeTestUI: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WaterShape: Shape {
    var startPointX: Double
    var startPointY: Double

    init(startPointX: Double, startPointY: Double) {
        self.startPointX = startPointX
        self.startPointY = startPointY
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            var height = rect.height
            var width = rect.width
            path.move(to: CGPoint(x: rect.width * startPointX, y: rect.height * startPointY))

            path.addQuadCurve(
                to: CGPoint(x: rect.height * 0.125, y: rect.midY),
                control: CGPoint(x: rect.width * 0.125, y: rect.height * 0.4)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX * 0.4, y: rect.midY * 0.9),
                control: CGPoint(x: rect.width * 0.2, y: rect.height * 0.6)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX * 0.65, y: rect.midY * 0.9),
                control: CGPoint(x: rect.width * 0.5, y: rect.height * 0.4)
            )
            // path.addQuadCurve(
            //    to: CGPoint(x: rect.width * 0.75, y: rect.midY),
            //   control:CGPoint(x:rect.width * 0.75, y: rect.height * 0.75))
            // path.addLine(to: CGPoint(x: rect.maxX * 0.75, y: rect.maxY))
            // path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        }
    }
}

#Preview {
    WaterShape(startPointX: 0, startPointY: 1.7)
}
