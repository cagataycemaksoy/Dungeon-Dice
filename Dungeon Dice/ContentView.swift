//
//  ContentView.swift
//  Dungeon Dice
//
//  Created by Cem Aksoy on 15.11.2025.
//

import SwiftUI

struct ContentView: View {
  enum Dice: Int, CaseIterable, Identifiable {
    case four = 4
    case six = 6
    case eight = 8
    case twelve = 12
    case twenty = 20
    case hundred = 100
    
    var id: Int { self.rawValue }
    var description: String { "\(self.rawValue)-sided" }
    
    func roll() -> Int { Int.random(in: 1...self.rawValue) }
  }
  
  @State private var message = ""
  @State private var stillStateOffset = 0.0
  @State private var animated = false
  @State private var animationDone = true
  
  private let columns = [GridItem(.adaptive(minimum: 112))]
  
  var body: some View {
    ZStack {
      Color.black.opacity(0.65).ignoresSafeArea()
      
      VStack {
        titleView
        Spacer()
        resultMessageView
        Spacer()
        
        Image(systemName: "dice")
          .resizable()
          .scaledToFit()
          .frame(height: 100)
          .offset(x: animationDone ? stillStateOffset : -120, y: 0)
          .rotation3DEffect(animationDone ? .degrees(360) : .degrees(0), axis: (x: 0 , y: 0, z: 1), anchor: .bottomTrailing)
          .onChange(of: animated) {
            animationDone = false
            withAnimation(.easeInOut(duration: 0.7)) {
              animationDone = true
            }
          }
        
        
        Spacer()
        
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(Dice.allCases) { side in
            Button {
              stillStateOffset = 120
              animated.toggle()
              message = "You rolled a \(side.roll()) on a \(side.rawValue)-sided dice."
              //TODO: Play a sound, when the button is tapped
            } label: {
              Text(side.description)
                .fontDesign(.serif)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.black)
                .frame(width: 92)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .shadow(radius: 5)
            
          }
        }
        .padding(.bottom)
        
      }
      .padding(.horizontal)
    }
  }
}

extension ContentView {
  var titleView: some View {
    Text("Dungeon Dice")
      .fontDesign(.serif)
      .font(.largeTitle)
      .fontWeight(.black)
      .foregroundStyle(.black)
      .padding(.top)
  }
  
  var resultMessageView: some View {
    Text(message)
      .fontDesign(.serif)
      .font(.title)
      .fontWeight(.bold)
      .multilineTextAlignment(.center)
      .foregroundStyle(.black)
      .frame(height: 105)
      .frame(maxWidth: .infinity)
      .animation(.easeInOut, value: message)
  }
}

#Preview {
  ContentView()
}
