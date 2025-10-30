import Foundation

struct CurrencyModel: Decodable {
    let id: String
    let name: String
    let title: String
    let image: String  
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
        case image
    }
}
