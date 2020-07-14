//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import Foundation

struct Sake : Identifiable {
    let id: Int
    let name: String
    let imageUrl: String // TODO: Firebaseの仕様に合わせて修正を行う
}
