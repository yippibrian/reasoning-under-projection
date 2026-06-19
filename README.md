# Reasoning Under Projection

AI systems can fail not only because they infer incorrectly, but because they
reason from compressed representations that do not preserve the distinctions
required for safe action, source-grounded claims, security judgment, or
root-cause analysis.

This repository contains the paper:

**Reasoning Under Projection: Error, Loss, and Structural Reliability in Compressed Representations**  
*A Framework for AI Safety, Security Evaluation, and Agentic Reliability*

---

## Summary

This paper presents a structural account of a recurring AI safety and reliability
failure: a system presents a conclusion as supported by its current
representation when the representation does not preserve the distinction required
by the claim.

This matters for systems that answer from prompts, summaries, retrieval results,
logs, traces, metrics, policy artifacts, compressed context windows, or
tool-mediated state. Such systems may produce outputs that are coherent and
persuasive while still lacking structural support.

Reasoning systems do not operate on full system state. They operate on
representations: compressed, partial, task-shaped, or otherwise projected forms
of a richer underlying situation. A representation may support some queries while
failing to support others. When a distinction required by a query is not
preserved, boundedly reconstructable, or explicitly assumed in the current
representation, the result is representational loss.

When loss occurs, a reliable system must change the information basis or answer
form: for example by qualifying the claim, branching over assumptions, requesting
additional representation, routing to an appropriate source or procedure, or
refusing the requested inference.

The paper formalizes this problem using identifiability under projection. Given
a projection from an underlying state space into a representation, a query is
identifiable when it is constant over the equivalence classes induced by that
projection. If the query is identifiable and the system answers incorrectly, the
failure is error. If the query is not identifiable under the current
representation, the failure is representational loss.

This distinction gives the paper its central claim:

> A recurring structural failure occurs when systems treat non-identifiability
  under projection as though it were recoverable inference error.

The claim is not that representational loss is the dominant source of reasoning
failure. Rather, the paper identifies a recurring and structurally important
failure mode that is often misclassified as ordinary error.

The paper derives the **dependency status** of claims after projection from the
answer forms licensed by the current representation. For a claim depending on a
distinction, the system must determine whether that distinction is directly
available for inference, recoverable by a bounded procedure, only recorded as a
dependency, or unavailable even for audit. These cases correspond to preserved,
reconstructable, traceable, and opaque dependency status. The ladder is not a
complete ontology of epistemic states; it is a minimal operational partition for
deciding whether the system may answer directly, reconstruct procedurally, mark
or route a dependency, qualify the claim, request representation expansion, or
refuse the requested inference.

It also identifies three structural constraints that help preserve and act on
dependency status during reasoning:

* **Partial observability of loss-relevant state**
* **Bounded correction**
* **Non-collapse of distinct representational roles**

These requirements are not claimed to be necessary and sufficient for all
reliable reasoning under projection. They are failure-preserving constraints
because they block three generic routes by which unsupported dependency status
can be promoted into apparently supported inference: unsupported dependencies can
remain invisible, repair can silently strengthen traceable or opaque loss into
apparent reconstruction, and support can be transferred from one representational
level to another.

---

## Dependency Status

For a query and a representation, **dependency status** refers to the kind of
support the representation provides for the distinctions on which an answer
depends. It is not identical to provenance, confidence, observability, or
identifiability, although it may involve each of them.

The paper distinguishes several forms of support a representation may provide
for a query:

| Status | Support in the representation | Licensed answer forms |
|---|---|---|
| Preserved | Distinction directly represented | Direct answer, ordinary correction |
| Reconstructable | Bounded recovery path available | Reconstruction, procedural answer |
| Traceable | Dependency recorded but not recoverable | Mark, qualify, route, audit |
| Opaque | Dependency unavailable or unauditable | Request expansion, route, defer, or refuse form |

* **Preserved** — the relevant distinction remains directly represented in a form
  sufficient for the query.
* **Reconstructable** — the distinction is not directly represented, but can be
  recovered through an explicit bounded procedure using information available in
  the representation.
* **Traceable** — the distinction cannot be recovered, but the dependency,
  assumption, source, transformation, or point of loss can be audited.
* **Opaque** — the distinction is neither recoverable nor auditable from the
  current representation.

The boundary between reconstructable and traceable depends on whether the
representation contains enough information to recover the distinction needed by
the query, not merely enough information to identify where that distinction once
came from. For example, a source hash, citation identifier, or provenance pointer
may make a dependency traceable by recording that a claim depends on an external
source. It is reconstructable only if the representation available to the
reasoner also includes, retrieves, or otherwise supplies enough source content
and recovery rules to determine the query-relevant distinction.

Preserved and reconstructable distinctions can support inference. Traceable
distinctions support accountability for transformation or loss, but not recovery
of the original relation. Opaque loss supports neither recovery nor audit.

---

## What Counts as the Representation?

The representation is not limited to the prompt. It includes whatever
representational state is available to the reasoning process, such as:

* prompt content
* retrieved evidence
* represented priors
* metadata
* provenance
* uncertainty markers
* task constraints
* explicit assumptions
* intermediate reasoning state, when represented

The question is not simply whether a distinction is absent from the prompt. The
question is whether the distinction is available, boundedly reconstructable, or
explicitly assumed in the representation actually being used.

---

## Expected Behavioral Consequences

When these constraints are respected, reasoning systems are expected to:

* avoid presenting unsupported determinate answers as justified by the projection
  alone
* preserve distinctions that would otherwise be collapsed
* represent uncertainty explicitly when distinctions cannot be recovered
* distinguish correction within a representation from representation expansion
* separate inference from decision when action is required under
  non-identifiability
* mark traceable or opaque dependencies rather than treating them as preserved or
  reconstructable
* select a response form licensed by dependency status, rather than treating
  direct answers, conditional answers, clarification, tracing, weakening,
  routing, or refusal as merely stylistic choices


The result is not perfect reasoning, but reasoning that remains aligned with the
information actually available in the representation.

---

## Testable Consequences

The framework predicts several evaluation patterns.

* **Representation-enrichment sensitivity** — if an enriched representation
  restores a distinction that was collapsed in a compressed representation, a
  projection-aware system should become more willing to make determinate claims.
  Under the compressed representation, it should qualify, branch, request
  representation expansion, or mark the dependency.

* **Traceability is not reconstruction** — adding a citation identifier,
  provenance pointer, source hash, or tool trace may make a dependency traceable,
  but it does not make the claim reconstructable unless the representation also
  supplies enough source content or recovery rules to determine the relevant
  distinction.

* **Answer-form sensitivity** — evaluation should score not only whether an
  answer is plausible or correct-looking, but whether its form is licensed by the
  dependency status of the claim. A direct answer, conditional answer, routed
  answer, clarification request, trace marking, and refusal are not merely
  stylistic variants.

* **Compressed/enriched diagnostic contrast** — benchmarks can compare paired
  tasks that differ only in whether the query-relevant distinction is
  represented. A system that gives the same determinate answer form in both
  conditions is failing to regulate claims by dependency status.

---

## AI Safety and Security Relevance

The framework is intended to help analyze and evaluate failures such as:

* unsupported root-cause attribution in incident response
* hallucinated or weakly grounded source support in RAG systems
* security recommendations made without the relevant code path, configuration, or threat model
* agentic actions taken from compressed or incomplete state
* policy or deployment decisions that collapse reversibility, uncertainty, and residual risk into a single score
* user-modeling or Theory-of-Mind-like claims that overstate what can be inferred from partial interaction traces

The central safety question is whether a system can distinguish what its representation preserves, what it can reconstruct, what it can merely trace, and what it has lost.

---

## Who This Is For

This paper is intended for engineers, researchers, and practitioners working on
AI safety, AI security, reasoning systems, agentic reliability, RAG/source
grounding, evaluation, alignment, or audit who want a structural account of why
some failures persist even when outputs appear coherent.

It may be especially relevant to work involving:

* AI safety and security evaluation
* incident-response and root-cause analysis assistants
* security copilots and code assistants
* retrieval-augmented generation and source grounding
* agentic systems acting from compressed state
* user modeling and Theory-of-Mind-like inference
* abstraction and state compression
* benchmark and evaluation design
* partial observability
* scalable oversight
* proxy metrics and Goodhart-style failures
* systems that must distinguish inference from decision under uncertainty

---

## What This Repository Contains

* [reasoning-under-projection.pdf](reasoning-under-projection.pdf) — the full
  paper on error, loss, dependency status, and AI safety/security evaluation

---

## Scope

This work focuses on **structural properties of reasoning**, not specific
implementations or evaluated systems.

It is intended as a conceptual framework for understanding:

* why some reasoning failures are representational rather than merely inferential
* how those failures relate to projection and non-identifiability
* what constraints help make representational loss visible
* why output-level correctness alone may miss structural failure
* why local coherence is not the same as structural admissibility

The paper is strongest as a diagnostic and admissibility framework. It identifies
a class of failures and the structural constraints relevant to them; it does not
claim to explain all reasoning failures or provide empirical evaluation,
inference-time interventions, or implementation-specific results.

---

## Notes on Implementation and Evaluation

Operational details such as prompt configurations, enforcement mechanisms,
runtime architectures, or evaluation results are **not included** in this
repository.

This separation is intentional. The paper is designed to stand independently of
any particular implementation and to describe constraints that apply across
reasoning systems.

Mechanism and evaluation are downstream tasks. A detector for representational
loss would need to identify when a query depends on distinctions that are neither
preserved, nor boundedly reconstructable, nor explicitly assumed in the current
representation. A dependency-status implementation would need to represent
whether a claim is preserved, reconstructable, traceable, or opaque. A benchmark
would need to test whether a system distinguishes unsupported determinacy from
ordinary error.

One natural benchmark pattern is to compare behavior under paired compressed and
enriched representations, testing whether the system selects an admissible
response form: changing its answer, qualifying its claim, branching over
possibilities, requesting additional representation, routing to an appropriate
source or procedure, or marking dependency status when the compressed
representation does not preserve the distinctions required by the query.

This paper is the conceptual foundation for companion work on structural
evaluation and admissibility-kernel prompting. Those downstream artifacts treat
the ideas here as evaluation targets: loss visibility, bounded correction,
error--loss distinction, non-collapse, dependency-status labeling, and
answer-form admissibility.

---

## Author

Brian Cameron

---

## Citation

If you find this work useful, you can cite it as:

```text
Brian Cameron.
Reasoning Under Projection: Error, Loss, and Structural Reliability in Compressed
Representations.
2026.
```

---

## Status

This paper is part of an ongoing line of work exploring:

* reasoning under projection
* identifiability and representational loss
* dependency-status tracking
* structural constraints for reasoning under projection
* structural evaluation of reasoning systems
* AI safety and security evaluation under compressed or partial state

Additional artifacts and implementations may be released as this work develops.

