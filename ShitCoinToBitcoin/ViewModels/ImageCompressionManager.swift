//
//  ImageCompressionManager.swift
//  ShitCoinToBitcoin
//
//  Created by Rahul Roy on 02/04/23.
//

import Foundation
import SwiftUI

class ImageCompressionManager {
    func compressImage(image: UIImage) -> UIImage {
        let resizedImage = image.aspectFittedToHeight(200)
        return resizedImage
    }
}

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
