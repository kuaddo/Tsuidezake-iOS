//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import Foundation

struct SakeDetail : Identifiable {
    let id: Int
    let name: String
    let description: String?
    let brewer: String?
    let imageUrl: String // TODO: Firebaseの仕様に合わせて修正を行う
    let tags: [String]
    let suitableTemperatures: Set<SuitableTemperature>
    let goodFoodCategories: Set<FoodCategory>
}
