import Foundation
import protocol GraphQL.MapFallibleRepresentable
@_exported import enum GraphQL.Map
@_exported import enum GraphQL.MapError

final class AnyType : Hashable {
	let type: Any.Type
	let typeName: String
	
	init(_ type: Any.Type) {
		self.type = type
		self.typeName = String(reflecting: type)
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(String(describing: typeName))
	}
	
	static func == (lhs: AnyType, rhs: AnyType) -> Bool {
		return lhs.typeName == rhs.typeName
	}
}

func isProtocol(type: Any.Type) -> Bool {
    let description = String(describing: Swift.type(of: type))
    return description.hasSuffix("Protocol")
}

func fixName(_ name: String) -> String {
	// Remove the module from the type name, but allow nested types.
	// `Swift.String` becomes `String`, and `FooModule.Bar.Baz` becomes `Bar.Baz`.
	let splitByModule = name.split(separator: ".")
	let moduleRemoved: String
	if splitByModule.count > 1 {
		moduleRemoved = String(splitByModule.dropFirst().joined())
	} else {
		moduleRemoved = name
	}
	let set = CharacterSet.letters
	let fixedName = moduleRemoved.components(separatedBy: set.inverted).joined()
	return fixedName
}

func isMapFallibleRepresentable(type: Any.Type) -> Bool {
    if isProtocol(type: type) {
        return true
    }

    if let type = type as? Wrapper.Type {
        return isMapFallibleRepresentable(type: type.wrappedType)
    }

    return type is MapFallibleRepresentable.Type
}

