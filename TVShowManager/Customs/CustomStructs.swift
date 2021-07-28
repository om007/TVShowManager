//
//  CustomStructs.swift
//  TVShowManager
//
//  Created by Om Prakash Shah on 7/25/21.
//

import SwiftUI

struct CombyneBlueButton: ButtonStyle {
    let title: String
        
    // Tracks if the button is enabled or not
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
            Text(title)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity((configuration.isPressed || !isEnabled) ? 0.5 : 1))
                .foregroundColor(.white)
                .font(.headline)
                .clipShape(Capsule())
                .padding([.leading, .trailing], DimenConstants.margin)
    }
    
}

struct CombyneDialog: Identifiable {
    var id: String { title }
    let title: String
    let messege: String
    let buttonTitle: String
}
