//
//  CommonUtils.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation

protocol ToastSupport: AnyObject {
    var showToast: Bool { get set }
    var toastMessage: LocalizedStringResource { get set }
}

extension ToastSupport {
    
    func showToast(with message: LocalizedStringResource, replace: Bool = true) {
        if !replace, showToast {
            LLogger.shared.debug("Toast has been skipped as another toast is already being shown")
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.toastMessage = message
            self?.showToast = true
        }
    }
    
}
