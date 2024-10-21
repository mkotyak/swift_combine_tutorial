import Combine
import Foundation

class PostModuleViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    private var cancellable: AnyCancellable?
    
    init() {
        fetchPosts()
    }
    
    private func fetchPosts() {
        guard let url: URL = .init(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] fetchedPosts in
                self?.posts = fetchedPosts
            })
    }
}
