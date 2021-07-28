//
//  Extensions.swift
//  TVShowManager
//
//  Created by Om Prakash Shah on 7/25/21.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
#endif
