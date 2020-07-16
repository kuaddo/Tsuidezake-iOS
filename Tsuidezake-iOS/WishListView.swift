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
        func getView(_ item: SakeListItem) -> AnyView {
            switch item {
            case .title(let area):
                return AnyView(self.getDividerWithText(area: area))
            case .sake(let sake):
                return AnyView(
                    NavigationLink(destination: Text("TODO: add sake detail view")) {
                        WishNormalRowView(sake: sake)
                    }
                )
            }
        }
        
        return List(convertToSakeListItems(sakes)) { sakeItem in getView(sakeItem)}
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