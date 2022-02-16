//
//  UIKitView.swift
//  SwiftUITouchHandling
//
//  Created by Armin Ahmadi on 16/2/2022.
//

import SwiftUI

final class UIKitView: UIView {

    init() {

        let swiftUIView = SwiftUIView()
        let uiView = UIHostingController(rootView: swiftUIView).view!
        uiView.backgroundColor = .clear

        super.init(frame: .zero)

        addSubview(uiView)
        uiView.frame = CGRect(x: 150, y: 150, width: 150, height: 150)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Passing the touch to the below layer if its not hitting one of its subviews
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let swiftUISubviews = subviews.first?.subviews else {
            return false
        }
        if swiftUISubviews.contains(where: {
            $0.alpha > 0.01 &&
            !$0.isHidden &&
            $0.isUserInteractionEnabled &&
            $0.point(inside: self.convert(point, to: $0), with: event)
        }) {
            return true
        }
        return false
    }
}
