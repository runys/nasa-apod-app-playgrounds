import SwiftUI

@main
struct MyApp: App {
    let photoInfoStore = PhotoInfoStore()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(photoInfoStore)
        }
    }
}
