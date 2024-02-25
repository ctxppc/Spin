// Spin © 2019–2024 Constantino Tsarouhas

import Conifer

/// A part of an XML document.
public protocol Fragment : Conifer.Component where Body : Component {}

extension Never : Fragment {}
extension Empty : Fragment {}
extension Optional : Fragment where Wrapped : Fragment {}
extension Either : Fragment where First : Component, Second : Fragment {}
extension Group : Fragment where repeat each Child : Fragment {}
extension ForEach : Fragment where Content : Fragment {}
