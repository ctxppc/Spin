// Spin © 2019–2020 Constantino Tsarouhas

import SpinCore

/// A component that presents exactly one child, depending on the currently active navigation element.
///
/// A navigation area adds an additional level on the navigation path of the component wherein the navigation area is contained. This new navigation element identifies the presented navigation area's child. The first child is always accessible from the empty element. Other children are identified by their identifier which can be set using the `.identifier(_:)` modifier. Children without an explicit identifier are numbered, starting from 1. These implicit identifiers are not stable; it's therefore recommended to provide explicit identifiers.
///
/// The following example defines a navigation area with 3 children. If the `NavigationArea` is contained in a component accessible from `/`, then `WelcomePage()` is accessible from `/`, `ContactPage()` from `/contact`, and `AboutUsPage()` from `/about-us`.
///
///     NavigationArea {
///         WelcomePage()
///         ContactPage()
///         	.identified(by: "contact")
///         AboutUsPage()
///         	.identified(by: "about-us")
///         ForumPage()
///         	.identified(by: "forum")
///     }
///
///
/// Structural components such as `ForEach` and `Either` are not considered children of a navigation area but instead the non-structural descendants contained therein. For example, a `ForEach` component can be used to dynamically add children to the navigation area for presenting dynamic content. A `ForEach` component automatically associates the data source's identifiers to its children component; it is therefore unnecessary to provide explicit identifiers to these children.
///
/// 	NavigationArea {
///			TopicsList()
///			ForEach(in: self.topics) { topic in
///				TopicPage(topic: topic)
///			}
/// 	}
///
/// To replace the content in a navigation area from within an action, return the new content as the action's result. To let the user replace the content by some component, use a link.
///
/// 	struct LoginForm : Component {
///
///			@Authenticated var profile: Profile?
///			@State var emailAddress = ""
///			@State var password = ""
///			@State var failure = false
///
///			var body: some Component {
///				Form {
///					If(failure) {
///						Alert(kind: .error, message: "E-mail address or password incorrect")
///					}
///					TextField(for: $emailAddress)
///						.label("E-mail Address")
///					TextField(for: $password, secure: true)
///						.label("Password")
///					Button(action: self.submit) { "Log in" }
///						.primary()
///					Link(to: ProfileRecoveryPage()) { "I forgot my password" }
///				}
///			}
///
///			func submit() -> some Component {
///				profile = Profile.authenticate(emailAddress: emailAddress, password: password, on: connection)
///				return If(profile != null) {
///					LoginSuccessPage()
///				} else: { () -> Self in
///					self.failure = true
///					return self
///				}
///			}
///
/// 	}
///
/// Links and actions must only refer to navigable components, i.e., components that are a child of some navigation area in the component tree. Links to non-navigable components are disabled in the rendered document (and a warning is logged). When an action returns a non-navigable component, the navigation path is left unchanged and an error is thrown, which may be presented as an internal error alert on a web application client.
public struct NavigationArea : Component {
	
	// See protocol.
	public var body: some Component {
		EmptyComponent()	// TODO
	}
	
}
