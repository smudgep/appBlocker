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
    
    @State private var selectedApps = false
    
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
                            VStack(spacing: 30) {
                                Capsule() // A little grab bar at the top
                                    .fill(Color.secondary.opacity(0.5))
                                    .frame(width: 40, height: 6)
                                    .padding(.top)

                                Text("Focus Check")
                                    .font(.caption)
                                    .tracking(2)
                                    .foregroundColor(.secondary)

                                Text(quizQs)
                                    .font(.title2.bold())
                                    .multilineTextAlignment(.center)

                                TextField("Answer here...", text: $userAns)
                                    .textFieldStyle(.plain)
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(15)

                                Button("Unlock Apps") {
                                    checkAnswer()
                                }
                                .buttonStyle(.borderedProminent)
                                .controlSize(.large)
                                .tint(.red)
                                
                                Spacer()
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
                
                Section(header: Text("Target Apps")){
                    HStack{
                        Image(systemName: "Ro")
                            .foregroundColor(.blue)
                        Text("Select Apps to Block")
                        Spacer()
                        Button(action: {
                            //screentime app
                        }){
                            Text("Edit")
                                .foregroundColor(.blue)
                                .font(.subheadline)
                        }
                    }
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
