//
//  ContentTextView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/03/11.
//

import UIKit

final class ContentTextView: UITextView {
    
    // MARK: - Initializer
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setUpTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setUpTextView() {
        inputAccessoryView = makeToolBar()
        autocorrectionType = .no
        spellCheckingType = .no
    }
    
    private func makeToolBar() -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(
            x: .zero,
            y: .zero,
            width: UIScreen.main.bounds.size.width,
            height: 44.0)
        )
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(
            image: UIImage.keyboardHideButtonImage,
            style: .plain,
            target: self,
            action: #selector(didTapHideButton)
        )
        
        toolBar.items = [flexible, barButton]
        toolBar.clipsToBounds = true
        return toolBar
    }
    
    @objc private func didTapHideButton() {
        self.resignFirstResponder()
    }
}

