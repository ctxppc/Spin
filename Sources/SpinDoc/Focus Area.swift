// Spin © 2019–2021 Constantino Tsarouhas

import SpinCore

/// A structural component that presents exactly one child and hides all others, depending on the currently focussed component in the document.
///
/// A focus area can be configured with children using structural elements such as `ForEach` and `Group`. The area renders the child that is or contains an active component as determined by the contextual `focussedComponentIdentifier` property. The focus area's other children are not rendered. When no component is explicitly in focus, the focus area renders the first child.
///
/// The following example defines a focus area with 4 children.
///
///     FocusArea {
///         WelcomePage()
///         ContactPage()
///         AboutUsPage()
///         ForumPage()
///     }
///
/// Structural components such as `ForEach` and `Either` are not considered children of a focus area. Instead, the non-structural descendants are considered. For example, a `ForEach` component can be used to dynamically add children to the focus area for presenting dynamic content.
///
/// 	FocusArea {
///			TopicsList()
///			ForEach(in: self.topics) { topic in
///				TopicPage(topic: topic)
///			}
/// 	}
///
/// Links allow the user to focus a specific component. Links are created with identifiers, as associated to a component using the `.identified(by:)` modifier.
///
///     struct AboutUsPage : Component {
///
///			struct ID : Identifier {}
///
///			var body: some Component {
///				Article {
///					Header("About Us")
///					Paragraph("This is a blog about birds!")
///				}.identified(by: ID())
///			}
///
///     }
///
///     struct WelcomePage : Component {
///			var body: some Component {
///				Article {
///					Header("Welcome to the Ornithology blog")
///					Link(to: AboutUsPage.ID()) { "About Us" }
///				}
///			}
///     }
///
/// Actions can also determine a new focussed element at their completion.
///
/// 	struct LoginForm : Component {
///
///			@Contextual(\.request) var request
///			@Authenticated var profile: Profile?
///			@State var emailAddress = ""
///			@State var password = ""
///			@State var failure = false
///
///			var body: some Component {
///				Form {
///					if failure {
///						Alert(kind: .error, message: "E-mail address or password incorrect")
///					}
///					TextField(for: $emailAddress)
///						.label("E-mail Address")
///					TextField(for: $password, secure: true)
///						.label("Password")
///					Button(action: self.submit) { "Log in" }
///						.primary()
///					Link(to: ProfileRecoveryPage.ID()) { "I forgot my password" }
///				}
///			}
///
///			func submit() -> EventLoopFuture<ActionResult> {
///				Profile.authenticate(emailAddress: emailAddress, password: password, on: request)
///					.map { profile in
///						.focus(ThreadListPage.ID())
///					}.flatMapErrorThrowing { error in
///						if error is InvalidCredentialsError {
///							return .update { component in
///								component.failure = true
///							}
///						} else {
///							throw error
///						}
///					}
///			}
///
/// 	}
///
public struct FocusArea : Component {
	
	// See protocol.
	public var body: some Component {
		EmptyComponent()	// TODO
	}
	
}
