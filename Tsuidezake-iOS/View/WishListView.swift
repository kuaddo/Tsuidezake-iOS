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
        let sakeItems = convertToSakeGridItems(sakes)
        return NavigationView {
            getList(sakeItems)
        }
    }
    
    private func getList(_ sakeItems: [SakeListItem]) -> some View {
        List {
            ForEach(sakeItems) { sakeItem in
                self.getRowView(sakeItem)
                    .listRowBackground(Color("background"))
                    .listRowInsets(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            }
        }
        .navigationBarTitle(Text("呑みたい"), displayMode: NavigationBarItem.TitleDisplayMode.inline)
    }
    
    private func getRowView(_ item: SakeListItem) -> AnyView {
        let navigationLink = NavigationLink(destination: Text("TODO: add sake detail view")) {
            EmptyView()
        }
        
        switch item {
        case .title(let area):
            return AnyView(DividerWithTextView(area: area))
        case .sakeForList(let sake):
            return AnyView(
                ZStack {
                    navigationLink
                    WishNormalRowView(sake: sake)
                }
            )
        case .sakeForGrid(let sakes):
            return AnyView(
                HStack {
                    ForEach(0..<2, id: \.self) { index in
                        self.getSakeGridRowView(sake: sakes[index], link: navigationLink)
                    }
                }
            )
        }
    }
    
    private func getSakeGridRowView(sake: Sake?, link: NavigationLink<EmptyView, Text>) -> AnyView {
        if let sake = sake {
            return AnyView(
                ZStack {
                    link
                    WishGridRowView(sake: sake)
                }
            )
        } else {
            return AnyView(Text("").frame(maxWidth: .infinity, maxHeight: 0))
        }
    }
    
    private func convertToSakeListItems(_ sakes: [Sake]) -> [SakeListItem] {
        Dictionary(grouping: sakes) { sake in sake.area }.flatMap { area, sakes in
            [SakeListItem.title(area: area)] +
                sakes.map { SakeListItem.sakeForList(sake: $0) }
        }
    }
    
    private func convertToSakeGridItems(_ sakes: [Sake]) -> [SakeListItem] {
        func mapToSakeForGrid(_ sakes: [Sake]) -> [SakeListItem] {
            sakes
                .chunked(into: 2)
                .map { sakeChunk in
                    if sakeChunk.count == 1 {
                        return SakeListItem.sakeForGrid(sakes: [sakeChunk[0], nil])
                    } else {
                        return SakeListItem.sakeForGrid(sakes: sakeChunk)
                    }
            }
        }
        
        return Dictionary(grouping: sakes) { sake in sake.area }.flatMap { area, sakes in
            [SakeListItem.title(area: area)] + mapToSakeForGrid(sakes)
        }
    }
}

enum SakeListItem {
    case title(area: String)
    case sakeForList(sake: Sake)
    case sakeForGrid(sakes: [Sake?])
}

extension SakeListItem: Identifiable {
    var id: String {
        switch self {
        case .title(let area):
            return "title : \(area)"
        case .sakeForList(let sake):
            return "sakeForList : \(sake.id)"
        case .sakeForGrid(let sakes):
            let sakeNames = sakes.filter { $0 != nil }.map { $0!.name }
            return "sakeForGrid : \(sakeNames.joined(separator: ","))"
        }
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView(sakes:
            (0..<11).map { id in
                Sake(id: id, name: "秘幻 吟醸酒\(id)", imageUrl: "", area: id > 4 ? "草津" : "伊香保")
            }
        )
    }
}
