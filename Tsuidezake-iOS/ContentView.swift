//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab = "ランキング"
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                Text("ランキング")
                    .tabItem {
                        VStack {
                            Image("ic_ranking").renderingMode(.template)
                            Text("ランキング")
                        }
                }.tag("ランキング")
                WishListView(
                    sakes: (0..<11).map { id in
                        Sake(id: id, name: "秘幻 吟醸酒\(id)", imageUrl: "", area: id > 4 ? "草津" : "伊香保")
                    }
                )
                    .tabItem {
                        VStack {
                            Image("ic_sake").renderingMode(.template)
                            Text("呑みたい")
                        }
                }.tag("呑みたい")
                Text("呑んだ")
                    .tabItem {
                        VStack {
                            Image("ic_tasted").renderingMode(.template)
                            Text("呑んだ")
                        }
                }.tag("呑んだ")
                Text("マイページ")
                    .tabItem {
                        VStack {
                            Image("ic_my_page").renderingMode(.template)
                            Text("マイページ")
                        }
                }.tag("マイページ")
            }.accentColor(Color("primary"))
                .navigationBarTitle(Text(currentTab), displayMode: NavigationBarItem.TitleDisplayMode.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
