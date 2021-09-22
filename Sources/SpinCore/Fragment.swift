// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import Foundation

/// A part of an HTML document.
public protocol Fragment : Component where Body : Fragment {}
