//
//  BookListItem.swift
//  Bookworm
//
//  Created by Dayton Bobbitt on 12/18/21.
//

import SwiftUI

struct BookListItem: View {
    var title: String
    var author: String
    var rating: Int16
    
    var body: some View {
        HStack(spacing: 8) {
            Text(emojiRating)
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(self.title)
                    .font(.headline)
                Text(self.author)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 6)
    }
    
    private var emojiRating: String {
        switch self.rating {
        case 1:
            return "☹️"
        case 2:
            return "🙁"
        case 3:
            return "🤨"
        case 4:
            return "🙂"
        default:
            return "🥰"
        }
    }
}

struct BookListItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
            BookListItem(title: "Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", rating: 1)
            BookListItem(title: "Harry Potter and the Chamber of Secrets", author: "J.K. Rowling", rating: 2)
            BookListItem(title: "Harry Potter and the Prisoner of Azkaban", author: "J.K. Rowling", rating: 3)
            BookListItem(title: "Harry Potter and the Goblet of Fire", author: "J.K. Rowling", rating: 4)
            BookListItem(title: "Harry Potter and the Order of the Phoenix", author: "J.K. Rowling", rating: 5)
        }
    }
}
