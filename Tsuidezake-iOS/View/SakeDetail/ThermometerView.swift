//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct ThermometerView: View {
    private let width: CGFloat
    private let height: CGFloat
    private let circleSize: CGFloat
    private let lineWeight: CGFloat
    private let aspectRatio: CGFloat = 302 / 82
    // TODO: 点の位置が絶妙にズレる。要調査
    private let boundaries: [CGFloat] = [0.13, 0.27, 0.48, 0.69, 0.9]
    private let verticalLinePercent: CGFloat = 0.8
    private let visibleDotIndices: [Int]
    private let visibleLineIndices: [Int]
    
    init(width: CGFloat, suitableTemperatures: Set<SuitableTemperature>) {
        self.width = width
        height = width / aspectRatio
        circleSize = width / 40
        lineWeight = width / 100
        
        let temperatures: Set<SuitableTemperature>
        if suitableTemperatures.isEmpty {
            temperatures = Set(SuitableTemperature.allCases)
        } else {
            temperatures = suitableTemperatures
        }
        
        var dotVisibilities = [Bool](repeating: false, count: 5)
        temperatures.forEach { temperature in
            if let (startIndex, endIndex) = temperature.toDotIndexPair() {
                dotVisibilities[startIndex].toggle()
                dotVisibilities[endIndex].toggle()
            }
        }
        visibleDotIndices = dotVisibilities.enumerated().filter { $0.1 }.map { $0.0 }
        visibleLineIndices = temperatures.compactMap { $0.toLineIndex() }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("background_thermometer")
                .resizable()
                .aspectRatio(aspectRatio, contentMode: .fit)
            ForEach(self.visibleDotIndices, id: \.self) { index in
                Circle()
                    .foregroundColor(Color("primary"))
                    .position(x: self.width * self.boundaries[index], y: self.height * self.verticalLinePercent)
                    .frame(width: self.circleSize, height: self.circleSize)
            }
            ForEach(self.visibleLineIndices, id: \.self) { index in
                Color("primary")
                    .offset(x: self.width * self.boundaries[index], y: self.height * self.verticalLinePercent - self.lineWeight / 2)
                    .frame(width: self.width * self.getLineWidthRatio(index: index), height: self.lineWeight)
            }
        }.frame(width: width, height: height)
    }
    
    private func getLineWidthRatio(index: Int) -> CGFloat {
        boundaries[index + 1] - boundaries[index]
    }
}

private extension SuitableTemperature {
    func toLineIndex() -> Int? {
        switch self {
        case .cold: return 0
        case .normal: return 1
        case .warm: return 2
        case .hot: return 3
        default: return nil
        }
    }
    
    func toDotIndexPair() -> (Int, Int)? {
        if let index = toLineIndex() {
            return (index, index + 1)
        } else {
            return nil
        }
    }
}

struct ThermometerView_Previews: PreviewProvider {
    static var previews: some View {
        ThermometerView(width: 300, suitableTemperatures: [.cold, .normal, .hot])
    }
}
