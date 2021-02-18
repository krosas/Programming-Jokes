//
//  ContentView.swift
//  Programming Jokes
//
//  Created by kevin rosas on 2/17/21.
//

import SwiftUI

struct ContentView: View {
    @State private var jokes  = [Joke]()
    var body: some View {
        NavigationView {
            List(jokes) { joke in
                NavigationLink(
                    destination: Text(joke.punchline)
                        .padding(),
                    label: {
                        Text(joke.setup)
                    })
            }
            .navigationTitle("Programing Jokes")
        }
        .onAppear(perform: {
            getJokes()
        })
    }
    
    func getJokes() {
        let apiKey = "?rapidapi-key=(48d984c518mshfd2e06b34db7e4dp14cea1jsn4e26ad4dbc8c)"
        
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    struct Joke: Identifiable {
        let id = UUID()
        var setup: String
        var punchline: String
    }
}
