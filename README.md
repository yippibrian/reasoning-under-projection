# Reasoning Under Projection

Most reasoning systems fail not because they reason incorrectly, but because they reason over representations that have already lost the distinctions required for valid conclusions.

This repository contains the paper:

**Reasoning Under Projection: Error, Loss, and Structural Reliability in Compressed Representations**

---

## Summary

This paper presents a conceptual and structural framework. It does not provide empirical evaluation or implementation-specific results; those are addressed in separate work.

Reasoning systems do not operate on full system state. They operate on compressed representations, where distinctions are reduced or eliminated in order to make inference tractable. This compression introduces irreversible information loss.

This paper presents a structural view of reasoning under projection. It introduces a key distinction:

- **Error** — incorrect reasoning within a representation (recoverable)  
- **Loss** — missing distinctions due to projection (irrecoverable)

Systems that do not maintain this distinction can produce outputs that are indistinguishable from correct reasoning while being structurally invalid.

Many common reasoning failures arise from treating loss as recoverable error.

The paper then outlines minimal structural requirements for stable reasoning:

- **Observability of loss-relevant state**  
- **Bounded correction**  
- **Non-collapse of distinct levels**

When these constraints are respected, reasoning behavior is expected to change in consistent ways:
- invalid projections may be rejected  
- collapsed structure may be expanded into admissible form  
- missing structure may be introduced to restore stability  

The result is not perfect reasoning, but reasoning that remains aligned with the information it actually contains.

---

## Expected Behavioral Changes

If these constraints are enforced, reasoning systems are expected to:

- reject invalid projections rather than produce unjustified conclusions  
- preserve distinctions that would otherwise be collapsed  
- represent uncertainty explicitly when distinctions cannot be recovered  

---

## Who This Is For

This paper is intended for engineers, researchers, and practitioners working on reasoning systems, AI, or evaluation who want a structural understanding of why reasoning failures occur.

---

## What This Repository Contains

- [reasoning-under-projection.pdf](reasoning-under-projection.pdf) — the full paper

---

## Scope

This work focuses on **structural properties of reasoning**, not specific implementations or evaluated systems.

It is intended as a conceptual framework for understanding:
- why reasoning systems fail in systematic ways  
- how those failures relate to information loss  
- what constraints are required to make failure visible  

---

## Notes on Implementation

Operational details (such as prompt configurations, enforcement mechanisms, or evaluation results) are **not included** in this repository. This separation allows the framework to be evaluated independently of any specific technique or architecture.

This is intentional. The paper is designed to stand independently of any particular implementation, and to describe constraints that apply across systems.

Empirical evaluation of these ideas and their operationalization are described in separate work. Additional artifacts may be released at a later time.

---

## Why This Matters

Modern reasoning systems can produce outputs that are:

- coherent  
- confident  
- internally consistent  

Yet these outputs can be structurally invalid.

This occurs when systems treat irrecoverable loss as if it were recoverable error. The result is reasoning that appears correct but is not grounded in the information available to the system.

This framework makes those failures visible, and defines the conditions required for reasoning to remain structurally aligned with its representation.

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
- invariant-based reasoning constraints  
- structural evaluation of reasoning systems  

Additional artifacts and implementations may be released as this work develops.

