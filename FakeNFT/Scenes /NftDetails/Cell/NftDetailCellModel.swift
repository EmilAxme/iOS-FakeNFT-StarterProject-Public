import Foundation

struct NftDetailCellModel {
    let url: URL?
    
    init(url: String) {
        self.url = URL(string: url)
    }
}
