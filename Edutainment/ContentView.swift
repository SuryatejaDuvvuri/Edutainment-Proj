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
        VStack {
            Stepper("\(numOfQuestions.formatted()) Questions", value: $numOfQuestions, in: 5...20, step: 5)
            
            VStack
            {
                
               
//                ForEach(2..<13)
//                {
//                    _ in
//                    HStack
//                    {
//                        Button()
//                        { } label: {
//                            Text("\(multiplerNum)")
//                                .font(.system(size: 36, design: .rounded))
//                        }.buttonStyle(.bordered)
//                            .foregroundColor(.pink)
//                        
//                        Button()
//                        { } label: {
//                            Text("\(multiplerNum + 1)")
//                                .font(.system(size: 36, design: .rounded))
//                        }.frame(width: 200, height: 25).buttonStyle(.bordered)
//                            .foregroundColor(.pink)
//                        
//                        multiplerNum = multiplerNum + 1;
//                    }
//                    
//
//            
//                }
                Text("Please select a multipler")
                Picker("Please select a number", selection: $selectedNumber)
                {
                    ForEach(2..<13)
                    {
                        Text("\($0)")
                    }
                }
                
                Button("Start", action: generateQuestions).buttonStyle(.bordered).foregroundColor(.pink)
                
                if isActive{
                    Section{
                        Text(question)
                        TextField("Enter your answer", value: $answer, format: .number)
                    }
                    
//                    Button("Continue", action: question = askQuestion)
                    
                }
            }
            
        }
        .padding()
    }
    
    func generateQuestions()
    {
        isActive = true;
        if(numOfQuestions == 0)
        {
            isActive = false
        }
        question = askQuestion()
        return
    }
    
    func askQuestion() -> String
    {
        var numberTwo = Int.random(in: selectedNumber..<100)
        return "\($selectedNumber) x \(numberTwo)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
