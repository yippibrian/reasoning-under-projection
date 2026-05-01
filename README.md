# Reasoning Under Projection

Reasoning systems can fail not only because they infer incorrectly, but because they reason over representations that do not preserve the distinctions required for the query being answered.

This repository contains the paper:

**Reasoning Under Projection: Error, Loss, and Structural Reliability in Compressed Representations**

---

## Summary

This paper presents a conceptual and structural framework. It does not provide empirical evaluation, an inference-time intervention, or implementation-specific results; those are addressed in separate work.

Reasoning systems do not operate on full system state. They operate on compressed representations, where distinctions may be reduced or eliminated in order to make inference tractable. When a distinction required by a later query is not preserved by the current representation, the result is representational loss.

The paper formalizes this problem using identifiability under projection. Given a projection from an underlying state space into a representation, a query is identifiable when it is constant over the equivalence classes induced by that projection. If the query is identifiable and the system answers incorrectly, the failure is error. If the query is not identifiable under the current representation, the failure is representational loss.

This distinction gives the paper its central claim:

> A recurring structural failure occurs when systems treat non-identifiability under projection as though it were recoverable inference error.

The paper then identifies three structural requirements for reasoning under projection:

- **Partial observability of loss-relevant state**
- **Bounded correction**
- **Non-collapse of distinct representational roles**

These requirements do not guarantee correctness. They constrain how reasoning behaves when the current representation does not support a requested conclusion.

---

## Expected Behavioral Consequences

When these constraints are respected, reasoning systems are expected to:

- avoid presenting unsupported determinate answers as justified by the projection alone
- preserve distinctions that would otherwise be collapsed
- represent uncertainty explicitly when distinctions cannot be recovered
- distinguish correction within a representation from representation expansion
- separate inference from decision when action is required under non-identifiability

The result is not perfect reasoning, but reasoning that remains aligned with the information actually available in the representation.

---

## Who This Is For

This paper is intended for engineers, researchers, and practitioners working on reasoning systems, AI evaluation, alignment, or reliability who want a structural account of why some reasoning failures persist even when outputs appear coherent.

---

## What This Repository Contains

- [reasoning-under-projection.pdf](reasoning-under-projection.pdf) — the full paper

---

## Scope

This work focuses on **structural properties of reasoning**, not specific implementations or evaluated systems.

It is intended as a conceptual framework for understanding:

- why some reasoning failures are representational rather than merely inferential
- how those failures relate to projection and non-identifiability
- what constraints help make representational loss visible
- why output-level correctness alone may miss structural failure

---

## Notes on Implementation

Operational details such as prompt configurations, enforcement mechanisms, runtime architectures, or evaluation results are **not included** in this repository.

This separation is intentional. The paper is designed to stand independently of any particular implementation and to describe constraints that apply across reasoning systems.

Empirical evaluation and operationalization of related ideas are described in separate work.

---

## Why This Matters

Modern reasoning systems can produce outputs that are:

- coherent
- confident
- internally consistent

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

- reasoning under projection
- identifiability and representational loss
- invariant-based reasoning constraints
- structural evaluation of reasoning systems

Additional artifacts and implementations may be released as this work develops.

