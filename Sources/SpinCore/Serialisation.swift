// Spin © 2019–2021 Constantino Tsarouhas

public struct Serialisation : TextOutputStream {
	
	/// The serialised form.
	public private(set) var serialised = ""
	
	public mutating func write(_ string: String) {
		serialised.append(contentsOf: string)
	}
	
	// TODO
	
}
