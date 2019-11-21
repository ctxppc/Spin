# The *Spin* web framework

**Spin** is a library for rapidly developing efficient Swift-based web services and sites.

+ Value types and statelessness are main design goals
+ SwiftUI-inspired functional programming architecture
+ Builds on top of Vapor and SwiftNIO

Spin is a work in progress so the examples here might become outdated.

## Components

The basic building block in Spin is the **component**. A component is a value that has an HTML representation. To create a component, define a type that conforms to the `Component` protocol and implement its `body` protocol.
