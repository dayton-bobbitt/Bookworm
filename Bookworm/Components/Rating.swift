//
//  Rating.swift
//  Bookworm
//
//  Created by Dayton Bobbitt on 12/18/21.
//

import SwiftUI

struct Rating: View {
    @Binding var rating: Int
    
    var maxRating = 5
    
    var onImage = Image(systemName: "star.fill")
    var offImage: Image?
    
    var onColor = Color.yellow
    var offColor = Color(uiColor: UIColor.systemGray3)
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1..<self.maxRating + 1) { possibleRating in
                // TODO: accessibility features
                image(for: possibleRating)
                    .foregroundColor(color(for: possibleRating))
                    .onTapGesture {
                        withAnimation {
                            self.rating = possibleRating
                        }
                    }
            }
        }
    }
    
    private func image(for number: Int) -> Image {
        if number <= self.rating {
            return onImage
        } else {
            return offImage ?? onImage
        }
    }
    
    private func color(for number: Int) -> Color {
        number <= self.rating ? onColor : offColor
    }
}

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            Rating(rating: .constant(3))
            Rating(rating: .constant(1), maxRating: 3, onColor: .yellow)
        }
    }
}
