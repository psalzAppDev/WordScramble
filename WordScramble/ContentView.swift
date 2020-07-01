//
//  ContentView.swift
//  WordScramble
//
//  Created by Peter Salz on 30.06.20.
//  Copyright © 2020 Peter Salz App Development. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextField(
                    "Enter your word",
                    text: $newWord,
                    onCommit: addNewWord
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
        }
    }
    
    func addNewWord() {
        
        // Lowercase and trim the word, to make sure we don't add
        // duplicate words with case differences.
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }
        
        // Extra validation to come.
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        
        if let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        ) {
        
            if let startWords = try? String(contentsOf: startWordsURL) {
                
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
