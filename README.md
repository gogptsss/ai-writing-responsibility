
# ACRE Publishing OS  
## A Responsible, Reproducible Human–AI Publishing System

ACRE Publishing OS is an open, reproducible publishing system designed
for **human authorship in the age of AI**.

It treats writing, publishing, governance, teaching, and maintenance
as **first-class system components**, not afterthoughts.

---

## 📌 What This Repository Is

This repository is:

- 📘 A **real, working example** of the ACRE Publishing OS
- 🧠 A **teaching-ready system** (not just a codebase)
- 🧭 A **governed project** with explicit responsibility boundaries
- 🤖 A **human–AI co-authoring environment**, with rules

This repository is **not**:

- ❌ A generic AI writing tool
- ❌ A prompt collection
- ❌ A “magic automation” system

---

## 🚀 Quick Start (You Only Need 3 Things)

> If you remember only **three sentences**, remember these:

1. **Chinese (zh) is the sovereign text.**  
   English (en) is a *controlled derivative* and can be enabled or disabled.
2. **Nothing is “publishable” until it passes QA and baseline checks.**
3. **AI can write drafts, but humans remain responsible.**

---

### 🔧 Minimal Setup

```bash
git clone https://github.com/gogptsss/ai-writing-responsibility.git
cd ai-writing-responsibility
````

Run QA (Chinese):

```bash
make qa BOOK_LANG=zh
```

Strict QA + publishable formats:

```bash
make qa-strict BOOK_LANG=zh
```

If successful, you will see:

```text
build/zh/book.pdf
build/zh/book.epub
```

---

## 🧱 Repository Structure (Human Explanation)

```text
manuscript/        # Source manuscripts (zh = primary, en = derived)
scripts/           # Build, QA, dashboard scripts
config/            # QA rules, pandoc / LaTeX config
build/             # Generated outputs (ignored by Git)
dist/              # Release-ready artifacts
docs/              # Whitepaper, appendices, teaching materials
```

> **Rule of thumb:**
> If you didn’t run a command to generate it, it probably doesn’t belong in `build/`.

---

## 🧭 Governance / Teaching / Maintainer Pack (Official Release)

This project ships its **governance, teaching, and maintainer practices**
as a **first-class release artifact**, not scattered documents.

📦 **Download the Governance Pack (v1):**
[https://github.com/gogptsss/ai-writing-responsibility/releases/tag/governance-v1](https://github.com/gogptsss/ai-writing-responsibility/releases/tag/governance-v1)

Included:

* Teaching Appendix A & B
  *(Quick Start + Grading Cards)*
* Governance Appendix
  *(Maintainer Playbook)*
* Maintainer execution cards
* AI prompts for responsible maintenance

> This release contains **no code changes**.
> It defines **how responsibility is practiced**.

---

## 📘 Book / Whitepaper Mapping

This repository directly maps to the book:

> **ACRE Publishing OS · Operational Whitepaper**

| Repository          | Book                           |
| ------------------- | ------------------------------ |
| Quick Start         | Part III – End-to-End Practice |
| Governance Pack     | Appendix A / B                 |
| Maintainer Playbook | Governance Appendix            |
| QA / Baseline       | Publishing Gates               |

The book is **derived from this repository**, not the other way around.

---

## 🧠 Human–AI Collaboration Principles (Short Version)

* AI may generate drafts.
* AI may assist with translation.
* AI may help with structure.

**AI may not:**

* Decide publication readiness
* Override QA baselines
* Take responsibility

Responsibility is always **human-held** and **system-enforced**.

---

## 👩‍🏫 For Teaching / Classroom Use

This repository is designed to be:

* Forked for coursework
* Used in writing / publishing classes
* Evaluated using grading cards (Appendix B)

Students are graded on:

* Reproducibility
* QA compliance
* Clarity of authorship responsibility

---

## 🛠 Maintainers

Maintainers are expected to:

* Enforce QA gates
* Reject non-reproducible changes
* Maintain human responsibility boundaries

📘 See the **Maintainer Playbook** in the Governance Pack.

---

## 🤝 Contributing

Contributions are welcome **within governance rules**.

Before submitting:

* Read the Governance Pack
* Understand QA requirements
* Accept responsibility boundaries

Pull requests that bypass governance **will not be merged**.

---

## 📜 License

Code and documentation are released under the project’s open license.
Governance materials may have additional attribution requirements.
See LICENSE for details.

---

## 📬 Final Note

This project is an experiment in **responsible publishing**, not speed.

If you are looking for:

* shortcuts → this is not for you
* automation without accountability → this is not for you

If you care about:

* authorship
* responsibility
* reproducibility

Welcome.

