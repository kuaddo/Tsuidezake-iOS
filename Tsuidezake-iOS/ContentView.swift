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
                    VStack {
                        Image("ic_ranking").renderingMode(.template)
                        Text("ランキング")
                    }
            }
            WishListView(
                sakes: (0..<10).map { id in
                    Sake(id: id, name: "秘幻 吟醸酒", imageUrl: "", area: id % 2 == 0 ? "草津" : "伊香保")
                }
            )
                .tabItem {
                    VStack {
                        Image("ic_sake").renderingMode(.template)
                        Text("呑みたい")
                    }
            }
            Text("呑んだ")
                .tabItem {
                    VStack {
                        Image("ic_tasted").renderingMode(.template)
                        Text("呑んだ")
                    }
            }
            Text("マイページ")
                .tabItem {
                    VStack {
                        Image("ic_my_page").renderingMode(.template)
                        Text("マイページ")
                    }
            }
        }.accentColor(Color("primary"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
