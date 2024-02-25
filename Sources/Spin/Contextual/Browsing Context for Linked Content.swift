// Spin © 2019–2024 Constantino Tsarouhas

extension Context {
	
	/// The browsing context to use for presenting linked content that is part of the web application or site.
	public var browsingContextForLinkedInternalContent: BrowsingContext {
		get { self[\.browsingContextForLinkedInternalContent] }
		set { self[\.browsingContextForLinkedInternalContent] = newValue }
	}
	
	/// The browsing context to use for presenting linked content that is *not* part of the web application or site.
	public var browsingContextForLinkedExternalContent: BrowsingContext {
		get { self[\.browsingContextForLinkedExternalContent] }
		set { self[\.browsingContextForLinkedExternalContent] = newValue }
	}
	
}

public enum BrowsingContext : Hashable {
	
	/// The current browsing context.
	case current
	
	/// A new browsing context.
	case new
	
}
