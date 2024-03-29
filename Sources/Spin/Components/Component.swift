// Spin © 2019–2024 Constantino Tsarouhas

import Conifer

/// A part of a Spin app.
public protocol Component : Conifer.Component where Body : Component {}

extension Never : Component {}
extension Empty : Component {}
extension Optional : Component where Wrapped : Component {}
extension Either : Component where First : Component, Second : Component {}
extension Group : Component where repeat each Child : Component {}
extension ForEach : Component where Content : Component {}
