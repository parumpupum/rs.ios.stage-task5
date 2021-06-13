import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        
        var foodsBackpack: [[Int]] = Array(repeating: Array(repeating: 0, count: maxWeight + 1),
            count: foods.count + 1)
        var drinksBackpack: [[Int]] = Array(repeating: Array(repeating: 0, count: maxWeight + 1), count: drinks.count + 1)
        
        for i in 0..<foods.count{
            let currentFood = foods[i]
            for j in 1...maxWeight{
                if (((j - currentFood.weight > 0 && foodsBackpack[i][j - currentFood.weight] > 0) ||
                j - currentFood.weight == 0) && foodsBackpack[i][j - currentFood.weight] + currentFood.value > foodsBackpack[i][j]){
                    foodsBackpack[i + 1][j] = foodsBackpack[i][j - currentFood.weight] + currentFood.value
                }
                else {foodsBackpack[i + 1][j] = foodsBackpack[i][j]}
            }
        }
        
        for i in 0..<drinks.count{
            let currentDrink = drinks[i]
            for j in 1...maxWeight{
                if (((j - currentDrink.weight > 0 && drinksBackpack[i][j - currentDrink.weight] > 0) ||
                j - currentDrink.weight == 0) && drinksBackpack[i][j - currentDrink.weight] + currentDrink.value > drinksBackpack[i][j]){
                    drinksBackpack[i + 1][j] = drinksBackpack[i][j - currentDrink.weight] + currentDrink.value
                }
                else {drinksBackpack[i + 1][j] = drinksBackpack[i][j]}
            }
        }
        
        var max = 0
        for i in 0...maxWeight{
            let currentFood = foodsBackpack[foods.count][i]
            for j in 0...maxWeight{
                let currentDrink = drinksBackpack[drinks.count][j]
                var result = currentFood
                if (currentDrink < currentFood){ result = currentDrink }
                if (i + j <= maxWeight && result > max) {max = result}
            }
        }
        
        return max
        
    }
}
