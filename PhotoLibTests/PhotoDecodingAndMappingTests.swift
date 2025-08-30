import Foundation
import Testing
@testable import PhotoLib

struct PhotoDecodingAndMappingTests {
    
    @Test
    func decodeSearchResponse_and_mapToModels() throws {
        let json = """
        {
          "total_results": 100,
          "page": 1,
          "per_page": 2,
          "photos": [
            {
              "id": 123,
              "width": 1000,
              "height": 800,
              "url": "https://pexels.com/photo/123",
              "photographer": "John",
              "photographer_url": "https://pexels.com/john",
              "photographer_id": 10,
              "avg_color": "#336699",
              "src": {
                "original": "https://images.pexels.com/original.jpg",
                "small": "https://images.pexels.com/small.jpg",
                "tiny": "https://images.pexels.com/tiny.jpg",
                "portrait": "https://images.pexels.com/portrait.jpg"
              },
              "liked": false,
              "alt": "test"
            },
            {
              "id": 124,
              "width": 1000,
              "height": 800,
              "url": "https://pexels.com/photo/124",
              "photographer": "Jane",
              "photographer_url": "https://pexels.com/jane",
              "photographer_id": 11,
              "avg_color": "#FF00FF",
              "src": {
                "original": "https://images.pexels.com/o.jpg",
                "small": "https://images.pexels.com/s.jpg",
                "tiny": "https://images.pexels.com/t.jpg",
                "portrait": "https://images.pexels.com/p.jpg"
              },
              "liked": true,
              "alt": "test2"
            }
          ],
          "next_page": "https://api.pexels.com/v1/search?page=2&per_page=2&query=cat"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decoded = try decoder.decode(PhotoSearchResponse.self, from: json)
        #expect(decoded.totalResults == 100)
        #expect(decoded.photos.count == 2)
        
        let models = decoded.photos.map { SearchPhotoResult.PhotoModel(photo: $0) }
        #expect(models.first?.id == 123)
        #expect(models.first?.previewImage != nil)
        #expect(models.first?.fullImage != nil)
    }
}
