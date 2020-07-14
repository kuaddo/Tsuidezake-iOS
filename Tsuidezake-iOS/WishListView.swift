//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct WishListView: View {
    var sakes: [Sake]
    
    var body: some View {
        NavigationView {
            List(sakes) { sake in
                NavigationLink(destination: Text("TODO: add sake detail view")) {
                    WishNormalRowView(sake: sake)
                }
            }
            .navigationBarTitle(Text("呑みたい"))
        }
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView(sakes:
            (0..<10).map { id in
                Sake(id: id, name: "秘幻 吟醸酒", imageUrl: "")
            }
        )
    }
}
