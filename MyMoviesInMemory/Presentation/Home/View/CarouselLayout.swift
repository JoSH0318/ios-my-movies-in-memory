//
//  CarouselLayout.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/05.
//

import UIKit

final class CarouselLayout: UICollectionViewFlowLayout {
    
    // MARK: - Namespace
    
    private enum Design {
        static let sideItemScale: CGFloat = 0.8
        static let sideItemAlpha: CGFloat = 0.8
        static let spacing: CGFloat = 10
    }
    
    // MARK: - Properties
    
    private var isSetup: Bool = false
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        
        self.itemSize = CGSize(
            width: UIScreen.main.bounds.width * 0.7,
            height: UIScreen.main.bounds.height * 0.7
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override public func prepare() {
        super.prepare()
        
        guard isSetup else {
            setupLayout()
            isSetup = true
            return
        }
    }
    
    // MARK: - Methods
    
    private func setupLayout() {
        guard let collectionView = self.collectionView else { return }
        
        let collectionViewSize = collectionView.bounds.size
        
        let xInset = (collectionViewSize.width - self.itemSize.width) / 2
        let yInset = (collectionViewSize.height - self.itemSize.height) / 2
        
        self.sectionInset = UIEdgeInsets(
            top: yInset,
            left: xInset,
            bottom: yInset,
            right: xInset
        )
        
        let itemWidth = self.itemSize.width
        
        let scaledItemOffset =  (itemWidth - itemWidth * Design.sideItemScale) / 2
        self.minimumLineSpacing = Design.spacing - scaledItemOffset
        self.scrollDirection = .horizontal
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else { return nil }
        
        return attributes.map {
            self.transformLayoutAttributes(attributes: $0)
        }
    }
    
    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        guard let collectionView = self.collectionView else { return attributes }
        
        let collectionCenter = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - center), maxDistance)
        
        let ratio = (maxDistance - distance) / maxDistance
        
        let alpha = ratio * (1 - Design.sideItemAlpha) + Design.sideItemAlpha
        let scale = ratio * (1 - Design.sideItemScale) + Design.sideItemScale
        
        attributes.alpha = alpha
        
        let visibleRect = CGRect(
            origin: collectionView.contentOffset,
            size: collectionView.bounds.size
        )
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
        attributes.transform3D = transform
        
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
        
        var targetContentOffset: CGPoint
        let closest = layoutAttributes
            .sorted {
                abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin)
            }
            .first ?? UICollectionViewLayoutAttributes()
        targetContentOffset = CGPoint(
            x: floor(closest.center.x - midSide),
            y: proposedContentOffset.y
        )
        
        return targetContentOffset
    }
}
