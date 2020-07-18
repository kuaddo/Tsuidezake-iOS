//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("ランキング")
                .tabItem {
                    Text("ランキング")
            }
            WishListView(
                sakes: (0..<10).map { id in
                    Sake(id: id, name: "秘幻 吟醸酒", imageUrl: "", area: id % 2 == 0 ? "草津" : "伊香保")
                }
            )
                .tabItem {
                    Text("呑みたい")
            }
            Text("呑んだ")
                .tabItem {
                    Text("呑んだ")
            }
            Text("マイページ")
                .tabItem {
                    Text("マイページ")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
