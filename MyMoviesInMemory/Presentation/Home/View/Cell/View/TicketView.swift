//
//  TicketView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/12.
//

import UIKit

final class TicketView: UIView {
    
    // MARK: - Constants
    
    private enum Design {
        static let punchHoleRadius: CGFloat = 14.0
        static let firstSectionRatio: CGFloat = 0.6
        static let secondSectionRatio: CGFloat = 0.85
        static let lineDashLength: CGFloat = 10
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("No storyboard here")
    }
    
    // MARK: - Override Methods
    
    override func draw(_ rect: CGRect) {
        let height = self.bounds.height
        let width = self.bounds.width
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(
            x: 0,
            y: height * Design.firstSectionRatio - Design.punchHoleRadius)
        )
        path.addArc(
            withCenter: CGPoint(x: 0, y: height * Design.firstSectionRatio),
            radius: Design.punchHoleRadius,
            startAngle: CGFloat(Double.pi + Double.pi / 2),
            endAngle: CGFloat(Double.pi / 2),
            clockwise: true
        )
        path.addLine(to: CGPoint(
            x: 0,
            y: height * Design.secondSectionRatio - Design.punchHoleRadius)
        )
        path.addArc(
            withCenter: CGPoint(x: 0, y: height * Design.secondSectionRatio),
            radius: Design.punchHoleRadius,
            startAngle: CGFloat(Double.pi + Double.pi / 2),
            endAngle: CGFloat(Double.pi / 2),
            clockwise: true
        )
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(
            x: width,
            y: height * Design.secondSectionRatio + Design.punchHoleRadius)
        )
        path.addArc(
            withCenter: CGPoint(x: width, y: height * Design.secondSectionRatio),
            radius: Design.punchHoleRadius,
            startAngle: CGFloat(Double.pi / 2),
            endAngle: CGFloat(Double.pi + Double.pi / 2),
            clockwise: true
        )
        path.addLine(to: CGPoint(
            x: width,
            y: height * Design.firstSectionRatio + Design.punchHoleRadius)
        )
        path.addArc(
            withCenter: CGPoint(x: width, y: height * Design.firstSectionRatio),
            radius: Design.punchHoleRadius,
            startAngle: CGFloat(Double.pi / 2),
            endAngle: CGFloat(Double.pi + Double.pi / 2),
            clockwise: true
        )
        path.addLine(to: CGPoint(x: width, y: 0))
        path.close()
        UIColor.MWhite?.set()
        path.fill()
        
        let dotLine = UIBezierPath()
        dotLine.move(to: CGPoint(
            x: Design.punchHoleRadius,
            y: height * Design.firstSectionRatio)
        )
        dotLine.addLine(to: CGPoint(
            x: width - Design.punchHoleRadius,
            y: height * Design.firstSectionRatio)
        )
        dotLine.move(to: CGPoint(
            x: Design.punchHoleRadius,
            y: height * Design.secondSectionRatio)
        )
        dotLine.addLine(to: CGPoint(
            x: width - Design.punchHoleRadius,
            y: height * Design.secondSectionRatio)
        )
        dotLine.setLineDash(
            [Design.lineDashLength, Design.lineDashLength],
            count: 2,
            phase: 0
        )
        UIColor.systemGray4.set()
        dotLine.stroke()
    }
    
    // MARK: - Methods
    
    private func configureView() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = Design.punchHoleRadius
        self.clipsToBounds = true
        
        self.layer.shadowColor = UIColor.systemGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = .zero
    }
}

