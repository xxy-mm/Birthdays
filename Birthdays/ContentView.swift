//
//  ContentView.swift
//  Birthdays
//
//  Created by Darian Mitchell  on 2024/4/18.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query(sort: \Friend.birthday) private var friends: [Friend]
    @Environment(\.modelContext) private var context

    @State private var newName = ""
    @State private var newDate = Date.now

    var body: some View {
        NavigationStack {
            List{
                ForEach(friends) { friend in
                    HStack {
                        if friend.isBirthdayToday {
                            Image(systemName: "birthday.cake.fill")
                                .foregroundStyle(.yellow)
                        }
                        Text(friend.name)
                            .bold(friend.isBirthdayToday)
                        Spacer()
                        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    }
                }
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first {
                        context.delete(friends[index])
                    }
                }) 
            }
            .navigationTitle("Birthday")
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newDate, in: Date.distantPast ... Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newDate)
                        context.insert(newFriend)
                        newName = ""
                        newDate = .now
                    }
                    .bold()
                }
                .padding()
                .background(.bar)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
