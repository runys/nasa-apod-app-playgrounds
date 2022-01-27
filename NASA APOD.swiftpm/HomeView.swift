//
//  File.swift
//  NASA Picture of the Day
//
//  Created by Tiago Pereira on 26/01/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var photoInfoStore: PhotoInfoStore
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    PhotoOfTodayView()
                        .padding()
                        .navigationTitle("NASA APOD")
                    
                    Divider()
                    
                    PhotosOfTheWeekListView()
                        .padding()
                }
            }
        }
        .task {
            await loadPhotos()
        }
    }
    
    func loadPhotos() async {
        print("[loadPhotos] Initializing Photo Store")
        do {
            print("[loadPhotos] Loading photo of today")
            try await photoInfoStore.getPhotoInfoOfToday()
            print("[loadPhotos] Loading photos of the past week")
            try await photoInfoStore.getPhotosForThePastWeek()
            print("[loadPhotos] ✅ Done!")
        } catch {
            print("[loadPhotos] Failed loading photos: \(error)")
        }
    }
}
