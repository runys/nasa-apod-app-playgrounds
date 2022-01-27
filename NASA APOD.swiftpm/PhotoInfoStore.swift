//
//  File.swift
//  NASA Picture of the Day
//
//  Created by Tiago Pereira on 26/01/22.
//

import Foundation

class PhotoInfoStore: ObservableObject {
    @Published var photoInfoOfToday: PhotoInfo?
    @Published var photosOfThePastWeek: [Date: PhotoInfo?] = [:]
    
    private let coordinator: PhotoInfoCoordinator = PhotoInfoCoordinator()
    
    init() {
        print("[PhotoInfoStore.init] Initializing the PhotoInfoStore.")
        
        let calendar = Calendar.current
        let today = Date()
        print("[PhotoInfoStore.init] Adding calendar entries")
        for i in 1...7 {
            let reduction = -i
            if let day = calendar.date(byAdding: .day, value: reduction, to: today) {
                photosOfThePastWeek.updateValue(nil, forKey: day)
                print("[PhotoInfoStore.init] Added \(day)")
            }
        }
        print("[PhotoInfoStore.init] \(photosOfThePastWeek.count)!")
        print("[PhotoInfoStore.init] ✅ Done!")
    }
    
    func getPhotoInfoOfToday() async throws {
        print("[PhotoInfoStore.getPhotoInfoOfToday] Getting photo of today")
        if photoInfoOfToday == nil {
            print("[PhotoInfoStore.getPhotoInfoOfToday] Loading a new photo")
            let result = try await coordinator.fetchPhotoInfo(for: Date())
            DispatchQueue.main.async {
                switch result {
                case .success(let photoInfo):
                    self.photoInfoOfToday = photoInfo
                    print("[PhotoInfoStore.getPhotoInfoOfToday] ✅ Done!")
                case .failure(let error):
                    print("[PhotoInfoStore.getPhotoInfoOfToday] Failed to get the Photo of Today: \(error.localizedDescription)")
                }
            }
        } else {
            print("[PhotoInfoStore.getPhotoInfoOfToday] Photo of today has been already loaded.")
        }
    }
    
    func getPhotosForThePastWeek() async throws {
        print("[PhotoInfoStore.getPhotosForThePastWeek] Loading photos of the past week.")
        for (date, photoInfo) in self.photosOfThePastWeek {
            if photoInfo == nil {
                print("[PhotoInfoStore.getPhotosForThePastWeek] Fetching photo info for \(date)")
                let result = try await self.coordinator.fetchPhotoInfo(for: date)
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedPhotoInfo):
                        self.photosOfThePastWeek[date] = fetchedPhotoInfo
                        print("[PhotoInfoStore.getPhotosForThePastWeek] Photo for \(date) loaded: \(fetchedPhotoInfo.title)")
                    case .failure(let error):
                        print("[PhotoInfoStore.getPhotosForThePastWeek] Failed to get the Photo Info for \(date): \(error)")
                    }
                }
            } else {
                print("[PhotoInfoStore.getPhotosForThePastWeek] Photo for \(date) already loaded: \(photoInfo!.title)")
            }
        }
    }
}

