# Reasoning Under Projection

AI systems can fail not only because they reason incorrectly, but because they reason from compressed representations that no longer preserve the distinctions required by the claim, decision, explanation, or action being produced.

This repository contains the paper:

**Reasoning Under Projection: Structural Failure Modes and the Admissibility Framework**

---

## Overview

Modern AI systems often reason from compressed or partial representations: prompts, summaries, retrieved snippets, logs, metrics, traces, policy artifacts, tool outputs, memory, and interface-bounded context. These representations can be useful and even necessary. But they can also omit or collapse distinctions that remain operationally relevant.

The central claim of this paper is that some AI reasoning failures are not ordinary errors. They are failures of **invariant preservation under projection**. A system presents a conclusion as if it were supported by the representation available to it, even though the representation does not preserve the distinction required by that conclusion.

This produces a recurring failure mode:

> A system treats non-identifiability under projection as though it were recoverable inference error.

The result may be fluent, coherent, and persuasive while still lacking structural support. Examples include unsupported root-cause attribution, hallucinated source support, unsafe action under missing state, and metric-driven proxy success.

---

## Core Idea

A reasoning system does not operate on the full underlying situation. It operates on a representation of that situation.

A representation may preserve some distinctions while losing others. For example, a log summary may preserve that an outage occurred while losing the event ordering needed for root-cause analysis. A retrieved citation may preserve a source pointer while omitting the passage needed to verify a claim. A single metric may preserve a ranking while losing the distinction between reversible and irreversible failures.

The question is not whether a representation is complete. The question is whether it preserves the distinctions required by the claim being made.

When the required distinction survives the projection, the system can reason over it. When it does not survive, the system must change the information basis or change the answer form. It may qualify the claim, branch over assumptions, request additional information, route to an appropriate source, weaken the answer, or refuse the requested inference. What it should not do is present the missing distinction as if it had been recovered from the current representation.

---

## Error vs. Representational Loss

The paper distinguishes **error** from **representational loss**.

An **error** occurs when the information required to answer a query is present in the representation, but the system reasons incorrectly. In principle, the error can be corrected within the same representation.

A **loss** occurs when the representation does not preserve the distinction required by the query. In that case, no amount of additional reasoning over the same representation can recover the missing distinction without adding assumptions, expanding the representation, obtaining new information, or changing the answer form.

Formally, the paper frames this using identifiability under projection. Given a projection from an underlying state space into a representation, a query is identifiable when it is constant over the equivalence classes induced by that projection. If two underlying states map to the same representation but require different answers, the query is not identifiable under that projection.

This distinction is central to the paper: treating loss as error encourages overconfident answers, hallucinated support, arbitrary resolution of ambiguity, and unsafe action under incomplete state.

---

## Dependency Status

The paper introduces a dependency-status ladder for reasoning under projection. For a claim depending on some distinction, the system should determine what kind of support the current representation provides for that distinction.

| Status          | Support in the representation           | Licensed answer forms                           |
| --------------- | --------------------------------------- | ----------------------------------------------- |
| Preserved       | Distinction directly represented        | Direct answer, ordinary correction              |
| Reconstructible | Bounded recovery path available         | Reconstruction, procedural answer               |
| Traceable       | Dependency recorded but not recoverable | Mark, qualify, route, audit                     |
| Opaque          | Dependency unavailable or unauditable   | Request expansion, route, defer, or refuse form |

A distinction is **preserved** when it is directly represented in a form sufficient for the query.

A distinction is **reconstructible** when it is not directly represented, but can be recovered through an explicit bounded procedure using information available in the current representation.

A distinction is **traceable** when the dependency, source, assumption, transformation, or point of loss is recorded, but the missing distinction itself cannot be recovered.

A distinction is **opaque** when the dependency is neither recoverable nor auditable from the current representation.

The boundary between reconstructible and traceable is especially important. A citation, source hash, tool trace, or provenance pointer may make a dependency traceable, but it does not make the claim reconstructible unless the representation also includes enough content or recovery structure to determine the relevant distinction.

---

## Structural Requirements

The paper identifies three structural requirements for reasoning under projection:

1. **Partial observability of loss-relevant state**
   The system must preserve or expose detectable signs that a required distinction may be missing, ambiguous, collapsed, or dependent on assumptions not encoded in the representation.

2. **Bounded correction**
   The system must distinguish correction within the current representation from unbounded reconstruction, hidden assumption import, or replacement of the information basis.

3. **Non-collapse of distinct levels**
   The system must not treat different representational roles as interchangeable, such as confusing a representation with the underlying system, an intermediate reasoning state with a final conclusion, or a selected explanation with the full set of explanations consistent with the evidence.

These requirements do not guarantee correctness. They preserve the conditions under which reasoning failures remain visible, corrigible, and accountable.

---

## Expected Behavior

A system reasoning under projection should:

* avoid presenting unsupported determinate answers as if they followed from the representation alone;
* preserve ambiguity when multiple underlying states remain consistent with the representation;
* distinguish recoverable error from representational loss;
* separate inference from decision when action is required under non-identifiability;
* mark traceable dependencies without treating them as recovered;
* avoid collapsing distinct causal, evidential, temporal, institutional, or operational levels;
* select an answer form licensed by dependency status.

The goal is not blanket abstention. The goal is answer-form discipline. A system should answer directly when the representation supports the claim, reconstruct when bounded recovery is available, qualify or route traceable dependencies, and refuse or reformulate claims whose dependencies are opaque.

---

## Testable Consequences

The framework suggests several evaluation patterns.

**Representation-enrichment sensitivity**
If a richer representation restores a distinction that was collapsed in a compressed one, a projection-aware system should become more willing to make determinate claims. Under the compressed representation, it should qualify, branch, request expansion, or mark the dependency.

**Traceability is not reconstruction**
Adding a citation, source pointer, provenance marker, or tool trace should not be treated as sufficient support unless the representation also contains enough content or recovery structure to determine the relevant claim.

**Answer-form sensitivity**
Evaluation should consider not only whether an answer is plausible, but whether its form is licensed by the dependency status of the claim.

**Compressed/enriched diagnostic contrast**
Benchmarks can compare paired tasks that differ only in whether the query-relevant distinction is represented. A system that gives the same determinate answer form in both cases is failing to regulate claims by dependency status.

---

## AI Safety and Security Relevance

The framework is intended to help analyze failures such as:

* unsupported root-cause attribution in incident response;
* hallucinated or weakly grounded source support in retrieval-augmented generation;
* security recommendations made without the relevant code path, configuration, or threat model;
* agentic actions taken from compressed or incomplete state;
* policy or deployment decisions that collapse reversibility, uncertainty, and residual risk into a single score;
* user-modeling or Theory-of-Mind-like claims that overstate what can be inferred from partial interaction traces;
* metric-driven proxy success that hides loss of the target structure.

The central safety question is whether a system can distinguish what its representation determines, what it can reconstruct, what it can merely trace, and what it has lost.

---

## Who This Is For

This paper is intended for researchers, engineers, and practitioners working on:

* AI safety and security evaluation;
* reasoning systems;
* agentic reliability;
* retrieval-augmented generation and source grounding;
* incident-response assistants and security copilots;
* evaluation and benchmark design;
* abstraction, compression, and state representation;
* partial observability;
* auditability and provenance;
* proxy metrics and Goodhart-style failures;
* systems that must distinguish inference from decision under uncertainty.

---

## Repository Contents

* [`01-reasoning-under-projection.pdf`](01-reasoning-under-projection.pdf) — the full paper.

---

## Scope

This work focuses on structural properties of reasoning, not on a specific implementation or evaluated system.

The paper is strongest as a diagnostic and admissibility framework. It explains why some reasoning failures are representational rather than merely inferential, why local coherence is not the same as structural support, and why output-level correctness can miss failures caused by projection.

It does not claim to explain all reasoning failures, guarantee correct conclusions, eliminate ambiguity, or provide a complete implementation of dependency-status tracking. Mechanism, evaluation, and deployment remain future work.

---

## Citation

If you find this work useful, you can cite it as:

```text
Brian Cameron.
Reasoning Under Projection: Structural Failure Modes and the Admissibility Framework.
2026.
```

---

## Author

Brian Cameron

