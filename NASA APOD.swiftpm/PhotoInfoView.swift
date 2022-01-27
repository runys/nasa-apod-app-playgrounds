//
//  File.swift
//  NASA Picture of the Day
//
//  Created by Tiago Pereira on 26/01/22.
//

import SwiftUI

struct PhotoInfoView: View {
    let photoInfo: PhotoInfo
    
    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            
            AsyncImage(url: photoInfo.url) { image in
                image
                    .resizable()
                    //.aspectRatio(1, contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
            } placeholder: {
                Color.gray
                    .cornerRadius(10)
                    .aspectRatio(1, contentMode: .fill)
                    .padding()
            }
            
            if let copyright = photoInfo.copyright {
                Text("By \(copyright)")
                    .font(.caption)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text(photoInfo.description)
                    .font(.body)
                
                HStack {
                    Spacer()
                    
                    Text("\(photoInfo.date)")
                }
                .font(.caption)
            }
            
        }
    }
}
