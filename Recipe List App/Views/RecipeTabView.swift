//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Pham on 2/21/23.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
          TabView {
                Text("Feature")
                      .tabItem {
                            VStack {
                                  Image(systemName: "star.fill")
                                  Text("Featured")
                            }
                      }
                
                RecipeListView()
                      .tabItem {
                            VStack {
                                  Image(systemName: "list.bullet")
                                  Text("List")
                            }
                      }
          }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
