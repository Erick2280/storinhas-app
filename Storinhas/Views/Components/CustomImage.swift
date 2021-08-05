//
//  CustomImage.swift
//  Storinhas
//
//  Created by Erick Almeida on 13/07/21.
//

import SwiftUI

func CustomImage(from imagePath: ImagePath) -> Image {
    switch imagePath {
    case .catalogedAsset(let name):
        return Image(name)
    case .catalogedAssetWithOverlaidText(let name, _):
        return Image(name)
    case .externalImage(let uiImage):
        return Image(uiImage: uiImage)
    }
}

struct CustomImage_Previews: PreviewProvider {
    static var previews: some View {
        CustomImage(from: .catalogedAsset(named: "TestRabbit"))
    }
}
