//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct SakeDetailView: View {
    let sakeDetail: SakeDetail
    @State private var descriptionIsExpanded = false
    @State private var isAlreadyAddedToWish = false
    @State private var isAlreadyAddedToTasted = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            getMainContainer()
            getBottomContainer()
        }.navigationBarTitle(Text("お酒詳細"), displayMode: NavigationBarItem.TitleDisplayMode.inline)
    }
    
    private func getMainContainer() -> some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Image(systemName: "circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.width * 9 / 16)
                        .background(Color("accent"))
                    Text(self.sakeDetail.name)
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 16))
                    self.getChipGroup(tags: self.sakeDetail.tags)
                        .padding(.init(top: 8, leading: 16, bottom: 0, trailing: 16))
                    // TODO: ChipGroup
                    if self.descriptionIsExpanded {
                        Text(self.sakeDetail.description ?? "")
                            .lineLimit(nil)
                            .font(.caption)
                            .padding(.init(top: 12, leading: 16, bottom: 0, trailing: 16))
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text(self.sakeDetail.description ?? "")
                            .lineLimit(3)
                            .font(.caption)
                            .padding(.init(top: 12, leading: 16, bottom: 0, trailing: 16))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            self.descriptionIsExpanded.toggle()
                        }) {
                            if self.descriptionIsExpanded {
                                Image(systemName: "chevron.up")
                                    .foregroundColor(Color("primary"))
                                    .frame(width: 24, height: 24)
                                    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 16))
                            } else {
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color("primary"))
                                    .frame(width: 24, height: 24)
                                    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 16))
                            }
                        }
                    }
                    self.getTextWithDivider(text: "おすすめの呑み方")
                        .padding(.init(top: 12, leading: 16, bottom: 0, trailing: 16))
                    ThermometerView(width: geometry.size.width - 64, suitableTemperatures: self.sakeDetail.suitableTemperatures)
                        .padding(.init(top: 16, leading: 32, bottom: 0, trailing: 32))
                    Group {
                        self.getTextWithDivider(text: "おすすめのおつまみ")
                            .padding(.init(top: 24, leading: 16, bottom: 0, trailing: 16))
                        self.getAppetizerViews(margin: 48)
                            .frame(width: geometry.size.width - 48 * 2, height: geometry.size.width / 6)
                            .padding(.init(top: 16, leading: 48, bottom: 0, trailing: 48))
                        Text("現地で呑めなかった・また呑みたい方はこちらから")
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                            .padding(.init(top: 20, leading: 0, bottom: 0, trailing: 0))
                        NavigationLink(destination: Text("hoge")) {
                            HStack(alignment: .center, spacing: 8) {
                                Image("ic_sake")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 24, height: 24)
                                Text("購入してお家で呑む")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            }
                            .padding(8)
                            .background(Color("primary"))
                            .cornerRadius(8)
                            .shadow(radius: 8)
                        }.frame(maxWidth: .infinity)
                            .padding(.init(top: 8, leading: 0, bottom: 16, trailing: 0))
                    }
                }
            }
        }
    }
    
    private func getChipGroup(tags: [String]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .foregroundColor(Color("primary"))
                        .padding(.init(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("primary"), lineWidth: 1))
                }
            }
        }
    }
    
    private func getTextWithDivider(text: String) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Text(text)
                .font(.subheadline)
            Color("light_gray")
                .frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
    
    private func getAppetizerViews(margin: CGFloat) -> some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: (geometry.size.width / 3 - margin) / 3) {
                self.getAppetizerView(
                    size: geometry.size.width / 6,
                    name: "ic_appetizers_seafood",
                    enabled: self.sakeDetail.goodFoodCategories.contains(.seafood)
                )
                self.getAppetizerView(
                    size: geometry.size.width / 6,
                    name: "ic_appetizers_meat",
                    enabled: self.sakeDetail.goodFoodCategories.contains(.meat)
                )
                self.getAppetizerView(
                    size: geometry.size.width / 6,
                    name: "ic_appetizers_dairy",
                    enabled: self.sakeDetail.goodFoodCategories.contains(.dairy)
                )
                self.getAppetizerView(
                    size: geometry.size.width / 6,
                    name: "ic_appetizers_snack",
                    enabled: self.sakeDetail.goodFoodCategories.contains(.snack)
                )
            }
        }
    }
    
    private func getAppetizerView(size: CGFloat, name: String, enabled: Bool) -> some View {
        Group {
            if enabled {
                Image(name)
                    .resizable()
                    .foregroundColor(Color("primary"))
                    .padding(6)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("primary"), lineWidth: 3))
                    .frame(minWidth: size, idealWidth: size, maxWidth: 60, minHeight: size, idealHeight: size, maxHeight: 60)
            } else {
                Image(name)
                    .resizable()
                    .foregroundColor(Color("gray"))
                    .padding(6)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("gray"), lineWidth: 3))
                    .frame(minWidth: size, idealWidth: size, maxWidth: 60, minHeight: size, idealHeight: size, maxHeight: 60)
            }
        }
    }
    
    private func getBottomContainer() -> some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                Color("gray").frame(height: 1)
                HStack(alignment: .center, spacing: 0) {
                    self.getWishButton(width: geometry.size.width / 2)
                    Color("gray")
                        .frame(width: 1, height: 40)
                        .padding(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
                    self.getTastedButton(width: geometry.size.width / 2)
                }
            }
        }.frame(height: 50)
    }
    
    private func getWishButton(width: CGFloat) -> some View {
        if isAlreadyAddedToWish {
            return getBottomContainerButton(iconName: "ic_sake", text: "呑みたいから削除", tintColor: Color("gray"), width: width) {
                self.isAlreadyAddedToWish = false
            }
        } else {
            return getBottomContainerButton(iconName: "ic_sake", text: "呑みたいに追加", tintColor: Color("primary"), width: width) {
                self.isAlreadyAddedToWish = true
            }
        }
    }
    
    private func getTastedButton(width: CGFloat) -> some View {
        if isAlreadyAddedToTasted {
            return getBottomContainerButton(iconName: "ic_tasted", text: "呑んだから削除", tintColor: Color("gray"), width: width) {
                self.isAlreadyAddedToTasted = false
            }
        } else {
            return getBottomContainerButton(iconName: "ic_tasted", text: "呑んだに追加", tintColor: Color("primary"), width: width) {
                self.isAlreadyAddedToTasted = true
            }
        }
    }
    
    private func getBottomContainerButton(iconName: String, text: String, tintColor: Color, width: CGFloat, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(alignment: .center, spacing: 4) {
                Image(iconName)
                    .resizable()
                    .foregroundColor(tintColor)
                    .frame(width: 20, height: 20)
                Text(text)
                    .font(.caption)
                    .foregroundColor(tintColor)
            }.frame(width: width)
        }
    }
}

struct SakeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SakeDetailView(
            sakeDetail: SakeDetail(
                id: 0,
                name: "秘幻 吟醸酒",
                description: "選び抜いた酒造好適米を高精白し、低温でじっくり発酵させました。フルーティできりりとした味わいであっああああああああああああああああああああああああああああああああああああああああああああああああaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaad;flkajsd;flaksjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj",
                brewer: "浅間酒造",
                imageUrl: "",
                tags: ["美味い", "辛口", "アルコール度数：中", "浅間酒造"],
                suitableTemperatures: [.cold, .warm, .hot],
                goodFoodCategories: [.meat, .dairy, .snack]
            )
        )
    }
}
