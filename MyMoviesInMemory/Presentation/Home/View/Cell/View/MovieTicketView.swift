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
        static let firstSectionRatio: CGFloat = 1.3
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
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.width * Design.firstSectionRatio - Design.punchHoleRadius))
        path.addArc(
            withCenter: CGPoint(x: 0, y: self.bounds.width * Design.firstSectionRatio),
            radius: Design.punchHoleRadius,
            startAngle: CGFloat(Double.pi + Double.pi / 2),
            endAngle: CGFloat(Double.pi / 2),
            clockwise: true
        )
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.width * Design.firstSectionRatio + Design.punchHoleRadius))
        path.addArc(
            withCenter: CGPoint(x: self.bounds.width, y: self.bounds.width * Design.firstSectionRatio),
            radius: Design.punchHoleRadius,
            startAngle: CGFloat(Double.pi / 2),
            endAngle: CGFloat(Double.pi + Double.pi / 2),
            clockwise: true
        )
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.close()
        UIColor.MWhite?.set()
        path.fill()
    }
    
    // MARK: - Methods
    
    private func configureView() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = Design.punchHoleRadius
        self.clipsToBounds = true
        
        self.layer.shadowColor = UIColor.systemGray3.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = .zero
    }
}

