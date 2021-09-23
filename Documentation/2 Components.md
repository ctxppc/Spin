# Components
A **component** is a building block in Spin. Every component is a value that conforms to the `Component` protocol, which is a simple protocol containing just one requirement, a (usually computed) `body` property.

    public protocol Component {
        associatedtype Body : Component
        var body: Body { get }
    }

A component contains components in its body, which means that every component is a tree of components. A complete document or web application is usually modelled as a single component containing a deep tree of components.

    struct Site : Component {
        var body: some Component {
            Section {
                Heading("Welcome to my site!")
                WelcomeText()
            }
        }
    }
    
    struct WelcomeText : Component {
        var body: some Component {
            Paragraph("This site is for and by fellow ornithologists. We hope you enjoy your stay.")
        }
    }

Components directly conforming to this protocol (instead of a more specialised protocol) are also referred to as **thin components**. Thin components are defined completed by their body, and this is usually enough for most if not all component types defined outside of the framework. The term *thin* refers to the fact that the component type doesn't add a new layer in the rendering tree (such as in a DOM), but they remain an important tool in organising source code. It's recommended to copiously define component types with narrowly defined responsibilities, especially since they're computationally very cheap and don't increase the output size.

## Dynamic Properties
A component type can define dynamic properties, properties using a property wrapper conforming to the `DynamicProperty` type. Dynamic properties allow a component to access special values such as query results from a database (using `@QueryResults`) or values set in an ancestor component (using `@Contextual`).

    struct WelcomeText : Component {
        
        @Contextual(\.name)
        private var name: String
        
        var body: some Component {
            Paragraph("Welcome back, \(name)!")
        }
        
    }
