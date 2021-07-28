//
//  TVShowCell.swift
//  TVShowManager
//
//  Created by Om Prakash Shah on 7/25/21.
//

import SwiftUI

struct TVShow: Identifiable {
    var id = UUID()
    
    var title: String?
    var yearOfRelease: String?
    var seasons: String?
}

struct TVShowCell: View {
    let tvShow: TVShow
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(tvShow.title ?? "")
                    .font(.subheadline.bold())
                Text(tvShow.yearOfRelease ?? "")
                
                let seasonsEmpty = tvShow.seasons?.isEmpty ?? true
                Text("\(seasonsEmpty ? "1" : tvShow.seasons!) seasons")
            }
            .font(.caption)
            .padding(0.1)
        }
        .padding(DimenConstants.padding)
    }
    
}

struct TVShowCell_Previews: PreviewProvider {
    static var previews: some View {
        TVShowCell(tvShow: TVShow(title: "Breaking Bad", yearOfRelease: "2008", seasons: "5"))
    }
}
