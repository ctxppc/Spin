// Spin © 2019–2020 Constantino Tsarouhas

/// A structural component that consists of children generated from an underlying collection of data, also known as a *mapping component*.
///
/// A mapping component can be used to dynamically generate components from a data source such as a database or even a constant collection of elements.
///
/// As with other structural components, mapping components do not have any intrinsic semantic meaning or behaviour. They're not represented by any element in the output; elements produced by the mapping component are inserted directly in the element representing the closest non-structural ancestor component.
///
/// In the following SpinHTML example, a mapping component is used to create a sequence of list items.
///
/// 	List(ordered: false) {
///		    ForEach(1...5) { n in
///		        Text(n)
///		    }
/// 	}
///
/// The resulting output looks something like the following HTML.
///
///		<ul>
///		    <li>1</li>
///		    <li>2</li>
///		    <li>3</li>
///		    <li>4</li>
///		    <li>5</li>
///		</ul>
///
/// Note that there's no element specifically for the mapping component; only `List` and `Text` have corresponding elements (`<ul>` en `<li>` resp.).
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
