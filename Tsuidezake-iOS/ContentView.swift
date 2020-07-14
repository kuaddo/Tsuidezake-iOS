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
            Text("呑みたい")
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
