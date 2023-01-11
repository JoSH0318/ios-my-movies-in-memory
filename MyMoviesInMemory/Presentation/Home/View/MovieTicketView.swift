//
//  MovieTicketView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/12.
//

import UIKit

final class MovieTicketView: UIView {
    
    // MARK: - Constants
    
    private enum Design {
        static let punchHoleRadius: CGFloat = 14.0
        static let midPointScale: Double = 0.7
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("No storyboard here")
    }
    
    // MARK: - Override Methods
    
    override func layoutSubviews() {
        drawTicket()
    }
    
    // MARK: - Draw Method
    
    private func drawTicket() {
        let ticketShapeLayer = CAShapeLayer()
        ticketShapeLayer.frame = self.bounds
        ticketShapeLayer.fillColor = UIColor.MBeige?.cgColor

        let ticketShapePath = UIBezierPath(rect: ticketShapeLayer.bounds)

        let topLeftArcPath = UIBezierPath()
        topLeftArcPath.move(to: CGPoint(x: 0, y: 0))
        topLeftArcPath.addLine(to: CGPoint(x: Design.punchHoleRadius, y: 0))
        topLeftArcPath.addArc(
            withCenter: CGPoint(x: 0, y: 0),
            radius: Design.punchHoleRadius,
            startAngle: CGFloat(0.0),
            endAngle: CGFloat(Double.pi / 2),
            clockwise: true
        )
        topLeftArcPath.close()
        
        let topRightArcPath = UIBezierPath()
        topRightArcPath.move(to: CGPoint(x: self.bounds.width, y: 0))
        topRightArcPath.addLine(to: CGPoint(x: self.bounds.width - Design.punchHoleRadius, y: 0))
        topRightArcPath.addArc(
            withCenter: CGPoint(x: self.bounds.width, y: 0),
            radius: Design.punchHoleRadius,
            startAngle: CGFloat(Double.pi),
            endAngle: CGFloat(Double.pi / 2),
            clockwise: false
        )
        topRightArcPath.close()
        
        let midLeftArcPath = UIBezierPath(
            arcCenter: CGPoint(x: 0, y: self.bounds.height * Design.midPointScale),
            radius: Design.punchHoleRadius,
            startAngle:  CGFloat(Double.pi / 2),
            endAngle: CGFloat(Double.pi + Double.pi / 2),
            clockwise: false
        )
        midLeftArcPath.close()

        let midRightArcPath = UIBezierPath(
            arcCenter: CGPoint(x: self.bounds.width, y: self.bounds.height * Design.midPointScale),
            radius: Design.punchHoleRadius,
            startAngle:  CGFloat(Double.pi / 2),
            endAngle: CGFloat(Double.pi + Double.pi / 2),
            clockwise: true
        )
        midRightArcPath.close()
        
        let bottomLeftArcPath = UIBezierPath()
        bottomLeftArcPath.move(to: CGPoint(x: 0, y: self.bounds.height))
        bottomLeftArcPath.addLine(to: CGPoint(x: 0, y: self.bounds.height - Design.punchHoleRadius))
        bottomLeftArcPath.addArc(
            withCenter: CGPoint(x: 0, y: self.bounds.height),
            radius: Design.punchHoleRadius,
            startAngle: CGFloat(Double.pi + Double.pi / 2),
            endAngle: CGFloat(0),
            clockwise: true
        )
        bottomLeftArcPath.close()
        
        let bottomRightArcPath = UIBezierPath()
        bottomRightArcPath.move(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        bottomRightArcPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - Design.punchHoleRadius))
        bottomRightArcPath.addArc(
            withCenter: CGPoint(x: self.bounds.width, y: self.bounds.height),
            radius: Design.punchHoleRadius,
            startAngle: CGFloat(Double.pi + Double.pi / 2),
            endAngle: CGFloat(Double.pi),
            clockwise: false
        )
        bottomRightArcPath.close()
        
        ticketShapePath.append(topLeftArcPath.reversing())
        ticketShapePath.append(topRightArcPath)
        ticketShapePath.append(midLeftArcPath)
        ticketShapePath.append(midRightArcPath.reversing())
        ticketShapePath.append(bottomLeftArcPath.reversing())
        ticketShapePath.append(bottomRightArcPath)

        ticketShapeLayer.path = ticketShapePath.cgPath

        layer.addSublayer(ticketShapeLayer)
    }
}

