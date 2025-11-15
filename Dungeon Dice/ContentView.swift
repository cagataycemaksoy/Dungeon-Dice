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
          .padding(.top, 25)
         
        Spacer()
        
        Text(message)
          .fontDesign(.serif)
          .font(.title)
          .fontWeight(.bold)
          .minimumScaleFactor(0.5)
          .foregroundStyle(.red)
          
        Spacer()
        
        LazyVGrid(columns: columns) {
          ForEach(Dice.allCases, id: \.self) { side in
            Button {
              message = "You rolled a \(side.roll()) on a \(side.rawValue)-sided dice."
            } label: {
              Text("\(side.rawValue)-sided")
            }
            .buttonStyle(.borderedProminent)

          }
        }
      }
    }
  }
}

#Preview {
    ContentView()
}
