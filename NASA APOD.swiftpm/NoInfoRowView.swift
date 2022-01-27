//
//  File.swift
//  NASA Picture of the Day
//
//  Created by Tiago Pereira on 26/01/22.
//

import SwiftUI

struct NoInfoRowView: View {
    let date: Date
    
    @State var formattedDate: String = ""
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Text("No info available for \(formattedDate)")
                .font(.headline)
            Spacer()
        }
        .font(.caption)
        .foregroundColor(.gray)
        .onAppear {
            self.formatDate()
        }
    }
    
    func formatDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/Y"
        
        let dateAsString = dateFormatter.string(from: date)
        
        self.formattedDate = dateAsString
    }
}
