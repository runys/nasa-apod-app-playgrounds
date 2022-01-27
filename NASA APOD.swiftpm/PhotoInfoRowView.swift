//
//  File.swift
//  NASA Picture of the Day
//
//  Created by Tiago Pereira on 26/01/22.
//

import SwiftUI

struct PhotoInfoRowView: View {
    var photoInfo: PhotoInfo
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YY"
        
        return dateFormatter.string(from: photoInfo.dateObject)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(photoInfo.title)
                .font(.headline)
            HStack {
                Text("By \(photoInfo.copyright ?? "-")")
                Spacer()
                Text(formattedDate)
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
    }
}
