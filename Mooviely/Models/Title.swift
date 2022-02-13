import Foundation

struct TitleSearch: Codable {
    let results: [TitleResult]
}

struct TitleResult: Codable {
    let original_title: String?
}
