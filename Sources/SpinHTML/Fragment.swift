// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A part of an HTML document.
public protocol Fragment : Component where Body : Fragment /*, Artefact == XMLNode */ {}

extension Never : Fragment {}
extension Empty : Fragment {}
extension Optional : Fragment where Wrapped : Fragment {}
extension Either : Fragment where First : Fragment, Second : Fragment {}
extension Group : Fragment where First : Fragment, Second : Fragment {}
extension ForEach : Fragment where Content : Fragment {}
