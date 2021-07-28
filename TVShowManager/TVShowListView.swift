//
//  TVShowListView.swift
//  TVShowManager
//
//  Created by Om Prakash Shah on 7/25/21.
//

import SwiftUI
import Parse

// SCENE #3
struct TVShowListView: View {
    @State private var showResults: [TVShow] = []
    @State private var isLoading = true //Boolean to check view is loaded the first time
    
    var body: some View {
        List {
            if showResults.isEmpty && !isLoading {
                //If results is empty
                Text("Oops! Failed to retrive bike shops near 100 miles radius.")
                    .font(.subheadline)
                    .foregroundColor(.red)
            } else {
                ForEach(showResults) { show in
                    TVShowCell(tvShow: show)
                }
                .listRowBackground(Color.blue.opacity(0.05))
                
                if isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle(StringConstants.navTitle_tvShowList)
        .onAppear(perform: {
            self.fetchAllShows()
        })
    }
    
    func fetchAllShows() {
        let query = PFQuery(className: TVShowConstants.className)
        query.findObjectsInBackground(block: { (objects, error) in
            showResults.removeAll()
            if error == nil, let allShows = objects {
                //Success
                for show in allShows {
                    let title = show[TVShowConstants.title] as? String
                    let year = show[TVShowConstants.year] as? String
                    let seasons = show[TVShowConstants.seasons] as? String
                    showResults.append(TVShow(title: title, yearOfRelease: year, seasons: seasons))
                }
            } else {
                //Fail
            }
            
            //Finally, remove progress view.
            self.isLoading = false
        })
    }
}
        

struct TVShowListView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowListView()
    }
}
