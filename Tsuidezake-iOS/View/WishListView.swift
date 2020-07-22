//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct WishListView: View {
    var sakes: [Sake]
    
    private let SHOW_DETAIL_TAG: Int = 0
    @State var destination: AnyView? = nil
    @State var tag: Int? = nil
    
    init(sakes: [Sake]) {
        self.sakes = sakes
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().backgroundColor = UIColor(named: "background")
    }
    
    var body: some View {
        let sakeItems = convertToSakeGridItems(sakes)
        return NavigationView {
            VStack {
                NavigationLink(destination: destination, tag: SHOW_DETAIL_TAG, selection: $tag) {
                    EmptyView()
                }
                getList(sakeItems).buttonStyle(PlainButtonStyle())
            }
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
        switch item {
        case .title(let area):
            return AnyView(DividerWithTextView(area: area))
        case .sakeForList(let sake):
            return AnyView(
                Button(action: {
                    self.destination = self.getSakeDetailView(sake: sake)
                    self.tag = self.SHOW_DETAIL_TAG
                }) {
                    WishNormalRowView(sake: sake)
                }
            )
        case .sakeForGrid(let sakes):
            return AnyView(
                HStack(alignment: .center, spacing: 8) {
                    ForEach(0..<2, id: \.self) { index in
                        self.getSakeGridRowView(sake: sakes[index])
                    }
                }
            )
        }
    }
    
    private func getSakeGridRowView(sake: Sake?) -> AnyView {
        if let sake = sake {
            return AnyView(
                Button(action: {
                    self.destination = self.getSakeDetailView(sake: sake)
                    self.tag = self.SHOW_DETAIL_TAG
                }) {
                    WishGridRowView(sake: sake)
                }
            )
        } else {
            return AnyView(Text("").frame(maxWidth: .infinity, maxHeight: 0))
        }
    }
    
    private func getSakeDetailView(sake: Sake) -> AnyView {
        AnyView(Text("TODO: Implement sake detail. sake.name = \(sake.name)"))
    }
    
    private func convertToSakeListItems(_ sakes: [Sake]) -> [SakeListItem] {
        Dictionary(grouping: sakes) { sake in sake.area }
            .sorted() { $0.0 < $1.0 }
            .flatMap { area, sakes in
                [SakeListItem.title(area: area)] + sakes.map { SakeListItem.sakeForList(sake: $0) }
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
        
        return Dictionary(grouping: sakes) { sake in sake.area }
            .sorted() { $0.0 < $1.0 }
            .flatMap { area, sakes in
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
