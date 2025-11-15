//
//  ContentView.swift
//  Dungeon Dice
//
//  Created by Cem Aksoy on 15.11.2025.
//

import SwiftUI

struct ContentView: View {
  enum Dice: Int, CaseIterable {
    case four = 4
    case six = 6
    case eight = 8
    case twelve = 12
    case twenty = 20
    case hundred = 100
    
    func roll() -> Int { Int.random(in: 1...self.rawValue) }
  }
  
  @State private var message = ""
  private let columns = [GridItem(.adaptive(minimum: 90))]
  
  var body: some View {
    ZStack {
      Color.black.opacity(0.75).ignoresSafeArea()
      
      VStack {
        Text("Dungeon Dice")
          .fontDesign(.serif)
          .font(.largeTitle)
          .fontWeight(.black)
          .foregroundStyle(.red)
          .padding(.top)
        
        Spacer()
        
        Text(message)
          .fontDesign(.serif)
          .font(.title)
          .fontWeight(.bold)
          .multilineTextAlignment(.center)
          .foregroundStyle(.black)
          .animation(.easeInOut, value: message)
        
        Spacer()
        Spacer()
        
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(Dice.allCases, id: \.self) { side in
            Button {
              message = "You rolled a \(side.roll()) on a \(side.rawValue)-sided dice."
              //TODO: Add a dice image rotating animated when the button is tapped
              //TODO: Play a sound, when the button is tapped
            } label: {
              Text("\(side.rawValue)-sided")
                .fontDesign(.serif)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.black)
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

#Preview {
  ContentView()
}
