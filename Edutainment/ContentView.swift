//
//  ContentView.swift
//  Edutainment
//
//  Created by Suryateja Duvvuri on 9/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numOfQuestions = 5
    @State private var selectedNumber = 2
    @State private var isActive = false
    
    var body: some View {
        NavigationStack
        {
            VStack {
                Stepper("\(numOfQuestions.formatted()) Questions", value: $numOfQuestions, in: 5...20, step: 5)
                
                VStack
                {
                    Text("Please select a multipler")
                    Picker("Please select a number", selection: $selectedNumber)
                    {
                        ForEach(0..<13)
                        {
                            Text("\($0)")
                        }
                    }
                 
                    
                    NavigationLink(destination: QuestionsView(questionLength: numOfQuestions, multiplier: selectedNumber), label: {
                        Text("Start")
                    })  .frame(width: 100, height: 50, alignment: .center)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.indigo, lineWidth: 6)
                        )
                        .navigationBarTitle("Home page")
                    }
               
                    
                }
                
            }
            .padding()
        }
}

struct QuestionsView : View {
    
    @State var questionLength : Int
    @State var multiplier : Int
    @State private var userResponse = 0
    @State private var randomNum : Int = 0
    @State private var answer = 0
    @State private var correctAns = 0
    @State private var gameOver : Bool = false
    @State private var gotCorrect : Bool = false
    @State private var clickedEnter : Bool = false
    @State private var message = ""
    
    
    var body: some View {
        
        
        Section
        {
            Text("\(multiplier)  *  \(randomNum)").frame(width: 150, height: 75).font(.title).fontDesign(.rounded)
            TextField("Please enter your answer", value: $userResponse, format: .number).frame(width: 250, height: 75).background(.white).foregroundColor(.black).font(.subheadline)
        }
        .onAppear(perform: generateQuestion)
        .alert("Game Over", isPresented: $gameOver) {
            Button("OK", role: .cancel, action: {
                userResponse = 0
                correctAns = 0
                gameOver = false
                randomNum = 0
                answer = 0
                
            })
        } message:
        {
            Text("Congratulations! You got \(correctAns) correct. Press Home page to restart the game.")
        }
        
        Button("Submit", action:{clickedEnter = true
        generateQuestion()})
        
        if clickedEnter
        {
            checkAnswer()
        }
        else
        {
            Text("")
        }
        
       
       
        
    }
    
    func checkAnswer() -> some View
    {
        if(userResponse == answer)
        {
            gotCorrect = true
            correctAns += 1
        }
        
        if(questionLength == 0)
        {
            gameOver.toggle()
        }
        else
        {
            questionLength -= 1
        }
        
        if gotCorrect
        {
            return  Text("Correct! \(Image(systemName: "checkmark.circle"))")
                .onAppear(perform:generateQuestion)
        }
        else
        {
            return Text("Correct answer is \(answer)").onAppear(perform:
                generateQuestion)
        }
        
    }
    
    func generateQuestion()
    {
        randomNum = Int.random(in: 2...10)
        answer = multiplier * randomNum
        gotCorrect = false
        clickedEnter = false
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
