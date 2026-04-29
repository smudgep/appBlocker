//
//  ContentView.swift
//  appBlocker
//
//  Created by Roisin Pinches on 28/04/2026.
//

import SwiftUI

//defines a scene
struct ContentView: View {
    //@State = when variable chamges redraw screen
    @State private var isBlockerEnabled = false
    @State private var selectedTime = Date()
    
    @State private var showingQuiz = false
    @State private var userAns = ""
    @State private var quizQs = "What is 12 x 12?"
    @State private var correctAns = "144"
    
    var body: some View {
        //topbar (title)
        NavigationStack{
            //list is a container adds grey bg and white lines
            List{
                //groups item together with a header
                Section(header: Text("Status")){
                    //creates toggle switch
                    
                    //$ represents Binding means toggle is stuck to variable
                    Toggle(isOn: Binding<Bool>(  // Note the <Bool> and the (
                        get: { self.isBlockerEnabled },
                        set: { newValue in
                            if isBlockerEnabled {
                                // They are trying to turn it OFF, show the quiz
                                self.showingQuiz = true
                            } else {
                                // They are turning it ON, let it happen
                                self.isBlockerEnabled = true
                            }
                        }
                    )) {
                        //? ===== true or false in short((Condition ? ValueIfTrue : ValueIfFalse))
                        Label(isBlockerEnabled ? "Blocker Active" : "Blocker is paused",
                              systemImage: isBlockerEnabled ? "hand.raised.fill" : "play.fill")
                    }
                    Button(isBlockerEnabled ? "Solve to unblock" : "Start Focus Mode"){
                        if isBlockerEnabled{
                            showingQuiz = true
                        } else{
                            isBlockerEnabled = true
                        }
                    }
                    .tint(.red)
                    .navigationTitle("Focus Mode")
                    .sheet(isPresented: $showingQuiz){
                        VStack(spacing: 20){
                            Text("Brain Test").font(.headline)
                            Text(quizQs).font(.title)
                            
                            TextField("Enter Answer: ", text: $userAns)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .padding()
                            
                            Button("Submit + Unblock"){
                                checkAnswer()
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                    }
                }
                
                Section(header: Text("Requirements")){
                    HStack{
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                        Text("Location: College")
                        Spacer()
                        Text("Active").font(.caption).foregroundColor(.gray)
                    }
                    
                    DatePicker("Start Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                }
            }
        }
    }
    
    
    func checkAnswer(){
        if userAns == correctAns{
            isBlockerEnabled = false
            showingQuiz = false
            userAns = ""
        }else{
            userAns = ""
        }
        
    }
}
