//
//  Reactive + extension.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import UIKit.UIScrollView
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    var reachedBottom: ControlEvent<Void> {
        let source = contentOffset.map { contentOffset in
            if base.contentSize.height == 0 { return false }
            let visibleHeight = base.frame.height - base.contentInset.top - base.contentInset.bottom
            let yPosition = contentOffset.y + base.contentInset.top
            let threshold = base.contentSize.height - visibleHeight
            return yPosition >= threshold }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in }
        return ControlEvent(events: source)
    }
}
