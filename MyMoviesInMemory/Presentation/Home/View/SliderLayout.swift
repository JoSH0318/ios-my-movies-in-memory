//
//  SliderLayout.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/05.
//

import UIKit

final class SliderLayout: UICollectionViewFlowLayout {
    
    // MARK: - Properties
    
    private let sideItemScale: CGFloat = 0.8
    private let sideItemAlpha: CGFloat = 0.8
    private let sideItemShift: CGFloat = 15
    
    // MARK: - LifeCycle
    
    override init() {
        super.init()
        
        self.itemSize = CGSize(
            width: UIScreen.main.bounds.width * 0.7,
            height: UIScreen.main.bounds.width
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        self.updateLayout()
    }
    
    // MARK: - Methods
    
    private func updateLayout() {
        self.scrollDirection = .horizontal
        
        guard let collectionView = self.collectionView else { return }
        
        let collectionViewSize = collectionView.bounds.size
        let yInset = (collectionViewSize.height - self.itemSize.height) / 2
        let xInset = (collectionViewSize.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets(
            top: yInset,
            left: xInset,
            bottom: yInset,
            right: xInset
        )
        
        let side = self.itemSize.width
        let scaledItemOffset =  (side - side * self.sideItemScale) / 2
        let sideItemOverlap = 100 + scaledItemOffset
        let inset = xInset
        self.minimumLineSpacing = inset - sideItemOverlap
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(
                array: superAttributes,
                copyItems: true
              ) as? [UICollectionViewLayoutAttributes]
        else {
            return nil
        }
        
        return attributes.map({ self.transformLayoutAttributes($0) })
    }
    
    private func transformLayoutAttributes(
        _ attributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        let collectionCenter = collectionView.frame.size.width / 2
        let offset = collectionView.contentOffset.x
        let normalizedCenter = attributes.center.x - offset
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance) / maxDistance
        
        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        let shift = (1 - ratio) * self.sideItemShift
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(alpha * 10)
        attributes.center.y = attributes.center.y + shift
        
        return attributes
    }
    
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        guard let collectionView = collectionView,
              let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds),
              !collectionView.isPagingEnabled
        else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        
        let midSide = collectionView.bounds.size.width / 2
        let proposedContentOffsetCenterOrigin = proposedContentOffset.x + midSide
        
        let closest = layoutAttributes
            .sorted {
                abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin)
            }
            .first ?? UICollectionViewLayoutAttributes()
        
        let targetContentOffset = CGPoint(
            x: floor(closest.center.x - midSide),
            y: proposedContentOffset.y
        )
        
        return targetContentOffset
    }
}
