import Foundation

public struct Collection {
    public var alias: String?
    public var title: String
    public var description: String?
    public var styleSheet: String?
    public var isPublic: Bool?
    public var views: Int?
    public var email: String?
    public var url: String?
}

extension Collection: Decodable {
    enum CodingKeys: String, CodingKey {
        case alias
        case title
        case description
        case styleSheet = "style_sheet"
        case isPublic = "public"
        case views
        case email
        case url
    }

    /// Creates a basic `Collection` object.
    ///
    /// This initializer creates a bare-minimum `Collection` object for sending to the server; use the decoder-based
    /// initializer to populate its other properties from the server response.
    ///
    /// If no `alias` parameter is provided, one will be generated by the server.
    ///
    /// - Parameters:
    ///   - title: The title to give the Collection.
    ///   - alias: The alias for the Collection.
    public init(title: String, alias: String?) {
        // These properties are initialized when the user creates a collection.
        self.alias = alias
        self.title = title

        // These properties come from a server response.
        self.description = nil
        self.styleSheet = nil
        self.isPublic = nil
        self.views = nil
        self.email = nil
        self.url = nil
    }

    /// Creates a `Collection` object from the server response.
    ///
    /// Primarily used by the `WriteFreelyClient` to create a `Collection` object from the JSON returned by the server.
    ///
    /// - Parameter decoder: The decoder to use for translating the server response to a Swift object.
    /// - Throws: Error thrown by the `try` attempt when decoding any given property.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        alias = try container.decode(String.self, forKey: .alias)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        styleSheet = try container.decode(String.self, forKey: .styleSheet)
        isPublic = try container.decode(Bool.self, forKey: .isPublic)
        views = try container.decode(Int.self, forKey: .views)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}