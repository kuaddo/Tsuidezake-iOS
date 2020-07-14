//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct WishNormalRowView: View {
    var sake: Sake
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: "circle")
                .resizable()
                .frame(width: 68, height: 68)
            Text(sake.name)
                .lineLimit(1)
                .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 8))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
    }
}

struct WishNormalRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WishNormalRowView(sake: Sake(id: 1, name: "秘幻 吟醸酒", imageUrl: ""))
        }.previewLayout(.fixed(width: 320, height: 84))
    }
}
