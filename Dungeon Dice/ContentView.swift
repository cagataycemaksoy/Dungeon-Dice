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
  private let columns = [GridItem(.adaptive(minimum: 112))]
  
  var body: some View {
    ZStack {
      Color.black.opacity(0.75).ignoresSafeArea()
      
      VStack {
        titleView
        Spacer()
        resultMessageView
        Spacer()
        Spacer()
        
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(Dice.allCases) { side in
            Button {
              message = "You rolled a \(side.roll()) on a \(side.rawValue)-sided dice."
              //TODO: Add a dice image rotating animated when the button is tapped
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
      .foregroundStyle(.red)
      .padding(.top)
  }
  
  var resultMessageView: some View {
    Text(message)
      .fontDesign(.serif)
      .font(.title)
      .fontWeight(.bold)
      .multilineTextAlignment(.center)
      .foregroundStyle(.black)
      .animation(.easeInOut, value: message)
  }
}

#Preview {
  ContentView()
}
