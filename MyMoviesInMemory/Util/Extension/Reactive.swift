//
//  Reactive.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/14.
//

import UIKit
import RxSwift
import RxCocoa

extension RxSwift.Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillAppear))
            .map { _ in }
        return ControlEvent(events: source)
    }
}
