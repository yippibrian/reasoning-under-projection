# Reasoning Under Projection

Reasoning systems can fail not only because they infer incorrectly, but because they reason over representations that do not preserve the distinctions required for the query being answered.

This repository contains the paper:

**Reasoning Under Projection: Error, Loss, and Structural Reliability in Compressed Representations**

---

## Summary

This paper presents a conceptual and structural framework. It does not provide empirical evaluation, an inference-time intervention, or implementation-specific results; those are downstream work.

Reasoning systems do not operate on full system state. They operate on representations: compressed, partial, task-shaped, or otherwise projected forms of a richer underlying situation. A representation may support some queries while failing to support others. When a distinction required by a query is not preserved, boundedly reconstructable, or explicitly assumed in the current representation, the result is representational loss.

The paper formalizes this problem using identifiability under projection. Given a projection from an underlying state space into a representation, a query is identifiable when it is constant over the equivalence classes induced by that projection. If the query is identifiable and the system answers incorrectly, the failure is error. If the query is not identifiable under the current representation, the failure is representational loss.

This distinction gives the paper its central claim:

> A recurring structural failure occurs when systems treat non-identifiability under projection as though it were recoverable inference error.

The claim is not that representational loss is the dominant source of reasoning failure. Rather, the paper identifies a recurring and structurally important failure mode that is often misclassified as ordinary error.

The paper then identifies three structural requirements for reasoning under projection:

* **Partial observability of loss-relevant state**
* **Bounded correction**
* **Non-collapse of distinct representational roles**

These requirements do not guarantee correctness. They constrain how reasoning behaves when the current representation does not support a requested conclusion.

---

## Dependency Status

The paper distinguishes several forms of support a representation may provide for a query:

* **Preserved** — the relevant distinction survives projection.
* **Reconstructable** — the distinction can be recovered through an explicit bounded path.
* **Traceable** — the distinction cannot be recovered, but the dependency, assumption, or point of loss can be audited.
* **Opaque** — the distinction is neither recoverable nor auditable from the current representation.

Preserved and reconstructable distinctions can support inference. Traceable distinctions support accountability for transformation or loss, but not recovery of the original relation. Opaque loss supports neither recovery nor audit.

---

## What Counts as the Representation?

The representation is not limited to the prompt. It includes whatever representational state is available to the reasoning process, such as:

* prompt content
* retrieved evidence
* represented priors
* metadata
* provenance
* uncertainty markers
* task constraints
* explicit assumptions
* intermediate reasoning state, when represented

The question is not simply whether a distinction is absent from the prompt. The question is whether the distinction is available, boundedly reconstructable, or explicitly assumed in the representation actually being used.

---

## Expected Behavioral Consequences

When these constraints are respected, reasoning systems are expected to:

* avoid presenting unsupported determinate answers as justified by the projection alone
* preserve distinctions that would otherwise be collapsed
* represent uncertainty explicitly when distinctions cannot be recovered
* distinguish correction within a representation from representation expansion
* separate inference from decision when action is required under non-identifiability
* mark traceable or opaque dependencies rather than treating them as preserved

The result is not perfect reasoning, but reasoning that remains aligned with the information actually available in the representation.

---

## Who This Is For

This paper is intended for engineers, researchers, and practitioners working on reasoning systems, AI evaluation, alignment, or reliability who want a structural account of why some reasoning failures persist even when outputs appear coherent.

It may be especially relevant to work involving:

* abstraction and state compression
* source-grounded reasoning
* benchmark and evaluation design
* partial observability
* scalable oversight
* proxy metrics and Goodhart-style failures
* AI systems that must distinguish inference from decision under uncertainty

---

## What This Repository Contains

* [reasoning-under-projection.pdf](reasoning-under-projection.pdf) — the full paper

---

## Scope

This work focuses on **structural properties of reasoning**, not specific implementations or evaluated systems.

It is intended as a conceptual framework for understanding:

* why some reasoning failures are representational rather than merely inferential
* how those failures relate to projection and non-identifiability
* what constraints help make representational loss visible
* why output-level correctness alone may miss structural failure
* why local coherence is not the same as structural admissibility

The paper is strongest as a diagnostic and admissibility framework. It identifies a class of failures and the structural constraints relevant to them; it does not claim to explain all reasoning failures.

---

## Notes on Implementation and Evaluation

Operational details such as prompt configurations, enforcement mechanisms, runtime architectures, or evaluation results are **not included** in this repository.

This separation is intentional. The paper is designed to stand independently of any particular implementation and to describe constraints that apply across reasoning systems.

Mechanism and evaluation are downstream tasks. A detector for representational loss would need to identify when a query depends on distinctions that are neither preserved, nor boundedly reconstructable, nor explicitly assumed in the current representation. A dependency-status implementation would need to represent whether a claim is preserved, reconstructable, traceable, or opaque. A benchmark would need to test whether a system distinguishes unsupported determinacy from ordinary error.

One natural benchmark pattern is to compare behavior under paired compressed and enriched representations, testing whether the system changes its answer, qualifies its claim, branches over possibilities, or marks dependency status when the compressed representation does not preserve the distinctions required by the query.

---

## Why This Matters

Modern reasoning systems can produce outputs that are:

* coherent
* confident
* internally consistent

Yet these outputs can still be structurally invalid.

This occurs when systems answer as though the current representation preserves distinctions that it has actually collapsed. In such cases, the problem is not merely that the system made a bad inference. The requested query may not be identifiable from the representation being used.

This framework makes that failure mode explicit and defines structural conditions for reasoning to remain aligned with the information it actually contains.

---

## Author

Brian Cameron

---

## Citation

If you find this work useful, you can cite it as:

```text
Brian Cameron.
Reasoning Under Projection: Error, Loss, and Structural Reliability in Compressed Representations.
2026.
```

---

## Status

This paper is part of an ongoing line of work exploring:

* reasoning under projection
* identifiability and representational loss
* dependency-status tracking
* invariant-based reasoning constraints
* structural evaluation of reasoning systems

Additional artifacts and implementations may be released as this work develops.

