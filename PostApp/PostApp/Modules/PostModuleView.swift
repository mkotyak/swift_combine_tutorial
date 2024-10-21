import SwiftUI

struct PostModuleView: View {
    @ObservedObject var viewModel = PostModuleViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.body)
                        .foregroundStyle(.gray)
                }
            }
            .navigationTitle("Posts")
        }
    }
}

#Preview {
    PostModuleView()
}
