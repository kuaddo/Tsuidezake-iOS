//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct WishListView: View {
    var sakes: [Sake]
    
    init(sakes: [Sake]) {
        self.sakes = sakes
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().backgroundColor = UIColor(named: "background")
    }
    
    var body: some View {
        NavigationView {
            getList(sakes)
        }
    }
    
    private func getList(_ sakes: [Sake]) -> some View {
        List {
            ForEach(convertToSakeListItems(sakes)) { sakeItem in
                self.getRowView(sakeItem)
                    .listRowBackground(Color("background"))
                    .listRowInsets(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            }
        }
        .navigationBarTitle(Text("呑みたい"), displayMode: NavigationBarItem.TitleDisplayMode.inline)
    }
    
    private func getRowView(_ item: SakeListItem) -> AnyView {
        switch item {
        case .title(let area):
            return AnyView(DividerWithTextView(area: area))
        case .sake(let sake):
            return AnyView(
                ZStack {
                    NavigationLink(destination: Text("TODO: add sake detail view")) {
                        EmptyView()
                    }
                    WishNormalRowView(sake: sake)
                }
            )
        }
    }
    
    private func convertToSakeListItems(_ sakes: [Sake]) -> [SakeListItem] {
        Dictionary(grouping: sakes) { sake in sake.area }
            .flatMap { area, sakes in
                [SakeListItem.title(area: area)] + sakes.map { SakeListItem.sake(sake: $0) }
        }
    }
}

enum SakeListItem {
    case title(area: String)
    case sake(sake: Sake)
}

extension SakeListItem: Identifiable {
    var id: String {
        switch self {
        case .title(let area):
            return "title:\(area)"
        case .sake(let sake):
            return "sake:\(sake.id)"
        }
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
