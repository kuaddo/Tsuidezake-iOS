//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct WishListView: View {
    var sakes: [Sake]
    
    var body: some View {
        NavigationView {
            getList(sakes)
        }
    }
    
    private func getList(_ sakes: [Sake]) -> some View {
        let groupedSakes = getGroupedSakes(sakes)
        return List {
            ForEach(groupedSakes.keys.sorted(), id: \.self) { area in
                VStack(alignment: .leading, spacing: 0) {
                    self.getDividerWithText(area: area)
                    ForEach(groupedSakes[area]!) { sake in
                        NavigationLink(destination: Text("TODO: add sake detail view")) {
                            WishNormalRowView(sake: sake)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text("呑みたい"), displayMode: NavigationBarItem.TitleDisplayMode.inline)
        .onAppear {
            // TODO: remove it after iOS 14.0
            UITableView.appearance().separatorColor = .clear
        }
    }
    
    private func getDividerWithText(area: String) -> some View {
        HStack {
            Color("light_gray").frame(width: 32, height: 1)
            Text(area).padding(.init(top: 8, leading: 0, bottom: 4, trailing: 0))
            Color("light_gray").frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
    
    private func getGroupedSakes(_ sakes: [Sake]) -> [String: [Sake]] {
        Dictionary(grouping: sakes) { sake in sake.area }
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView(sakes:
            (0..<10).map { id in
                Sake(id: id, name: "秘幻 吟醸酒", imageUrl: "", area: id % 2 == 0 ? "草津" : "伊香保")
            }
        )
    }
}
