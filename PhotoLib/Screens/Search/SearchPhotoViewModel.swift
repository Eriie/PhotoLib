import Foundation
import Combine

@MainActor
@Observable
class SearchPhotoViewModel {
    enum State {
        case idle
        case loading
        case loaded
        case error(String, retryAction: () -> Void)
    }

    private(set) var resultModel = SearchResultModel(items: [])
    private(set) var state: State = .idle

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
        loadTask?.cancel()
        
        let previusState = state
        state = .loading
        loadTask = Task { @MainActor in
            
            do {
                try await Task.sleep(for: .seconds(0.4))
                let newPhotos = try await interactor.search(query: query)

                guard !Task.isCancelled else {
                    state = previusState
                    return
                }
                self.resultModel = SearchResultModel(items: newPhotos.map { SearchPhotoItemViewModel(photoModel: $0) })
                self.state = .loaded
            } catch {
                guard !Task.isCancelled else {
                    state = previusState
                    return
                }
                self.state = .error("何かがうまくいきませんでした。もう一度お試しください") { [weak self] in
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
                self.resultModel.items.append(contentsOf: newPhotos.map { SearchPhotoItemViewModel(photoModel: $0) })
            } catch {
                guard !Task.isCancelled else { return }
                state = .error("何かがうまくいきませんでした。もう一度お試しください") { [weak self] in
                    self?.loadMore()
                }
            }
        }
    }
}
