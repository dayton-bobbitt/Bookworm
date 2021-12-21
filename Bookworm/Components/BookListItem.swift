//
//  BookListItem.swift
//  Bookworm
//
//  Created by Dayton Bobbitt on 12/18/21.
//

import SwiftUI

struct BookListItem: View {
    private let book: Book
    
    init(for book: Book) {
        self.book = book
    }
    
    var body: some View {
        if let title = book.title, let author = book.author {
            HStack(spacing: 8) {
                if let rating = book.rating {
                    Text(emojiRating(for: rating))
                        .font(.title3)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                    Text(author)
                        .font(.subheadline)
                }
            }
            .padding(.vertical, 6)
            .foregroundColor(foregroundColor(for: book.rating))
        }
    }
    
    private func foregroundColor(for rating: Int16?) -> Color {
        if let rating = rating, rating > 1 {
            return .primary
        }
        
        return .red
    }
    
    private func emojiRating(for rating: Int16) -> String {
        switch rating {
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
