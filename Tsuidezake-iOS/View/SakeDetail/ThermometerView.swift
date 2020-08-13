//
//  Tsuidezake-iOS
//  Copyright © 2020 kuaddo. All rights reserved.
//

import SwiftUI

struct ThermometerView: View {
    private let boundaries: [CGFloat] = [0.13, 0.27, 0.48, 0.69, 0.9]
    private let verticalLinePercent: CGFloat = 0.8
    private let visibleDotIndices: [Int]
    private let visibleLineIndices: [Int]
    
    init(suitableTemperatures: Set<SuitableTemperature>) {
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
        GeometryReader { geometry in
            return ZStack(alignment: .topLeading) {
                Image("background_thermometer")
                    .resizable()
                    .aspectRatio(3.682926829, contentMode: .fit)
                ForEach(self.visibleDotIndices, id: \.self) { index in
                    Circle()
                        .foregroundColor(Color("primary"))
                        .position(x: geometry.size.width * self.boundaries[index], y: geometry.size.height * self.verticalLinePercent)
                        .frame(width: 10, height: 10)
                }
                ForEach(self.visibleLineIndices, id: \.self) { index in
                    Color("primary")
                        .offset(x: geometry.size.width * self.boundaries[index], y: geometry.size.height * self.verticalLinePercent - 2)
                        .frame(width: geometry.size.width * self.getLineWidthRatio(index: index), height: 4)
                }
            }
        }
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
        Group {
            ThermometerView(suitableTemperatures: [.cold, .normal, .hot])
        }.previewLayout(.fixed(width: 302, height: 82))
    }
}
