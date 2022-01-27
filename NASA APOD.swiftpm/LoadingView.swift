//
//  File.swift
//  NASA Picture of the Day
//
//  Created by Tiago Pereira on 26/01/22.
//

import SwiftUI

struct LoadingView: View {
    
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            
            Text(message)
            
            Spacer()
        }
    }
}
