import Foundation

struct Book: Codable {
    let id: Int
    let title: String
    let desc: String
    let link: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case desc = "description"
        case link = "yes24Link"
        case date = "publicationDate"
    }
}

struct BookList: Codable {
    let list: [Book]
    let totalCount: Int
    let code: Int
    let message: String?
}

struct BookDetail: Codable {
    let book: Book
    let code: Int
    let message: String?
}

