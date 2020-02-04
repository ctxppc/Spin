// Spin © 2019–2020 Constantino Tsarouhas

/// A container component that produces components from an underlying collection of data.
///
/// As with other container components, `ForEach` components do not have any intrinsic semantic meaning or behaviour.
public struct ForEach<Data : Collection, Content : Component> : Component {
	
	/// Creates a component that produces components produced by `contentProducer` for each element in `data`.
	public init(_ data: Data, @ComponentBuilder contentProducer: @escaping ContentProducer) {
		self.data = data
		self.contentProducer = contentProducer
	}
	
	/// The underlying collection.
	public let data: Data
	
	/// A function taking an element from the underlying collection and producing a component.
	public let contentProducer: ContentProducer
	public typealias ContentProducer = (Data.Element) -> Content
	
	// See protocol.
	public var body: some Component {
		EmptyComponent()
	}
	
	// See protocol.
	public func render(into renderer: inout Renderer) {
		for element in data {
			renderer.addComponent(contentProducer(element))
		}
	}
	
}
