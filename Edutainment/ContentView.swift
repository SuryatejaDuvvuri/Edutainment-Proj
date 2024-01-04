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
    @State private var question = ""
    @State private var answer = 0
    
    var body: some View {
        NavigationView
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
                        .navigationBarTitle("Edutainment")
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
    @State private var randomNum : Int = Int.random(in: 2...10)
    @State private var answer = 0
    
    
    var body: some View {
        
        Section
        {
            generateQuestion()
            TextField("Please enter your answer", value: $userResponse, format: .number).frame(width: 250, height: 75).background(.white).foregroundColor(.black).font(.subheadline)
        }.onSubmit {
            if(userResponse == answer)
            {
               print("Correct")
               questionLength -= 1
//                generateQuestion()
            }
        }
        
    }
    
    func generateQuestion() -> some View
    {
        randomNum = Int.random(in: 2...10)
        print(randomNum)
        answer = multiplier * randomNum
        return Text("\(multiplier)  *  \(randomNum)").frame(width: 150, height: 75).font(.title).fontDesign(.rounded)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
