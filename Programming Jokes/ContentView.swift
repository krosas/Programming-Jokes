//
//  ContentView.swift
//  Programming Jokes
//
//  Created by kevin rosas on 2/17/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
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
            getJokes ()
        })
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text ("loading Error"),
                  message: Text ("there was a problem loading the data"),
                  dismissButton: .default(Text("Ok")))
        })
    }
    
    func getJokes() {
        let apiKey = "?rapidapi-key=48d984c518mshfd2e06b34db7e4dp14cea1jsn4e26ad4dbc8c"
        let query = "https://dad-jokes.p.rapidapi.com/joke/type/programming\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["success"] == true {
                    let contents = json["body"].arrayValue
                    for item in contents {
                        let setup = item["setup"].stringValue
                        let punchline = item["punchline"].stringValue
                        let joke = Joke(setup: setup, punchline: punchline)
                        jokes.append(joke)
                    }
                    return
                }
                
            }
            
        }
        showingAlert = true
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
