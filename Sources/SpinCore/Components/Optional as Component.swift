// Spin © 2019–2020 Constantino Tsarouhas

extension Optional : Component where Wrapped : Component {
	public var body: some Component {
		self ?? EmptyComponent()
	}
}
