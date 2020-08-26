//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct WishGridRowView: View {
    var sake: Sake
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                Spacer()
            }.background(Color("accent"))
            Text(sake.name)
                .lineLimit(1)
                .padding(8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct WishGridRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WishGridRowView(sake: Sake(id: 1, name: "秘幻 吟醸酒", imageUrl: "", area: "草津"))
        }.previewLayout(.fixed(width: 400, height: 252))
    }
}
