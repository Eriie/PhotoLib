import Foundation
import Combine

@MainActor
class SearchPhotoViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
        case error(String, retryAction: () -> Void)
    }

    @Published private(set) var photos: [Photo] = []
    @Published private(set) var state: State = .idle

    private let interactor: SearchPhotoInteractor
    private var loadTask: Task<Void, Never>?

    init(dataSource: SearchPhotoDataSource) {
        self.interactor = SearchPhotoInteractor(dataSource: dataSource)
    }

    func search(query: String) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            state = .idle
            return
        }
        state = .loading
        photos = []

        // Cancel any existing task
        loadTask?.cancel()
        
        loadTask = Task {
            do {
                let newPhotos = try await interactor.search(query: query)

                guard !Task.isCancelled else { return }
                self.photos = newPhotos
                self.state = .loaded
            } catch {
                guard !Task.isCancelled else { return }
                self.state = .error(error.localizedDescription) { [weak self] in
                    self?.search(query: query)
                }
            }
        }
    }

    func loadMore() {
        guard case .loaded = state else { return }

        loadTask?.cancel()
        
        loadTask = Task {
            do {
                let newPhotos = try await interactor.loadMore()

                guard !Task.isCancelled else { return }
                self.photos.append(contentsOf: newPhotos)
            } catch {
                guard !Task.isCancelled else { return }
                state = .error("Something went wrong try again") { [weak self] in
                    self?.loadMore()
                }
            }
        }
    }
}
