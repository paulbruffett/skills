---
name: implement
description: "Implement a piece of work based on a PRD or set of issues."
disable-model-invocation: true
---

Implement the work described by the user in the PRD or issues.

Use /tdd where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use /code-review to review the work. For each problem the review flags, propose a solution or fix alongside it — don't just list the problems.

Then run the /standards-review skill, using the branch's merge-base with the default branch as the fixed point and the PRD/issues as the spec. It checks standards conformance and spec fidelity, which the bug-hunting review doesn't cover. Propose fixes for its findings too.

Commit your work to the current branch.

Finally, ask yourself: "What are you least confident about right now?" — and share the answer with the user.
