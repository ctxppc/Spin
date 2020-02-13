# Artefacts & Orchestration
An **artefact** is an intermediate representation of a component or set of components during a Spin build process. An **orchestrator** is an object that manages this build process.

An orchestrator takes a root component and an environment as input, generates artefacts for the components in the component tree, and iteratively converts artefacts into other kinds of artefacts until a final artefact is reached that is directly convertible to the desired output, e.g., HTML. An orchestrator is essentially a dependency solver that solves for the final artefact.

Artefacts or orchestrators are an implementation detail of the framework and build process. They are an important part for libraries defining output formats. Clients usually do not define artefact types or handle artefacts in their code.

## Thin Artefact
A **thin artefact** represents a thin component.
