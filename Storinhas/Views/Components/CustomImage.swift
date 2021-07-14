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
    }
}

struct CustomImage_Previews: PreviewProvider {
    static var previews: some View {
        CustomImage(from: .catalogedAsset(named: "TestRabbit"))
    }
}
