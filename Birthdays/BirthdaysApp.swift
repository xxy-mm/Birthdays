//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Darian Mitchell  on 2024/4/18.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
