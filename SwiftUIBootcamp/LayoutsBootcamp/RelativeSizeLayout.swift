//
//  RelativeSizeLayout.swift
//  SwiftUIBootcamp
//
//  Created by Max on 04/06/2024.
//

import SwiftUI

// Article explaining Layout
// https://oleb.net/2023/swiftui-relative-size/

fileprivate struct RelativeSizeLayout: Layout {
    var relativeWidth: Double
    var relativeHeight: Double
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        assert(subviews.count == 1, "expects a single subview")
        let resizedProposal = ProposedViewSize(
            width: proposal.width.map { $0 * relativeWidth },
            height: proposal.height.map { $0 * relativeHeight }
        )
        return subviews[0].sizeThatFits(resizedProposal)
    }
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        assert(subviews.count == 1, "expects a single subview")
        let resizedProposal = ProposedViewSize(
            width: proposal.width.map { $0 * relativeWidth },
            height: proposal.height.map { $0 * relativeHeight }
        )
        subviews[0].place(
            at: CGPoint(x: bounds.midX, y: bounds.midY),
            anchor: .center,
            proposal: resizedProposal
        )
    }
}

extension View {
    public func relativeProposed(width: Double = 1, height: Double = 1) -> some View {
        RelativeSizeLayout(relativeWidth: width, relativeHeight: height) {
            VStack {
                self
            }
        }
    }
}

struct RelativeFrame: View {
    @State private var multiplier: Double = 0.5
    
    var body: some View {
        ZStack {
            Color.clear
            GeometryReader(content: { geometry in
                Image("image 1")
                    .resizable()
                    .relativeProposed(height: multiplier)
            })
        }
        .overlay(alignment: .bottom) {
            Slider(value: $multiplier, in: 0.0...1.0)
                .padding()
        }
    }
}


#Preview {
    RelativeFrame()
}
