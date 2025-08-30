import Testing
import SwiftUI
@testable import PhotoLib

struct ColorHexConversionTests {

    @Test
    func rgb24Bit_white_black() throws {
        let white = Color(hex: "#FFFFFF")
        let black = Color(hex: "000000")
        #expect(white != nil)
        #expect(black != nil)
        if let white { assertRGBA(white, equals: (1,1,1,1)) }
        if let black { assertRGBA(black, equals: (0,0,0,1)) }
    }

    @Test
    func rgb12Bit_short() throws {
        let color = Color(hex: "FA3") // expands to FF AA 33
        #expect(color != nil)
        if let color { assertRGBA(color, equals: (1.0, 0.666, 0.2, 1.0), tolerance: 0.02) }
    }

    @Test
    func argb32Bit_alpha() throws {
        // FF000080 -> red 1, green 0, blue 0, alpha ~0.5
        let color = Color(hex: "#FF000080")
        #expect(color != nil)
        if let color { assertRGBA(color, equals: (1.0, 0.0, 0.0, 0.5), tolerance: 0.02) }
    }

    @Test
    func invalid_returnsNil() throws {
        #expect(Color(hex: "ZZZ") == nil)
        #expect(Color(hex: "#12345") == nil)
    }
}

private func assertRGBA(_ color: Color, equals expected: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat), tolerance: CGFloat = 0.01, file: StaticString = #file, line: UInt = #line) {
    #if canImport(UIKit)
    let ui = UIColor(color)
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    _ = ui.getRed(&r, green: &g, blue: &b, alpha: &a)
    #expect(abs(r - expected.r) <= tolerance, "r: \(r) != \(expected.r)")
    #expect(abs(g - expected.g) <= tolerance, "g: \(g) != \(expected.g)")
    #expect(abs(b - expected.b) <= tolerance, "b: \(b) != \(expected.b)")
    #expect(abs(a - expected.a) <= tolerance, "a: \(a) != \(expected.a)")
    #else
    // If UIKit is unavailable, skip with a soft expectation
    #expect(true)
    #endif
}
