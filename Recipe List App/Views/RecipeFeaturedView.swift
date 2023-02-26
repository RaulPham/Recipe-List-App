import SwiftUI

struct RecipeFeaturedView: View {
      @EnvironmentObject var model: RecipeModel
      @State var isDetailViewShowing = false
      @State var tabSelectionIndex = 0
      
    var body: some View {
          let featuredRecipe = model.recipes.filter({$0.featured})
          
          VStack(alignment: .leading, spacing: 0) {
                Text("Featured Recipes")
                      .bold()
                      .font(Font.custom("Avenir Heavy", size: 24))
                      .padding(.top, 40)
                      .padding(.leading)
                
                GeometryReader {geo in
                      TabView(selection: $tabSelectionIndex) {
                            ForEach(0..<featuredRecipe.count) {index in
                                  Button {
                                        //Show the recipe detail sheet
                                        self.isDetailViewShowing = true
                                  } label: {
                                        ZStack {
                                              Rectangle()
                                                    .foregroundColor(.white)
                                              
                                              VStack(spacing: 0) {
                                                    Image(featuredRecipe[index].image)
                                                          .resizable()
                                                          .aspectRatio(contentMode: .fill)
                                                          .clipped()
                                                    
                                                    Text(featuredRecipe[index].name)
                                                          .font(Font.custom("Avenir", size: 15))
                                                          .padding(5)
                                              }
                                        }
                                  }
                                  .tag(index)
                                  .buttonStyle(PlainButtonStyle())
                                  .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                                  .cornerRadius(15)
                                  .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 6)
                            }
                      }
                      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                      .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
                
                VStack(alignment: .leading, spacing: 20) {
                      Text("Preparation Time:")
                            .font(Font.custom("Avenir Heavy", size: 16))
                      Text(model.recipes[tabSelectionIndex].prepTime)
                      
                      Text("Highlights:")
                            .font(Font.custom("Avenir Heavy", size: 16))
                      RecipeHighlightsView(highlights: model.recipes[tabSelectionIndex].highlights)
                }
                .padding([.leading, .bottom])
          }
          .sheet(isPresented: $isDetailViewShowing) {
                RecipeDetailView(recipe: featuredRecipe[tabSelectionIndex])
          }
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
                .environmentObject(RecipeModel())
    }
}
