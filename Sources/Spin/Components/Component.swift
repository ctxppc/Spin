// Spin © 2019–2023 Constantino Tsarouhas

import Conifer

/// A part of a Spin site.
public protocol Component : Conifer.Component where Body : Component {}

extension Never : Component {}
extension Empty : Component {}
extension Optional : Component where Wrapped : Component {}
extension Either : Component where First : Component, Second : Component {}
extension Group : Component where First : Component, Second : Component {}
extension ForEach : Component where Content : Component {}
