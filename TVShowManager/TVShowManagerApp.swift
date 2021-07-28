//
//  TVShowManagerApp.swift
//  TVShowManager
//
//  Created by Om Prakash Shah on 7/25/21.
//

import SwiftUI
import Parse

@main
struct TVShowManagerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate    {
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let parseConfig = ParseClientConfiguration {
                   $0.applicationId = "UvBvjdPeATFfYW9PeMjuoyX0ZGkD9XVY6NJAwshV"
                   $0.clientKey = "rxbpcYTOYya1NXcMbyaXNdLOCNs2VwY86OZ6w9ZE"
                   $0.server = "https://parseapi.back4app.com/"
               }
               Parse.initialize(with: parseConfig)
        return true
     }
}

