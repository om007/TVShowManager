//
//  ContentView.swift
//  TVShowManager
//
//  Created by Om Prakash Shah on 7/25/21.
//

import SwiftUI

// SCENE #1
struct HomeView: View {
    //Storing a state just to activate pushing of AddNewView or TVShowListView to NavigationView on a button click
    @State var selection: Int?

    var body: some View {
        
        NavigationView {
            VStack(alignment: .center, spacing: DimenConstants.interItemSpacing) {
                
                HStack { Image("BreakingBad") }
                
                NavigationLink(destination: AddNewView(), tag: 1, selection: $selection) {
                    Button(action: {
                        //Navigating to destination view activation
                        self.selection = 1
                    }, label: {})
                }
                .buttonStyle(CombyneBlueButton(title: StringConstants.addNew))
                
                NavigationLink(destination: TVShowListView(), tag: 2, selection: $selection) {
                    Button(action: {
                        //Navigating to destination view activation
                        self.selection = 2
                    }, label: {})
                }
                .buttonStyle(CombyneBlueButton(title: StringConstants.showList))
                
                Spacer()
            }
            .navigationTitle(StringConstants.navTitle_tvShowManager)
            .background(Color.blue.opacity(0.1))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
