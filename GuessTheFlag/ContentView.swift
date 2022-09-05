//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Silver on 4/14/22.
//

import SwiftUI


// Hi my name is Silver!

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var gameOver = false
    @State private var questionCount = 0
    @State private var endTitle = "Game Over"
    
   @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
   @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var buttonOpacity = 0.0
    @State private var rotationAmount = 0.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
            
            
        VStack(spacing: 15) {
        VStack {
            Text("Tap the flag of")
                .foregroundStyle(.secondary)
                .font(.subheadline.weight(.heavy))
            
            Text(countries[correctAnswer])
                .font(.largeTitle.weight(.semibold))
        }
        
        ForEach(0..<3) { number in
            Button {
                withAnimation{
                    self.flagTapped(number)
                }
            } label:  {
                FlagImage(of: countries[number])
                    .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                
            }
            .rotation3DEffect(.degrees(number == self.correctAnswer ? rotationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
          //  .opacity(number != correctAnswer ? buttonOpacity : 1.0)
        }
            
        
        }
        
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
        Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
        }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert(endTitle, isPresented: $gameOver) {
            Button("Reset", action: reset)
        } message: {
            Text("You answered \(userScore) out of 8 correctly")
        }
        
        
    }
        func flagTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Correct"
                userScore += 1
                rotationAmount = 360
                
            } else {
                scoreTitle = "Wrong, that´s not the flag of \(countries[correctAnswer])"
            }
            
            withAnimation(.easeInOut) {
                
            }
            
            showingScore = true
        }
        
    func askQuestion() {
        if questionCount < 8 {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount += 1
        rotationAmount = 0
        } else {
            gameOver = true
        }
    }
    
    func reset() {
        questionCount = 0
        userScore = 0
    }
    
    }

struct FlagImage: View {
    var country: String
    
    init(of country: String) {
        self.country = country
    }
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
