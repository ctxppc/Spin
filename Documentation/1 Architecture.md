# Architecture of the Spin Framework
*This document contains architecture design guidelines and may not reflect the current state of the framework.*

Spin is designed in three layered parts:

* **SpinCore** defines the foundational pieces of the framework such as the `Component` and `Artefact` protocols, some foundational component and artefact types, and the necessary machinery to build components & map them to artefacts.
* **SpinDoc** defines component & artefact types that are needed for defining formatted documents with links. SpinDoc has no knowledge of HTML but is heavily inspired by and optimised for it. SpinDoc forms the foundation for document-based output formats such as HTML.
* **SpinHTML** defines HTML-centric component & artefact types as well as an HTML renderer.
