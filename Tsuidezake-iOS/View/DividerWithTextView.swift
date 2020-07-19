//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct DividerWithTextView: View {
    var area: String
    
    var body: some View {
        HStack {
            Color("light_gray").frame(width: 32, height: 1)
            Text(area).padding(.init(top: 8, leading: 0, bottom: 4, trailing: 0))
            Color("light_gray").frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
}

struct DividerWithTextView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DividerWithTextView(area: "草津")
        }.previewLayout(.fixed(width: 400, height: 40))
    }
}
