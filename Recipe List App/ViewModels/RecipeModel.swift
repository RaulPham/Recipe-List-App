import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        // Create an instance of data service and get the data
        self.recipes = DataService.getLocalData()
    }
      
      static func getPortion(ingredient: Ingredients, recipeServings: Int, targetServings: Int) -> String {
            
            var portion = ""
            var numerator = ingredient.num ?? 1 // ?? nil operator
            var denominator = ingredient.denom ?? 1
            var wholePortion = 0
            
            if ingredient.num != nil {
                  //Get a single serving size by multiplying denominator by the recipe serving
                  denominator *= recipeServings
                        
                  //Get target portion by multiplying numerator by target servings
                  numerator *= targetServings
                        
                  //Reduce fraction by greatest common divisor
                  let divisor = Rational.greatestCommonDivisor(numerator, denominator)
                  numerator /= divisor
                  denominator /= divisor
                  
                  //Get the whole portion if numerator > denominator
                  if numerator >= denominator {
                        
                        //Calculate the whole portion
                        wholePortion = numerator / denominator
                        
                        //Calculate the remainder
                        numerator = numerator % denominator
                        
                        //Assign to portion string
                        portion += String(wholePortion)
                  }
                  
                  //Express the remainder as fraction
                  if numerator > 0 {
                        
                        //Assign remainder as fraction to the portion string
                        portion += wholePortion > 0 ? " " : ""
                        portion += "\(numerator)/\(denominator)"
                  }
            }
            
            if var unit = ingredient.unit {
                  
                  //If we need to pluralize
                  if wholePortion > 1 {
                        
                        //Calculate the appropriate suffix
                        if unit.suffix(2) == "ch" {
                              unit += "es"
                        } else if unit.suffix(1) == "f" {
                              unit = String(unit.dropLast())
                              unit += "ves"
                        } else {
                              unit += "s"
                        }
                  }
                  
                  portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
                  
                  return portion + unit
            }
            
            return portion
      }
}
