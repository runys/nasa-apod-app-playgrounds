//
//  File.swift
//  NASA Picture of the Day
//
//  Created by Tiago Pereira on 26/01/22.
//

import SwiftUI

struct PhotoOfTodayView: View {
    @EnvironmentObject var photoInfoStore: PhotoInfoStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Photo of Today")
                .font(.title2)
                .fontWeight(.bold)
            
            if let photoInfo = photoInfoStore.photoInfoOfToday {
                VStack(alignment: .center, spacing: 8.0) {
                    AsyncImage(url: photoInfo.url) { image in
                        image
                            .resizable()
                            .aspectRatio(16.0/9.0, contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        LoadingView(message: "Loading photo of today")
                            .frame(maxWidth: .infinity)
                            .aspectRatio(16.0/9.0, contentMode: .fit)
                    }
                    
                    Text(photoInfo.title)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(16.0/9.0, contentMode: .fit)
                    .foregroundColor(.gray)
                
                Text("Placeholder")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
        }
    }
}
