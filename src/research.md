# The Complete Research Handbook
### For CS Students: Academic Research + Startup Product Research
> **From zero to publishing papers and building products people pay for**
> Everything. A to Z. No fluff.

---

## TABLE OF CONTENTS

1. [The Mental Foundation](#1-the-mental-foundation)
2. [Types of Research](#2-types-of-research)
3. [Academic Research — Full Process](#3-academic-research--full-process)
   - 3.1 Finding Your Research Question
   - 3.2 Literature Review
   - 3.3 Where to Find Papers
   - 3.4 Reading Papers Efficiently
   - 3.5 Organizing Your Research
   - 3.6 Note-Taking Systems
   - 3.7 Forming a Hypothesis
   - 3.8 Designing Experiments
   - 3.9 Running Experiments
   - 3.10 Analyzing Results
   - 3.11 Writing the Paper
   - 3.12 Peer Review + Submission
4. [Startup/Product Research — Full Process](#4-startupproduct-research--full-process)
   - 4.1 Problem Discovery
   - 4.2 Market Research
   - 4.3 Customer Discovery
   - 4.4 Competitive Analysis
   - 4.5 Validation Before Building
   - 4.6 Continuous Product Research
   - 4.7 Metrics and Analytics
5. [Documentation Systems](#5-documentation-systems)
   - 5.1 Academic Documentation
   - 5.2 Startup Documentation
   - 5.3 Templates
6. [Tools Master List](#6-tools-master-list)
7. [From Research to Startup](#7-from-research-to-startup)
8. [Working With Advisors and Mentors](#8-working-with-advisors-and-mentors)
9. [Research Ethics](#9-research-ethics)
10. [The Weekly Rhythm](#10-the-weekly-rhythm)
11. [Common Mistakes and How to Avoid Them](#11-common-mistakes-and-how-to-avoid-them)
12. [Resources Library](#12-resources-library)
13. [The Master Mental Model](#13-the-master-mental-model)

---

---

# 1. THE MENTAL FOUNDATION

## What Research Actually Is

Most people are taught research as: **find papers → read papers → cite papers.**
That is library science. Not research.

**Real research is:**
> You have a question the world hasn't fully answered. You go find out. Then you tell the world what you found.

Think of the world as a giant codebase. Most of it is already written and documented — that is existing knowledge. But there are **bugs** (unsolved problems) and **missing features** (unexplored areas).

Research is finding those bugs and either:
- **Patching them** — solving an existing problem → academic research
- **Building a feature people will pay for** — solving a market problem → startup research

Both start the same way: **you notice something is broken or missing.**

## The Core Difference: Academic vs Startup Research

| Dimension | Academic Research | Startup Research |
|---|---|---|
| Output | Knowledge / Paper | Product / Revenue |
| Audience | Committee of experts | Market of customers |
| Success metric | Novel contribution | People pay for it |
| Timeline | Months to years | Weeks to months |
| Iteration speed | Slow | Fast |
| Failure handling | Negative result = publishable | Negative result = pivot |
| Primary question | "Is this true?" | "Will people pay for this?" |

**The thinking process is almost identical. Master one, you get the other free.**

## The Researcher Mindset

Before anything else, internalize these:

**1. Intellectual honesty above everything**
Your job is to find truth, not to confirm what you already believe. If your experiment disproves your hypothesis — that is a result. A real one. Publish it.

**2. Comfort with uncertainty**
You will spend most of your time not knowing. That is normal. That is the job. The discomfort of not knowing is the fuel that drives research.

**3. Skepticism of everything, including yourself**
Every paper has flaws. Every methodology has assumptions. Including yours. The best researchers are the harshest critics of their own work.

**4. First principles thinking**
When stuck, strip away everything and ask: what do I actually know for certain? What am I assuming? What would I have to prove for this to be true?

**5. The 10x question habit**
For every conclusion: "Under what conditions would this be false?" For every assumption: "What if the opposite were true?" This is the habit that separates good researchers from great ones.

---

---

# 2. TYPES OF RESEARCH

## The 3 Core Types

### Type 1 — Exploratory Research
**"I don't know what I don't know"**

Used when: entering a completely new field, starting a new project, trying to understand a domain

Goal: Build a map of the territory. Understand what exists, what the open questions are, who the key players are.

Outputs: Literature review, concept maps, research question candidates

### Type 2 — Validating Research
**"I think I know something. Let me verify."**

Used when: you have a hypothesis, you want to test an existing claim, you're checking your assumptions

Goal: Prove or disprove a specific, testable claim with data and evidence

Outputs: Experiment results, validated/invalidated hypothesis, paper

### Type 3 — Building Research
**"I know what needs to exist. Let me create it."**

Used when: problem is confirmed, solution direction is clear, time to construct and measure

Goal: Build the thing and measure whether it solves the problem

Outputs: System, prototype, product, technical contribution

**You always start with Type 1, regardless of how confident you feel.**

---

## Research Methodologies in CS

| Methodology | Description | When to Use |
|---|---|---|
| Empirical | Run experiments, collect data, measure | Comparing systems, benchmarking, ML experiments |
| Theoretical | Mathematical proofs, formal analysis | Algorithm complexity, security proofs |
| System Building | Design, implement, evaluate a new system | New tools, frameworks, architectures |
| Survey/Review | Comprehensive analysis of existing work | Literature reviews, meta-analyses |
| Case Study | Deep analysis of specific instances | Real-world system behavior, deployment studies |
| User Study | Observe/interview people using systems | HCI, usability, accessibility |
| Simulation | Model and simulate systems | Networks, distributed systems, scenarios |

Most CS research combines at least 2 of these.

---

---

# 3. ACADEMIC RESEARCH — FULL PROCESS

## 3.1 Finding Your Research Question

**This is where 90% of students fail. They pick a topic, not a question.**

| Wrong (topic) | Right (question) |
|---|---|
| "I want to research machine learning" | "Why do transformers underperform on time-series vs LSTMs, and can positional encoding be modified to fix this?" |
| "I want to study databases" | "What is the performance cost of ACID compliance in distributed transactions at scale, and can it be reduced without sacrificing consistency?" |
| "I want to work on security" | "Are current LLM-based code generation tools producing systematically vulnerable code in specific categories?" |

### The Anatomy of a Good Research Question

```
[Observed gap or problem] + [specific context] + [proposed direction]
```

A good research question must be:
- **Specific** — not vague, clearly bounded
- **Falsifiable** — you must be able to be wrong
- **Novel** — not already answered (do your literature review first)
- **Feasible** — answerable within your resources and time
- **Significant** — the answer must matter to someone

### Method 1 — The Survey Paper Method

Survey papers (also called review papers) summarize an entire subfield. They are treasure maps.

Steps:
1. Search "[your area] survey" or "[your area] review" on Google Scholar
2. Filter for recent papers (last 3-5 years)
3. Go directly to "Future Work," "Open Problems," or "Limitations" section
4. Those sections are researchers explicitly saying: "someone please solve this"
5. Pick one that genuinely interests you and that you have the skills to attempt

### Method 2 — The Contradiction Method

1. Find two papers in the same area that reach different conclusions
2. The gap between them IS a research question
3. "Paper A claims X works under conditions Y. Paper B says it doesn't. Under what specific conditions does each hold, and why?"

This is powerful because the disagreement already signals there is something real to discover.

### Method 3 — The Real World Backwards Method

1. Start with a real problem you or someone you know has experienced
2. Ask: "Why does this problem exist?"
3. Keep asking why (5 Whys technique) until you hit something no paper has answered
4. That unanswered "why" is your research question

This method produces the most impactful research because it is grounded in reality. It also happens to be the same starting point for a startup.

### Method 4 — The Replication + Extension Method (Best for Beginners)

1. Find a well-cited paper in your area
2. Replicate their experiment (this teaches you the methodology deeply)
3. Identify one assumption they made or one thing they didn't test
4. Your extension of that = your contribution

This is underrated. Many great papers are rigorous extensions of prior work.

---

## 3.2 Literature Review

### What a Literature Review Is Not

- It is not a list of paper summaries
- It is not a history lesson about the field
- It is not copy-pasting abstracts

### What a Literature Review Actually Is

A literature review is a **structured argument** that:
1. Shows you understand the existing landscape
2. Identifies the specific gap your work fills
3. Explains why existing approaches don't fully solve the problem

Think of it as a prosecution brief: you are building the case that your research needs to exist.

### The Literature Review Process

**Phase 1: Seed**
Start with 3-5 highly relevant papers you already know or find immediately.

**Phase 2: Expand**
For each seed paper:
- Note every paper it cites that seems relevant
- Search Google Scholar "Cited by" to find everything that cited it
- You now have 30-50 papers

**Phase 3: Filter**
Apply the 3-Pass reading method (see 3.4) to filter down to what actually matters.

**Phase 4: Cluster**
Group papers by subtopic, approach, or contribution type. This becomes your review structure.

**Phase 5: Synthesize**
Write the review not as "Paper A did X. Paper B did Y." but as "The dominant approach to this problem has been X [A, B, C], which works well for [conditions] but fails when [limitation]. An alternative direction is Y [D, E], which addresses [limitation] but introduces [new problem]."

**Phase 6: Identify Gap**
The gap — what none of these papers solve — is where your work lives. State it explicitly.

### Connected Papers

Go to connectedpapers.com, paste any paper's title. It generates a visual graph of related papers, showing you the neighborhood of literature around a topic. Use this for discovery — it surfaces papers you'd never find by keyword search alone.

---

## 3.3 Where to Find Papers

### Primary Academic Sources

```
Google Scholar          scholar.google.com
├── Start here always. Broadest coverage.
├── Use "Cited by" to trace forward in time
└── Use date filter to get recent work

Semantic Scholar        semanticscholar.org
├── AI-powered, shows citation graphs
├── Shows "highly influential citations"
└── Better for finding key papers in a cluster

ArXiv                   arxiv.org
├── Preprints — papers before peer review
├── CS/ML cutting edge is here first
├── Search by category: cs.LG, cs.AI, cs.DB, cs.CR, etc.
└── Papers appear here 6-12 months before conferences

ACM Digital Library     dl.acm.org
├── Core CS research
└── SIGMOD, STOC, CCS, CHI, SOSP, OSDI etc.

IEEE Xplore             ieeexplore.ieee.org
├── Engineering + CS
└── ICSE, INFOCOM, S&P, CVPR etc.

Papers With Code        paperswithcode.com
├── ML papers + working code implementations
├── Benchmarks and leaderboards
└── State of the art tracking per task

DBLP                    dblp.org
├── CS bibliography database
└── Great for finding all papers by a specific author

ResearchGate            researchgate.net
└── Researchers often post their own PDFs here
```

### Getting Paywalled Papers — Legally and Free

```
1. Unpaywall browser extension
   Install it. It auto-finds free legal versions of papers.
   Works 50-60% of the time.

2. ArXiv preprint version
   Search the paper title on arxiv.org — most CS papers have a preprint.

3. Author's personal/lab website
   Researchers post their own papers. Google "[author name] publications"

4. Email the author directly
   "Dear Prof. X, I'm a CS student studying [topic].
   Could you share a copy of your paper [title]?
   I don't have institutional access."
   Response rate: ~70%. They almost always say yes.
   Bonus: sometimes turns into a research relationship.

5. Google Scholar PDF links
   Click the [PDF] link on the right side of Google Scholar results.
   Many link to free versions.
```

### Key Conferences by CS Subfield

| Subfield | Top Conferences |
|---|---|
| Machine Learning | NeurIPS, ICML, ICLR |
| Computer Vision | CVPR, ICCV, ECCV |
| NLP | ACL, EMNLP, NAACL |
| Systems | OSDI, SOSP, ATC, EuroSys |
| Databases | SIGMOD, VLDB, ICDE |
| Security | S&P (Oakland), CCS, USENIX Security, NDSS |
| Networking | SIGCOMM, NSDI |
| HCI | CHI, UIST |
| Software Engineering | ICSE, FSE, ASE |
| Theory | STOC, FOCS, SODA |

**A paper at these venues = peer-reviewed, high bar, trustworthy.**

---

## 3.4 Reading Papers Efficiently

### The 3-Pass Method
*(Adapted from Prof. S. Keshav's canonical framework)*

**Pass 1 — Bird's Eye View (5–15 minutes)**

Read only:
- Title and abstract
- Introduction: first paragraph + last paragraph only
- All section headings
- Conclusion
- Skim all figures and tables (read their captions)

After Pass 1, answer:
1. What problem does this solve?
2. What is their core approach?
3. Did it work? (main result)
4. Is this relevant to my work?

**80% of papers end here.** That is correct and efficient.

**Pass 2 — Understanding (30 minutes – 1 hour)**

Read everything except proofs and deep math. Understand the core idea. Mark every reference you don't recognize — those are papers to possibly read next. Understand all figures.

After Pass 2, you should be able to explain the paper to someone else in 3 minutes.

**Pass 3 — Deep Reading (3–5 hours, critical papers only)**

Read everything. Understand every proof, every design decision, every experiment. Ask: could you reimplement this? Could you find a flaw? Could you extend this?

**This level is reserved for the 5 most important papers to your work.**

### What to Look For in Different Sections

| Section | Key Questions to Ask |
|---|---|
| Abstract | What claim are they making? Is it specific? |
| Introduction | What is the precise problem? What are they NOT solving? |
| Related Work | What is the gap they position against? |
| Methodology | What assumptions are they making? What could fail? |
| Experiments | Are baselines fair? Are datasets appropriate? |
| Results | Are differences statistically significant? |
| Conclusion | What do they claim vs what did they actually prove? |
| Limitations | Are they honest? What did they hide here? |

### Red Flags in Papers

- No statistical significance testing on results
- Comparison only against weak baselines
- Dataset that suspiciously fits their method
- "Future work" section that addresses obvious flaws
- Cherry-picked examples without aggregate metrics
- No ablation study (testing each component separately)
- Results that are "too clean"

---

## 3.5 Organizing Your Research

### Folder Structure (Use This Exactly)

```
/research-project-name/
│
├── /papers/
│   ├── /foundational/      → papers everyone cites, must-reads
│   ├── /related-work/      → papers in your topic area
│   ├── /methods/           → papers about techniques you use
│   └── /datasets/          → papers about datasets you use
│
├── /notes/
│   ├── /paper-summaries/   → one file per paper
│   ├── /ideas/             → your original thoughts
│   ├── /meeting-notes/     → advisor meetings
│   └── /weekly-logs/       → weekly research diary
│
├── /experiments/
│   ├── /exp-001/           → one folder per experiment
│   │   ├── config.yaml     → exact parameters used
│   │   ├── run.py          → code to reproduce
│   │   ├── results/        → raw outputs
│   │   └── README.md       → what this tested and what happened
│   └── /exp-002/
│
├── /writing/
│   ├── /drafts/            → version-controlled LaTeX
│   ├── /figures/           → all paper figures
│   └── /references.bib     → Zotero-managed bibliography
│
├── /data/
│   ├── /raw/               → original, never modified
│   ├── /processed/         → cleaned versions
│   └── data_sources.md     → where everything came from
│
├── /code/
│   ├── requirements.txt    → exact package versions
│   ├── README.md           → how to run everything
│   └── /src/
│
└── README.md               → project overview, status, how to navigate
```

**Everything in Git. From day 1. No exceptions.**

### Zotero Setup (Your Research Database)

Zotero is free and the best tool for managing papers.

Setup steps:
1. Install Zotero desktop + browser extension
2. Create collections by project and subtopic
3. When you find a paper online, click the browser extension — it imports automatically
4. Add tags consistently: `to-read`, `read-pass1`, `read-pass2`, `read-pass3`, `key-paper`
5. Write your notes in the Zotero note attached to each paper
6. Use Zotero's citation tool in Word or Overleaf — never manually format references

**The single biggest time-saving habit in academic research.**

---

## 3.6 Note-Taking Systems

### The Zettelkasten Method

Developed by sociologist Niklas Luhmann, who published 70 books and 400 articles using this method. The system works because it mirrors how ideas actually connect — not hierarchically, but as a network.

**Three types of notes:**

**1. Fleeting Notes**
Raw, immediate capture. Any format. No editing.
Write these during reading, conversations, showers.
Process them within 24 hours or they become clutter.

```
Example:
"Paper X claims attention is all you need for sequence modeling —
but what about explicit memory? Is positional encoding actually
enough for tasks that require remembering state 10,000 tokens ago?"
```

**2. Literature Notes**
Your summary of one source, in your own words. Never copy-paste.
Forcing yourself to restate in your own words tells you immediately if you understood it.

Template:
```
Source: [Author, Year, Title]
Main argument:
How they argue it:
Key evidence/data:
What I find interesting:
What I disagree with:
How it connects to my work:
```

**3. Permanent Notes**
Your original ideas, fully formed, connected to other notes.
These are the actual atoms of your research.

```
Example:
NOTE-042: Positional Encoding Fails for Long-Range Dependencies
The standard sinusoidal positional encoding in transformers (NOTE-031)
encodes absolute position, not relative importance. This explains the
degradation I observed in EXP-007 for sequences > 2048 tokens.
Potential fix: learnable relative positional bias (see NOTE-038 on ALiBi).
This might resolve the failure mode in [my project name].
→ Links: NOTE-031, NOTE-038, EXP-007
```

**The rule: one idea per note. Link aggressively.**

### Obsidian for Zettelkasten

Obsidian is local-first markdown notes with bidirectional linking. It is the best tool for Zettelkasten.

Key features to use:
- `[[note name]]` syntax creates links between notes
- Graph view shows the visual network of your ideas
- Dataview plugin lets you query your notes like a database
- Daily notes for fleeting notes
- Canvas for visual thinking and mapping

---

## 3.7 Forming a Hypothesis

A hypothesis is not a guess. It is a **precise, testable prediction** derived from your understanding of the existing literature.

### Anatomy of a Good Hypothesis

```
"If [specific action/change], then [specific measurable outcome],
because [mechanistic reason based on prior knowledge]."
```

Example:
> "If we replace absolute positional encoding with ALiBi (Attention with Linear Biases) in standard transformer language models, then perplexity on sequences longer than 2048 tokens will decrease by at least 15%, because ALiBi encodes relative distance rather than absolute position, which is more informative for long-range dependencies."

Notice:
- Specific action: replace absolute with ALiBi
- Measurable outcome: perplexity, by at least 15%
- Mechanistic reason: relative vs absolute position encoding

### Null Hypothesis

Always state the null hypothesis too:

> "ALiBi positional encoding provides no statistically significant improvement over standard positional encoding for sequences longer than 2048 tokens."

Your experiment is designed to reject (or fail to reject) the null hypothesis. This framing keeps you honest.

### Assumption Mapping

Before running any experiment, list every assumption your hypothesis rests on:

```
ASSUMPTION 1: The model architecture is otherwise identical
ASSUMPTION 2: The dataset contains sufficient long sequences to measure this
ASSUMPTION 3: Perplexity is the right metric for this comparison
ASSUMPTION 4: The difference in the encoding is the actual causal factor
```

For each assumption, ask: what if this is wrong? How does that affect my conclusion?

---

## 3.8 Designing Experiments

The experiment design is where most CS papers live or die. A brilliant idea with a poor experiment produces an unreliable result.

### The Components of a Well-Designed Experiment

**1. Baseline**
What are you comparing against? The baseline must be:
- Fair — same resources, same data, same conditions
- Strong — use the best existing method, not a weak one
- Relevant — actually what practitioners would use

*The most common criticism in peer review: "The baseline is too weak."*

**2. Dataset**
- Is it the right dataset for your claim?
- Is it publicly available? (reproducibility)
- Are there known biases in it that could skew results?
- Do you need train/validation/test splits? Are they contamination-free?

**3. Metrics**
Choose metrics that actually measure what you claim to improve.

| Claim | Wrong Metric | Right Metric |
|---|---|---|
| "Faster" | Wall clock time on your laptop | Throughput on standardized hardware, multiple runs |
| "More accurate" | Accuracy on balanced dataset | F1 score if classes are imbalanced |
| "More efficient" | Lines of code | FLOPs, memory usage, inference latency |
| "Better user experience" | Your gut feeling | User study with proper statistical design |

**4. Controls**
Hold everything constant except the variable you're testing. This sounds obvious. It is constantly violated.

**5. Ablation Studies**
Test each component of your system independently. If you added 3 things and got improvement, which of the 3 actually did it?

Remove each component one at a time and measure. This is what separates "it works" from "we understand why it works."

**6. Statistical Significance**
Never report a single run. Run multiple times. Report mean ± standard deviation. Use appropriate statistical tests (t-test, Wilcoxon, etc.). Results that don't survive statistical testing are not results.

### Experiment Design Template

```
EXPERIMENT ID: EXP-[number]
DATE:
HYPOTHESIS BEING TESTED: [which hypothesis, state it]
WHAT I CHANGED: [the independent variable]
WHAT I MEASURED: [the dependent variable(s)]
WHAT I HELD CONSTANT: [controls]
DATASET: [name, version, split sizes]
BASELINE: [what I'm comparing against]
METRICS: [exactly what numbers I will collect]
NUMBER OF RUNS: [minimum 3, ideally 5+]
EXPECTED RESULT: [what I predict before running]
```

---

## 3.9 Running Experiments

### Reproducibility — Non-Negotiable

Every experiment must be reproducible. This means:

```python
# Set all random seeds at the top of every experiment
import random, numpy as np, torch
SEED = 42
random.seed(SEED)
np.random.seed(SEED)
torch.manual_seed(SEED)
```

Log every hyperparameter. Use config files (YAML or JSON), not hardcoded values. The experiment log should contain everything needed to reproduce the result from scratch.

### Experiment Tracking Tools

**Weights & Biases (wandb)** — best for ML experiments
- Automatic logging of metrics, hyperparameters, system stats
- Visual dashboards
- Compare runs side by side
- Free for academics

**MLflow** — open source alternative
- Local or cloud
- Experiment tracking + model registry

**Sacred + Omniboard** — lightweight alternative

**Minimum viable tracking (no tools):**
Every experiment gets a folder with:
- `config.yaml` — all parameters
- `run.sh` — exact command to reproduce
- `results/` — all outputs
- `notes.md` — what you observed

### During the Experiment — What to Log

```
- All hyperparameters (learning rate, batch size, epochs, etc.)
- Environment (Python version, package versions, hardware)
- Random seeds
- Training curves (loss, metrics at each epoch)
- Final metrics (mean + std across runs)
- Wall clock time
- Memory usage
- Any anomalies or unexpected behavior
```

---

## 3.10 Analyzing Results

Getting results is not the end. Understanding them is.

### The Three Questions for Every Result

**1. Does it match my hypothesis?**
If yes: great, but ask "why does it work?" — don't just accept it
If no: even better — ask "why not?" This is where discoveries live

**2. Are there patterns I didn't expect?**
Look at failure cases, outliers, edge cases. These are often more interesting than the main result.

**3. What alternative explanations exist?**
Could something other than my proposed mechanism explain this result? This is the hardest question. It's also what reviewers will ask. Answer it before they do.

### Error Analysis

For any classification/prediction task: don't just look at aggregate accuracy. Look at where your system fails.

- What types of examples does it get wrong?
- Is there a systematic pattern to the failures?
- Does it fail on certain conditions, domains, or data distributions?

Error analysis often points directly to your next hypothesis.

### Ablation Analysis Checklist

```
□ Tested with each component removed individually
□ Tested with combinations of components removed
□ Identified which component contributes most to improvement
□ Identified which component is necessary vs nice-to-have
□ Tested on both easy and hard subsets of the data
□ Tested across at least 2 different datasets if possible
```

---

## 3.11 Writing the Paper

### The Structure of a CS Research Paper

```
TITLE
└── Should contain: the problem + the approach or result
    Bad:  "A New Method for Text Classification"
    Good: "Sparse Attention for Efficient Long-Document Text Classification"

ABSTRACT (150-250 words)
└── Write this LAST
    Paragraph 1: Problem and why it matters
    Paragraph 2: What you did
    Paragraph 3: Key result (include the number)
    No citations. No jargon without definition.

INTRODUCTION (1-2 pages)
└── Para 1: The big picture problem
    Para 2-3: Current approaches and their limitations
    Para 4: What you do differently (your approach, high level)
    Para 5: Key results (spoil them — this is not a mystery novel)
    Final para: "Our contributions are: (1)... (2)... (3)..."

RELATED WORK (0.5-1 page)
└── Group related papers by approach, not chronologically
    Don't trash other work. Use: "orthogonal to," "complementary to"
    Make clear how yours differs from each group

METHODOLOGY / APPROACH (2-4 pages)
└── The most important section technically
    Someone else must be able to reproduce your work from this alone
    Include: problem formulation, architecture/algorithm, design decisions
    Use diagrams generously — a figure is worth 200 words

EXPERIMENTS (2-3 pages)
└── Setup: datasets, baselines, metrics, implementation details
    Main results: your primary comparison table/figure
    Ablation studies: what each component contributes
    Analysis: qualitative examples, error analysis, interesting cases

DISCUSSION (0.5-1 page)
└── Why do results look the way they do?
    What surprised you?
    What does this mean for the broader field?
    Honest limitations

CONCLUSION (0.5 page)
└── What did you find? (restate main result)
    What are the limitations?
    What is the most important future work?

REFERENCES
└── Use Zotero. Never manually format.
    Follow the venue's citation style exactly.
```

### Writing Process — The Actual Steps

**Step 1: Write the methodology first**
You know this best. Get it on paper (or LaTeX). It unlocks the rest.

**Step 2: Write the experiments section**
You have the results. Describe the setup, present the numbers, explain what they show.

**Step 3: Write the introduction**
Now that you know what you did and what you found, you can properly set it up.

**Step 4: Write related work**
You've done the literature review. Structure it as an argument for why your work was needed.

**Step 5: Write the discussion and conclusion**
Reflect on what it all means.

**Step 6: Write the abstract**
The entire paper in 200 words. Write this last.

**Step 7: Write the title**
Sounds trivial. Not trivial. The title determines who reads your paper.

### LaTeX — Learn It

Every serious CS paper is written in LaTeX. The learning curve is 1 week. It pays back in every paper for the rest of your career.

```latex
% Basic paper structure
\documentclass[10pt, conference]{IEEEtran}
\usepackage{amsmath, graphicx, booktabs, hyperref}

\title{Your Paper Title}
\author{Your Name}

\begin{document}
\maketitle

\begin{abstract}
Your abstract here.
\end{abstract}

\section{Introduction}
\section{Related Work}
\section{Methodology}
\section{Experiments}
\section{Conclusion}

\bibliography{references}
\bibliographystyle{IEEEtran}
\end{document}
```

Use **Overleaf** — online LaTeX editor with real-time collaboration. Free for individuals.

### Writing Principles

**1. One paragraph = one idea**
State the idea in sentence 1. Support it. No exceptions.

**2. Active voice**
"We propose a method that..." not "A method is proposed that..."

**3. Precision over elegance**
"Our method reduces latency by 23% on the X benchmark" not "Our method significantly speeds things up"

**4. Every claim needs evidence**
"X is slow [citation]" or "X is slow (Table 2)" — if you can't back it, don't claim it

**5. Write drunk, edit sober**
First draft = get ideas out, don't judge. Second draft = structure and clarity. Third draft = precision and polish. Never try to do all three at once.

---

## 3.12 Peer Review + Submission

### Choosing a Venue

**Tier 1 venues:** NeurIPS, ICML, ICLR, CVPR, ACL, SIGMOD, SOSP, S&P (security), CHI
**Tier 2 venues:** Solid conferences in each area — AAAI, IJCAI, CIKM, NDSS, USENIX, etc.
**Journals:** TPAMI, VLDB Journal, JACM, TDSC — slower, more thorough review
**Workshops:** Good for early work, getting feedback, networking

For your first paper: aim for the best workshop or solid Tier 2 conference. Get the experience. Then aim higher.

### Submission Checklist

```
□ Paper fits within page limit
□ All figures are readable at print size
□ All claims are backed by evidence or citation
□ Ablation studies are included
□ Baselines are fair and strong
□ Statistical significance is reported
□ Code will be released (say this in the paper)
□ Anonymous version for double-blind review (remove author names, institution)
□ Supplementary material prepared if needed
□ Camera-ready deadline noted for when accepted
```

### Reading Reviews

When you get reviews back:
1. Wait 24 hours before responding. Never respond emotionally.
2. Read all reviews together — look for patterns across reviewers
3. List every concern: (a) they're right and I need to fix it, (b) they misunderstood and I need to clarify, (c) they're wrong and I need to argue why

**Reviewers are almost always right about what confused them, even if wrong about why.**

### The Rebuttal

Address every concern. Be concise. Be factual. New experiments > argument.

"We thank Reviewer 2 for this concern. We ran additional experiments on Dataset X with the configuration they suggested (Appendix B). The results show Y, which is consistent with our main claims."

---

---

# 4. STARTUP/PRODUCT RESEARCH — FULL PROCESS

## The Mindset Shift

> In academic research, you convince a committee of experts.
> In startup research, you convince a market of customers.

The process is the same. The jury changes.

**The #1 rule of startup research:**

> Talk to people before you write code. Every time. No exceptions.

Most failed startups built something nobody wanted. Not because they were bad engineers. Because they never verified the problem was real and widespread before building the solution.

---

## 4.1 Problem Discovery

### The Three Sources of Real Problems

**Source 1 — Your Own Life (Best Source)**
Problems you personally hit repeatedly. You are your own first customer — you understand the pain intimately, you know the context, you know what good looks like.

Exercises:
- List every task you do repeatedly that feels stupid or inefficient
- List every tool you use that constantly frustrates you
- List every time in the last month you thought "why doesn't this exist?"

**Source 2 — Jobs, Internships, Observations**
Inefficiencies you saw working somewhere. Industries still using Excel for everything. Processes that take 4 people that should take a script. Manual work that is clearly automatable.

The pattern to look for: **high-value, recurring, manual process.**

**Source 3 — Research Paper Gaps**
You are a CS student. This is your unfair advantage over most founders.

Academic research is 5-10 years ahead of commercial products. There are solutions in papers that nobody has productized. Find those.

Examples:
- Transformers existed in research for years before OpenAI commercialized them
- Semantic search existed in research long before it appeared in consumer products
- Privacy-preserving computation is researched heavily; commercial products are just emerging

### The 5 Whys for Problem Discovery

Ask "why?" five times to reach the root cause:

```
SURFACE: "Our customer support takes 3 days to respond"
Why? → Too many tickets
Why? → Users can't find answers in documentation
Why? → Documentation is scattered and unstructured
Why? → No single source of truth, every team writes their own
Why? → No tooling that creates documentation from actual product behavior

ROOT PROBLEM: There's no automated way to generate accurate, current
documentation from product behavior → that's a startup idea
```

---

## 4.2 Market Research

### TAM / SAM / SOM Framework

```
TAM (Total Addressable Market)
└── Everyone who could ever buy this
    "All companies that have customer support"
    Don't need to pursue this. Just need it to be large enough.

SAM (Serviceable Addressable Market)
└── Who you can realistically reach with your model
    "B2B SaaS companies with 10-200 employees in English-speaking markets"

SOM (Serviceable Obtainable Market)
└── Who you'll actually get in year 1-2
    "50 B2B SaaS startups you can reach through your network and cold outreach"
```

You do not need a billion-dollar TAM to build a profitable startup. You need a SOM that pays.

**The math that matters:**
```
SOM x Average Revenue Per Customer = Your Revenue Target

50 customers x $500/month = $25,000 MRR = $300,000 ARR
This is a real, fundable, profitable business.
```

### Market Research Process

**Step 1: Establish that people pay for solutions to this problem today**
If there is zero existing spending on this problem — be very suspicious. Either the pain isn't bad enough, or you haven't found the right buyer.

**Step 2: Find the existing solutions and their flaws**
The flaws of existing solutions are your opportunity. Not their existence — their flaws.

**Step 3: Estimate market size**
Bottom-up: [number of potential customers] × [price they'd pay] = market size
This is more credible than top-down ("the market is $10B")

**Step 4: Identify growth direction**
Is this market growing, stable, or shrinking? You want growing — you ride the wave instead of fighting for share.

### Market Research Tools

```
FINDING WHAT PEOPLE COMPLAIN ABOUT
Reddit (r/[industry], r/entrepreneur, r/smallbusiness)
  → search "[product name] sucks" or "[category] alternative"
Twitter/X
  → "[industry] + (hate OR frustrating OR finally)" searches
G2 / Capterra / Trustpilot
  → competitor reviews — read the 2-3 star reviews
    these are people who paid, tried, and were disappointed
    that gap = your product
Product Hunt comments
  → what do people ask for that doesn't exist?
Hacker News
  → search news.ycombinator.com for "pain" or "Ask HN: what SaaS"

MARKET SIZING + COMPETITIVE LANDSCAPE
Crunchbase         → funding in this space (validates market exists)
SimilarWeb         → competitor traffic estimates
LinkedIn           → how many people have job title X (market size proxy)
Google Trends      → is interest growing or dying?
SEMrush / Ahrefs   → keyword search volume (how many search for the problem)
Statista           → industry reports (some free)

GEOGRAPHIC + DEMOGRAPHIC SIGNALS
SparkToro          → where does your audience spend time online
Facebook Audience Insights → demographic data
LinkedIn Sales Navigator → precise B2B targeting data
```

---

## 4.3 Customer Discovery

**This is the most important step. Most founders skip it or do it badly.**

### The Mom Test

From Rob Fitzpatrick's book *The Mom Test* — the most important startup book you will read.

The core insight: if you ask "would you use this?" everyone says yes (including your mom, who loves you). You need questions that people can't lie to you about even if they want to.

**Questions that get honest answers:**

```
"Tell me about the last time you experienced [problem]."
→ Real, specific, past behavior. Not hypothetical.

"Walk me through how you handle [problem] today."
→ Reveals actual workflow, pain points, existing solutions

"How much time/money does this cost you right now?"
→ Quantifies pain. Low numbers = low priority = bad sign.

"What have you tried? Why didn't it work?"
→ Reveals solution landscape and failure modes

"Who else has this problem in your organization?"
→ Reveals buying process and scope

"What would you do if [tool they use] disappeared tomorrow?"
→ Reveals true dependency and switching costs
```

**Questions that get lies (avoid these):**

```
"Would you use an app that does X?" → "Yes" (to be polite)
"Do you think this is a good idea?" → "Yes" (to encourage you)
"Would you pay $X/month for this?" → "Probably" (hypothetical)
"How much would you pay for this?" → Random number with no commitment
```

### How to Get Customer Interviews

**Cold LinkedIn messages:**
```
"Hi [Name], I'm a CS student researching [problem area].
I'm not selling anything — just trying to understand how
[job title] currently handles [problem].
Would you have 15 minutes for a quick call?
I'll share what I learn with you."

Response rate: 15-30% when this is genuine.
```

**Warm network:**
- Professors who know practitioners
- Family friends in relevant industries
- Previous internship contacts
- Alumni from your university

**Online communities:**
- Find the subreddit or Slack community for your target user
- Participate genuinely for 2 weeks before asking
- Post: "I'm researching [problem]. Would anyone share their experience with [problem]? DM me."

**Minimum viable discovery: 20 conversations before writing any code.**

### The Interview Structure

```
OPENING (2 min)
"Thanks for your time. I'm trying to understand how [role] 
handles [problem area]. There's no product to sell — just learning.
Mind if I take notes?"

CONTEXT (5 min)
"Tell me about your role and your team."
"What tools do you use for [area]?"

CORE QUESTIONS (20 min)
"Tell me about the last time [problem] happened."
"Walk me through exactly what you do."
"What's the most painful part?"
"What have you tried? What failed?"
"What does it cost you — time, money, frustration?"

CLOSING (3 min)
"Is there anything I didn't ask that you think I should know?"
"Who else should I talk to about this?"
```

### Reading the Signals

| Signal | What It Means |
|---|---|
| "I do this manually every Monday" | Real, recurring pain |
| "We pay $X/month for [bad solution]" | Proven willingness to pay |
| "I've tried 3 tools, none work" | Active problem, no good solution |
| "When can I use it?" | Strong pull signal |
| "I've actually built a workaround" | Very strong — they care enough to build |
| "That sounds interesting" | Polite disinterest |
| "I guess I'd use it" | Not a real problem for them |
| "Depends on the price" | Low pain, price sensitive |

---

## 4.4 Competitive Analysis

Never say "we have no competition." Every problem has a current solution — manual process, spreadsheet, internal tool, or adjacent product.

### The Competitive Analysis Framework

For every competitor or substitute:

```
PRODUCT ANALYSIS
Name + URL:
What does it do? (1 sentence)
Who is the target customer?
What problem does it solve best?
What does it NOT do well?
What do users complain about most? (read the reviews)

BUSINESS ANALYSIS
Pricing:
Revenue estimates (SimilarWeb + funding ÷ growth):
Funding history (Crunchbase):
Team size (LinkedIn):
How long have they existed?

TECHNICAL ANALYSIS
What stack do they use? (BuiltWith, Wappalyzer)
Any obvious technical limitations?
Is their core IP easy to replicate?

YOUR DIFFERENTIATION
Why will customers switch from or choose you over them?
What is your specific unfair advantage?
```

### The 2×2 Positioning Map

Draw two axes that matter in your market. Examples:
- Price vs Ease of Use
- Power/Features vs Speed to Value
- Enterprise vs SMB, Automated vs Manual

Place every competitor. Find the empty quadrant. That is your position.

### The G2/Capterra Review Mining Method

This is the most underused startup research technique:

1. Find your top 3 competitors on G2 or Capterra
2. Filter reviews: 2 and 3 stars only (these are paying customers who are disappointed)
3. Copy every complaint into a spreadsheet
4. Tag by theme: "too expensive," "missing feature X," "bad UX," "poor support"
5. Find the themes that repeat most often

**The most common complaints = your product roadmap.**

---

## 4.5 Validation Before Building

### The Validation Ladder (cheapest to most expensive)

```
LEVEL 1: Smoke Test (2-3 days)
Build a landing page. Describe the product. Add signup/waitlist.
Measure: what % of visitors sign up?
Benchmark: 5%+ is a good signal

LEVEL 2: Concierge MVP (1-2 weeks)
Manually do what the product would do for 5-10 customers.
No code — just you doing the work with spreadsheets, email, manual process.
Measure: will they pay for this manual version?
This tells you if the value is real before any engineering.

LEVEL 3: Wizard of Oz (2-4 weeks)
Front-end looks like a real product. Back-end is you doing things manually.
Customer sees an interface. You are behind the curtain.
Measure: engagement, return rate, qualitative feedback.

LEVEL 4: Pre-sell (any time)
Ask for money before it's built. "Pay $X now, get access in 8 weeks."
If they won't give money, they don't really want it.
Measure: actual payment = strongest possible signal.

LEVEL 5: MVP (4-8 weeks)
Simplest possible working version. One use case. No extras.
Measure: activation, retention, NPS, payment.
```

**The cardinal rule: move up the ladder only when the current level gives you signal.**

### Landing Page That Converts

A good validation landing page has:
```
HEADLINE        → What you do + who it's for (10 words max)
SUBHEADLINE     → Specific benefit + the pain it solves
SOCIAL PROOF    → Logos, quotes, numbers (even if early)
HOW IT WORKS    → 3 simple steps
CTA BUTTON      → "Join Waitlist" or "Get Early Access" or "Buy Now"
SECONDARY CTA   → "See a demo" or "Watch video"
```

Tools: Carrd (simplest), Framer (most beautiful), Webflow (most flexible)

### Pricing Experiments

Run pricing tests early. Most founders underprice.

The Van Westendorp pricing model:
Ask these 4 questions in your customer interviews:
```
1. At what price would this be so cheap you'd question the quality?
2. At what price would this be a bargain — great value?
3. At what price would this start to get expensive but you'd still buy?
4. At what price would this be too expensive?
```

The "acceptable range" is between Q2 and Q3. The sweet spot is Q3. Most founders price at Q1.

---

## 4.6 Continuous Product Research

After you've built and launched, research does not stop. It transforms.

### The Continuous Discovery Framework
*(Teresa Torres — read her book)*

```
WEEKLY RHYTHM
├── 1 customer interview per week (minimum, forever)
├── Review analytics dashboard
├── Check support tickets for patterns
└── Team sync: what did we learn this week?

MONTHLY RHYTHM
├── Opportunity mapping: what new needs are emerging?
├── Assumption audit: which of our beliefs might be wrong?
├── Competitive check: what changed in the landscape?
└── Metrics review: are we moving the right numbers?
```

### The Opportunity Solution Tree

```
DESIRED OUTCOME (what metric are we trying to move?)
        ↓
OPPORTUNITIES (what user needs, pain points, desires exist?)
        ↓
SOLUTIONS (what could we build to address each opportunity?)
        ↓
EXPERIMENTS (what's the smallest test of each solution?)
```

This tree prevents the most common product mistake: jumping from "user has problem" directly to "let's build a feature" without asking "is this the right solution?"

---

## 4.7 Metrics and Analytics

### The AARRR Framework (Pirate Metrics)

| Stage | Metric | Question |
|---|---|---|
| **Acquisition** | Visitors, signups | Where do users come from? |
| **Activation** | % who complete onboarding, time-to-value | Do they get value in session 1? |
| **Retention** | DAU/WAU/MAU, churn rate | Do they come back? |
| **Revenue** | MRR, ARPU, LTV | Are they paying? Upgrading? |
| **Referral** | NPS, referral rate, viral coefficient | Do they tell others? |

**Track all five from day 1. Most startups only track acquisition.**

### The North Star Metric

One metric that best captures the value you deliver to customers. All other metrics serve this one.

Examples:
```
Airbnb         → Nights booked
Spotify        → Time spent listening
Slack          → Messages sent
WhatsApp       → Messages sent
Your startup   → ???
```

Ask: "If this number goes up, are our customers definitely getting more value?" If yes — that's your North Star.

### Instrumentation — What to Track From Day 1

```python
# Every user action that matters should fire an event
analytics.track('user_id', 'event_name', {
    'property_1': value,
    'property_2': value,
    'timestamp': datetime.now()
})

# Key events to track:
# - User signed up
# - User completed onboarding
# - User performed core action (whatever your product does)
# - User hit paywall
# - User upgraded/paid
# - User invited someone
# - User churned (deleted account / cancelled)
```

Tools: PostHog (open source, self-host), Mixpanel, Amplitude

---

---

# 5. DOCUMENTATION SYSTEMS

## 5.1 Academic Documentation

### The Research Journal

Keep this daily. 10 minutes maximum. The habit beats the duration.

```markdown
## Research Log — [DATE]

### What I did today
[1-3 sentences]

### Key insight or finding
[The most important thing I learned]

### Questions this raised
[What I'm now wondering]

### Experiment or action for tomorrow
[One concrete next step]

### Mood/Energy
[1-5 — tracking this shows patterns in your best work days]
```

### Paper Summary Card Template

```markdown
## Paper Summary

**Title:** [Full title]
**Authors:** [Author list]
**Year:** [Year]
**Venue:** [Conference/Journal]
**Link:** [URL or DOI]
**Zotero Key:** [your key]

---

### The Problem
[What problem does this paper solve? 2-3 sentences]

### Why Existing Solutions Were Insufficient
[What did prior work fail to do?]

### Their Approach
[The core method, in your words. Not a copy-paste of the abstract.]

### Key Insight
[The one clever idea that makes this work]

### Main Results
[Key numbers: accuracy, speedup, improvement over baseline]

### Limitations
[What doesn't this handle? What did they admit was missing?]

### My Critical Assessment
[Do I believe the results? Are the experiments convincing? What would I challenge?]

### Relevance to My Work
[How does this affect my research? Does it support or contradict my hypothesis?]

### Follow-up Papers to Read
[Papers from references I should track down]
```

### Experiment Log Template

```markdown
## Experiment Log

**Experiment ID:** EXP-[number]
**Date:** [date]
**Status:** [planned / running / completed / abandoned]

---

### Hypothesis
[If I do X, then Y will happen because Z]

### Setup
- Dataset: [name, version, statistics]
- Model/System: [exact configuration]
- Baseline: [what I'm comparing against]
- Metrics: [what I'm measuring]
- Hardware: [GPU/CPU, RAM, etc.]
- Random Seed: [number]
- Key Hyperparameters: [list]

### Command to Reproduce
```bash
python run_experiment.py --config configs/exp-[number].yaml
```

### Results
| Metric | Baseline | Our Method | Delta |
|---|---|---|---|
| [Metric 1] | [value] | [value] | [%] |

### Analysis
[Why did the results look this way? What patterns did I notice?]

### Conclusion
[Does this support or reject the hypothesis?]

### Next Experiment
[What does this result suggest I should test next?]
```

### Meeting Notes Template (Advisor Meetings)

```markdown
## Advisor Meeting — [DATE]

**Attendees:** [names]
**Duration:** [time]

---

### What I Presented
[What I showed the advisor]

### Key Feedback
[What they said — be specific, use quotes where possible]

### Things to Do Before Next Meeting
- [ ] [Action 1]
- [ ] [Action 2]
- [ ] [Action 3]

### Questions I Forgot to Ask (for next time)
[...]

### My Reflection
[What was most useful? What surprised me?]
```

---

## 5.2 Startup Documentation

### The Opportunity Document (Living Document)

Update this every week. This is your compass.

```markdown
# Opportunity Document — [Product Name]
**Last Updated:** [date]
**Version:** [number]

---

## Problem Statement
**The problem:**
[1-2 sentences, specific, no jargon]

**Who has it:**
[Specific person: job title, company type, size, context]

**How often it occurs:**
[Daily / weekly / monthly — frequency matters]

**How bad it is:**
[Time cost, money cost, emotional cost]

---

## Evidence We've Collected
**Interviews conducted:** [number]

**Verbatim quotes from customers:**
> "[Exact quote from interview — use their words, not yours]" — [Role, Company Size]
> "[Another exact quote]" — [Role, Company Size]

**Data points:**
- [Market data point]
- [Behavioral observation]

---

## Current Solutions and Their Failures
| Solution | Who Uses It | What They Like | What They Hate |
|---|---|---|---|
| [Competitor A] | [customer type] | [strengths] | [weaknesses] |
| [Competitor B] | [customer type] | [strengths] | [weaknesses] |
| Manual process | [customer type] | [control] | [time, error] |

---

## Our Hypothesis
**What we will build:**
[1 sentence]

**Why it will be better:**
[Specific mechanism — not "easier to use" but "eliminates the X step that takes 2 hours"]

---

## Assumptions (Ranked by Risk)
| # | Assumption | Risk Level | How to Test |
|---|---|---|---|
| 1 | [Most uncertain belief] | High | [Experiment] |
| 2 | [Next uncertain belief] | Medium | [Experiment] |

---

## Experiments Done
| Date | Hypothesis Tested | Method | Result | Decision |
|---|---|---|---|---|
| [date] | [what we tested] | [how] | [what happened] | [what we did next] |

---

## Current Metrics
| Metric | Current | Target | Trend |
|---|---|---|---|
| Waitlist signups | | | |
| Interview requests | | | |
| Landing page CVR | | | |
```

### Customer Interview Log

```markdown
## Interview Log

**Interview #:** [number]
**Date:** [date]
**Duration:** [minutes]
**Interviewer:** [name]

**Participant:**
- Role: [job title]
- Company: [type and size, not name — keep anonymous]
- How we found them: [LinkedIn / referral / community]

---

### The Story They Told
[Narrative summary of what they shared — their situation, the problem, how they handle it]

### Verbatim Quotes (Most Important — Copy Exactly)
> "[Exact words]"
> "[Exact words]"

### Current Solution
[What do they use today to handle this problem?]

### Pain Level: [1-10]
**Why that score:**
[Their reasoning in their words]

### Willingness to Pay Signals
[What they said about money, budgets, what they currently spend]

### Surprises
[What did I not expect? What challenged my assumptions?]

### Follow-up Actions
- [ ] [Something I should research or test based on this]
- [ ] [Someone they suggested I talk to]
```

### Decision Log

```markdown
## Decision Log — [Product Name]

| # | Date | Decision | Options Considered | Why This Choice | Outcome |
|---|---|---|---|---|---|
| 001 | [date] | [what was decided] | [alternatives] | [reasoning] | [fill in later] |
```

---

## 5.3 Templates Quick Reference

### Weekly Summary (Both Academic and Startup)

```markdown
## Weekly Summary — Week of [DATE]

### Main question I tried to answer this week
[The central thing you were investigating]

### What I learned
[3-5 bullet points of actual new knowledge]

### What didn't work
[Be honest — failed experiments, dead ends, wrong assumptions]

### Biggest surprise
[The thing that most challenged your existing beliefs]

### What I'm still uncertain about
[Open questions going into next week]

### Next week's main question
[The one thing you will try to answer]

### Metric update (startup) / Progress update (academic)
[Numbers or milestone status]
```

---

---

# 6. TOOLS MASTER LIST

## Academic Research Stack

### Discovery
```
Google Scholar          scholar.google.com
Semantic Scholar        semanticscholar.org
ArXiv                   arxiv.org
Papers With Code        paperswithcode.com
Connected Papers        connectedpapers.com
DBLP                    dblp.org
ACM Digital Library     dl.acm.org
IEEE Xplore             ieeexplore.ieee.org
```

### AI-Assisted Research Discovery
```
Perplexity.ai           Research assistant that cites sources
Consensus.app           AI search across academic papers
Elicit.org              AI that extracts structured data from papers
ResearchRabbit          Visual paper discovery and tracking
Litmaps                 Citation mapping and tracking
```

### Paper Management
```
Zotero                  Free, open-source, best citation manager
                        Install desktop app + browser extension
                        Collections, tags, notes, PDF annotation
                        Auto-import from browser
                        Integrates with Word and Overleaf
```

### Reading and Annotation
```
Zotero PDF reader       Built into Zotero, highlights + notes sync
Highlights (Mac)        Excellent PDF reader with export to Markdown
Skim (Mac)              Lightweight PDF reader
Adobe Acrobat Reader    Annotation basics
```

### Note-Taking and Knowledge Management
```
Obsidian                Local markdown notes, bidirectional links
                        Zettelkasten method
                        Graph view, Dataview plugin
                        100% offline, your data stays yours

Notion                  More structured, better for teams
Roam Research           Similar to Obsidian, web-based
LogSeq                  Open-source Roam alternative
```

### Writing
```
Overleaf                Online LaTeX editor
                        Real-time collaboration
                        Free for individuals
                        Integrates with Zotero
                        All major conference templates available

VS Code + LaTeX Workshop  Local LaTeX writing
Google Docs             Early drafts, collaboration
Hemingway App           Clarity and readability check
Grammarly               Grammar and style
```

### Experiment Tracking
```
Weights & Biases        Best for ML — metrics, hyperparams, model artifacts
MLflow                  Open-source alternative
Sacred                  Lightweight Python experiment tracking
DVC                     Data version control — like Git for datasets
Jupyter Notebooks       Document-as-you-go research
```

### Diagrams and Figures
```
draw.io                 Free, browser-based, all diagram types
Excalidraw              Hand-drawn style, quick sketches
TikZ (LaTeX)            Publication-quality figures in papers
Matplotlib / Seaborn    Python data visualization
Plotly                  Interactive visualizations
Inkscape                Vector graphics editor (free Illustrator)
```

### Version Control
```
Git + GitHub            Everything — code AND LaTeX papers
GitHub Actions          Automate paper builds (compile LaTeX on push)
DVC                     Large files and datasets
```

### Collaboration and Communication
```
Overleaf                Co-author LaTeX papers in real-time
Slack / Discord         Lab communication
Zoom / Google Meet      Remote meetings
Calendly                Schedule advisor meetings without email ping-pong
```

---

## Startup Research Stack

### Problem Discovery
```
Reddit                  reddit.com/r/[your industry]
                        Search: "[competitor] sucks" or "[category] alternative"
Twitter/X               Complaint mining, trend spotting
Product Hunt            New products + comment sections
Hacker News             news.ycombinator.com — search hn.algolia.com
G2                      g2.com — B2B software reviews
Capterra                capterra.com — SMB software reviews
Trustpilot              Consumer product reviews
```

### Market Research
```
Crunchbase              crunchbase.com — funding, competitors, investors
SimilarWeb              similarweb.com — website traffic
Google Trends           trends.google.com — search interest over time
Google Keyword Planner  Search volume, competition
SEMrush / Ahrefs        Keyword research, competitor SEO
SparkToro               Where your audience lives online
Statista                Industry statistics (some free)
LinkedIn                Market sizing by job title / industry
```

### Customer Interviews
```
Calendly                Scheduling (free tier)
Otter.ai                AI transcription of calls
Fireflies.ai            Auto-transcribe and summarize meetings
Zoom / Google Meet      Video calls
Notion / Obsidian       Interview logging and synthesis
```

### Validation and Landing Pages
```
Carrd                   Simplest landing page (free)
Framer                  Beautiful landing pages, no code
Webflow                 Most flexible, no code
Typedream               Fast, clean landing pages
Stripe                  Pre-sell before you build — take real payments
Typeform                Surveys and waitlist forms
Tally.so                Free Typeform alternative
```

### Analytics
```
PostHog                 Open-source, self-host, full analytics + heatmaps
Mixpanel                Best-in-class product analytics
Amplitude               Enterprise-grade product analytics
Google Analytics        Free, for acquisition tracking
Hotjar                  Heatmaps, session recordings, surveys
FullStory               Session replay for debugging UX
```

### Competitive Intelligence
```
G2 / Capterra           Review mining for competitor weaknesses
SimilarWeb              Traffic and engagement comparison
BuiltWith               What tech stack competitors use
Wappalyzer              Browser extension — see tech stack of any site
Crunchbase              Funding history and team growth
LinkedIn                Team size, hiring signals (what they hire = roadmap)
```

### Startup Knowledge
```
Y Combinator Library    ycombinator.com/library — best startup resources
Paul Graham Essays      paulgraham.com
Lenny's Newsletter      lennynewsletter.com — product and growth
First Round Review      review.firstround.com
a16z blog               a16z.com/blog
Stratechery             stratechery.com — tech strategy
```

---

---

# 7. FROM RESEARCH TO STARTUP

## The Path

The biggest arbitrage opportunity available to a CS student:

```
ACADEMIC INSIGHT          →          COMMERCIAL PRODUCT
(5-10 years ahead)                   (funded, built, launched)
```

Most researchers don't build. Most founders don't have deep technical insight. You can have both.

### The Pipeline

```
Step 1: ACADEMIC PROBLEM
"Existing RAG systems hallucinate on long documents"

Step 2: RESEARCH SOLUTION
"Novel chunking + re-ranking reduces hallucination by 40%"

Step 3: MARKET QUESTION
"Who is losing money today because of AI hallucination?"

Step 4: CUSTOMER DISCOVERY
"Legal teams, medical documentation, financial compliance"

Step 5: PRODUCT HYPOTHESIS
"AI document analysis for legal teams, 40% more accurate than [competitor]"

Step 6: VALIDATION
Landing page + 10 interviews + 1 paying design partner

Step 7: BUILD MVP
Smallest version that demonstrates the 40% improvement for legal use case

Step 8: COMPANY
```

### Your Unfair Advantage as a CS Student

Most founders copy ideas from other companies. They compete on execution.

You can compete on **insight** — something you know deeply that others don't. That is a moat that cannot be copied fast.

Examples:
- Deep knowledge of a specific ML architecture
- Understanding of a specific systems problem (database internals, networking, compilers)
- Research background in a domain + ability to build

### The Research Moat

When your product is built on a genuine research insight:
1. It is hard to copy without understanding the underlying research
2. You understand it more deeply than any competitor who tries to copy
3. The insight usually generalizes — it can become a platform, not just a feature
4. It attracts other researchers as employees and collaborators
5. It attracts academic credibility which becomes marketing

---

---

# 8. WORKING WITH ADVISORS AND MENTORS

## The Advisor Relationship

Your research advisor is not your boss and not your peer. They are a senior collaborator who has navigated the system you are entering.

### What to Expect From a Good Advisor

- Regular meetings (weekly or biweekly)
- Feedback on written work within 2 weeks
- Introduction to relevant people in the field
- Honest assessment of your work's quality
- Help positioning your work for publication
- Career guidance

### What They Expect From You

- Consistent progress, even if slow
- Proactive communication — they hear about problems from you, not later
- Preparation for every meeting — arrive with concrete update and specific questions
- Ownership of your research — you drive it, not them
- Written documentation of your work — they cannot read your mind

### The Meeting Preparation Template

Before every advisor meeting:
```
1. Written update: what I did since last meeting (1 paragraph)
2. Results: any new data or findings (figures/tables)
3. Blockers: what is preventing progress
4. Decision needed: what do I need their input on specifically
5. Plan: what I intend to do before next meeting
```

Send this by email 24 hours before the meeting. It makes the meeting 3x more productive.

### When Things Go Wrong

If advisor relationship is not working:
- Communicate directly first — most issues come from misaligned expectations
- Document everything — emails, meeting notes, decisions
- Understand the formal process at your institution before escalating
- Talk to other students in the lab — you are probably not alone
- Changing advisors is possible and sometimes necessary — better early than late

## Finding Mentors (Outside Academy and Outside Your Company)

The best mentors are people 5-10 years ahead of where you want to be, who still remember what it was like to be where you are.

### Finding Them

```
LinkedIn        → comment thoughtfully on posts, then reach out
Twitter/X       → engage with content before DMing
Conferences     → show up, be curious, don't pitch — just have conversations
Alumni network  → your university's alumni want to help
Office hours    → founders at YC, Andreessen etc. run public office hours
Cold email      → it works more than you think, if it's genuine and specific
```

### The Cold Outreach That Works

```
Subject: Quick question from a CS student working on [topic]

Hi [Name],

I'm a CS student at [university] working on [specific problem].
I read your [paper / blog post / tweet] about [specific thing] 
and it directly answered a question I'd been stuck on for weeks.

I have one specific question: [the actual question, one sentence]

I know you're busy. A 10-word reply would genuinely help.

Thanks,
[Your name]
```

Short. Specific. One ask. Demonstrates you've done the work.

---

---

# 9. RESEARCH ETHICS

## Why This Matters More Than You Think

Unethical research doesn't just harm your career. It harms the field, harms people who build on your work, and harms the public who relies on published research to be true.

## Core Principles

### 1. Reproducibility
Every result must be reproducible by an independent researcher following your paper. This means:
- Publishing your code (GitHub with paper link)
- Sharing your data (or explaining why you can't)
- Reporting exact hyperparameters and random seeds
- Not hiding failed experiments that change the interpretation

### 2. Honest Reporting
Report your results honestly, including:
- Results that don't support your hypothesis (negative results)
- Conditions where your method fails
- Limitations of your approach
- Statistical uncertainty (confidence intervals, error bars)

**Selective reporting** — only sharing your best results while hiding others — is a form of scientific fraud.

### 3. Attribution and Citation
- Cite every source you build on
- If you use code from someone else, credit it
- Don't present prior ideas as your own
- If you work with others, authorship should reflect contribution

### 4. Data Ethics
- If you collect human data: IRB approval, informed consent, privacy
- Don't train models on data you don't have rights to use
- Be aware of biases in datasets and report them
- Consider the potential harms of your research output

### 5. AI-Assisted Writing
Using LLMs in research is still evolving in norms. Current principle:
- You are responsible for every word in your paper
- AI-generated text you didn't verify is a risk to your credibility
- Disclose AI tool use per your venue's policy (check before submitting)
- Using AI to improve clarity is generally fine; using it to generate results is not

### 6. Conflict of Interest
Disclose funding sources. Disclose industry relationships. If a funder has interest in your results, say so. Readers need this information to interpret your work.

---

---

# 10. THE WEEKLY RHYTHM

Sustainable research requires rhythm. Bursts don't produce good work consistently.

## Weekly Research Rhythm (Academic)

```
MONDAY
└── Weekly planning
    Review weekly summary from last week
    Set ONE main question to answer this week
    Set 3 concrete tasks (no more)
    Check deadlines: paper submissions, advisor meetings

TUESDAY - THURSDAY
└── Deep work blocks
    2-3 hour focused blocks, phone away, notifications off
    Alternate: one day experiments, one day writing/reading
    Log progress in research journal every evening (10 min)

FRIDAY
└── Review and documentation
    Update experiment logs
    Write weekly summary
    Respond to emails, admin tasks
    Brief slack reading

WEEKEND
└── Light only
    Read papers without note-taking pressure
    Watch talks (YouTube: conference recordings)
    Let the brain consolidate
    No guilt for not working
```

## Weekly Research Rhythm (Startup)

```
MONDAY
└── Metrics review + planning
    Review last week's numbers: did they move?
    Set one growth hypothesis to test this week
    Customer interview scheduled?

TUESDAY
└── Build or research day
    Deep work on whatever needs building or testing

WEDNESDAY
└── Customer day
    Interview or user test session
    Respond to user feedback and support tickets
    Review analytics

THURSDAY
└── Build day
    Implement learnings from Wednesday

FRIDAY
└── Ship + document
    Ship whatever is ready
    Document what was learned
    Update opportunity document
    Team sync on week learnings
```

## The Daily Deep Work Protocol

For maximum research productivity:
```
Block 1 (9am-12pm):    Deep work — hardest task first, no meetings
Block 2 (12-1pm):      Break, food, walk
Block 3 (1pm-3pm):     Reading and lighter work
Block 4 (3pm-5pm):     Correspondence, admin, planning
Block 5 (5pm-6pm):     Journal entry, tomorrow's plan
```

The 9-12 block is non-negotiable. Protect it. Every research breakthrough happens in long, uninterrupted sessions.

---

---

# 11. COMMON MISTAKES AND HOW TO AVOID THEM

## Academic Research Mistakes

### Mistake 1: Starting Without a Clear Question
**What happens:** You read for months, get lost, produce nothing
**Fix:** Write your research question on a card and tape it to your monitor. If you can't state it in one sentence, it isn't ready yet.

### Mistake 2: Reading Instead of Doing
**What happens:** Endless literature review, no experiments
**Fix:** After 2-3 weeks of reading, force yourself to run an experiment — even a bad one. Doing reveals what you need to read. Reading doesn't tell you what to do.

### Mistake 3: Not Version-Controlling Your Work
**What happens:** Overwrite working code, lose a LaTeX version that was better, can't reproduce an experiment from 2 months ago
**Fix:** Git from day 1. Commit every time something works.

### Mistake 4: Weak Baselines
**What happens:** Your method looks good but only because you compared it to something obviously worse
**Fix:** Before running experiments, ask: "what would a skeptical reviewer say about my baseline?" Then make it stronger before they do.

### Mistake 5: Not Writing Throughout
**What happens:** You have 6 months of work and no writing. Paper deadline approaches. Panic.
**Fix:** Write something every week. Even 2 paragraphs. The methodology section should be nearly complete before experiments are done. Writing forces clarity on your thinking.

### Mistake 6: Perfectionism
**What happens:** Paper is never good enough, never submitted, never gets feedback
**Fix:** A submitted imperfect paper that gets reviewed and rejected teaches you more than a perfect paper that never leaves your hard drive. Submit.

### Mistake 7: Working in Isolation
**What happens:** Wrong direction for 3 months, advisor meeting reveals it in week 12
**Fix:** Share work early and often. Partial results, rough drafts, half-baked ideas. Feedback when things are malleable is infinitely more valuable than feedback when they're done.

---

## Startup Research Mistakes

### Mistake 1: Building Before Validating
**What happens:** 6 months of engineering, 0 customers, pivot or die
**Fix:** 20 customer interviews before any code. Non-negotiable.

### Mistake 2: The Problem Is Real But Not Urgent
**What happens:** People say "yeah that's a problem" but don't pay
**Fix:** Test urgency: "If I could give this to you today, would you use it?" If they don't drop everything to say yes — it's not urgent enough.

### Mistake 3: Talking to Friendly People
**What happens:** Only interview people who know you and want to be supportive, get false positives
**Fix:** Find strangers in your target market. They have no reason to lie.

### Mistake 4: Building for Yourself When Your Market Is Someone Else
**What happens:** Great product for a CS student, no other CS students pay for B2B tools
**Fix:** Be your own customer only if you are truly representative of the market. Otherwise, your intuition is actively misleading.

### Mistake 5: Ignoring Churn
**What happens:** Good acquisition, 80% of users leave after week 1, focus only on getting more users
**Fix:** Retention is the #1 metric. Acquire 10 users, make them love it, then scale. Not the other way.

### Mistake 6: Pricing Too Low
**What happens:** Lots of users, no revenue, unsustainable
**Fix:** Charge more than you think you should. The discomfort you feel is not evidence the price is wrong.

### Mistake 7: Market Research Without Customer Discovery
**What happens:** Market "looks big" on paper, real customers have different problem than assumed
**Fix:** Data tells you what. Conversations tell you why. You need both.

---

---

# 12. RESOURCES LIBRARY

## Essential Books

### Academic Research
```
"How to Write and Publish a Scientific Paper" — Robert Day
└── The mechanics of academic writing. Read this first.

"The Craft of Research" — Booth, Colomb, Williams
└── How to think about and structure research arguments.

"Writing Science" — Joshua Schimel
└── Narrative structure in scientific writing. Underrated.

"A PhD Is Not Enough" — Peter Feibelman
└── Career strategy for researchers. Read before your PhD, not after.

"How to Read a Paper" — S. Keshav
└── The 3-pass method. Free PDF. 6 pages. Read it this week.
```

### Startup and Product Research
```
"The Mom Test" — Rob Fitzpatrick
└── How to get honest information from customers. 2-hour read.
   Most important book on customer discovery ever written.

"The Lean Startup" — Eric Ries
└── Build-measure-learn loop. The scientific method for startups.

"Continuous Discovery Habits" — Teresa Torres
└── How to do product research as an ongoing practice.

"Zero to One" — Peter Thiel
└── How to think about building something genuinely new.

"The Hard Thing About Hard Things" — Ben Horowitz
└── What building actually feels like (versus the theory).

"Obviously Awesome" — April Dunford
└── Product positioning. How to make what you built land correctly.
```

### Mental Models and Thinking
```
"Thinking, Fast and Slow" — Daniel Kahneman
└── How your brain actually works. Essential for critical thinking.

"The Art of Problem Solving" (series)
└── Mathematical thinking. Foundational for CS research.

"Poor Charlie's Almanack" — Charlie Munger
└── Mental models across disciplines. Expensive book, worth it.
```

## Essential Papers and Articles (Free)

```
"How to Read a Paper" — S. Keshav (2007)
→ scholar.google.com — 6 pages, mandatory

"You and Your Research" — Richard Hamming (1986)
→ YouTube talk or transcript — how great researchers think

"Reflections on Trusting Trust" — Ken Thompson (1984)
→ ACM — Turing Award lecture, systems security, thinking about foundations

"Attention Is All You Need" — Vaswani et al. (2017)
→ ArXiv:1706.03762 — the paper that changed everything in ML

"MapReduce" — Dean & Ghemawat (2004)
→ OSDI 2004 — how to think about large-scale systems

"Do Things That Don't Scale" — Paul Graham
→ paulgraham.com — the most important essay for early startup founders
```

## Courses (Free)

```
CS Research Methods
├── MIT OpenCourseWare — various CS courses
└── Stanford CS courses on YouTube

Machine Learning
├── fast.ai — practical ML, project-first (free)
├── Andrew Ng's courses (Coursera, can audit free)
└── Andrej Karpathy's Neural Networks: Zero to Hero (YouTube)

Startup
├── Y Combinator Startup School — startupschool.org (free)
├── Stanford CS183 (Peter Thiel) — notes available free
└── Lenny's Podcast — best product thinking conversations
```

## Communities

```
Academic
├── r/MachineLearning, r/compsci, r/AskComputerScience
├── Papers With Code community
├── HuggingFace forums
└── Your university's research groups (join early)

Startup
├── Hacker News — news.ycombinator.com
├── Indie Hackers — indiehackers.com (bootstrapped startups)
├── r/startups, r/entrepreneur
├── Y Combinator Alumni network (if you do YC)
└── Twitter/X tech community
```

---

---

# 13. THE MASTER MENTAL MODEL

Everything in this document compresses into one loop:

```
OBSERVE
└── Notice something broken, missing, or unexplained in the world
    "Why does X fail?" / "Why doesn't Y exist?" / "What if Z worked differently?"

        ↓

QUESTION
└── Form a precise, falsifiable question about it
    Not a topic. A question. With a possible wrong answer.

        ↓

SURVEY
└── Understand everything that already exists
    What has been tried? What worked? What failed? What was assumed?

        ↓

HYPOTHESIZE
└── Propose your answer BEFORE testing
    "If I do X, then Y will happen because Z"
    Commit to a prediction. This is what keeps you honest.

        ↓

EXPERIMENT
└── Smallest possible test of your hypothesis
    Academic: controlled experiment with baselines and metrics
    Startup: interview, landing page, presell, concierge

        ↓

MEASURE
└── Collect honest data
    Numbers that could prove you wrong, not just right.

        ↓

ANALYZE
└── Understand WHY, not just WHAT
    Why did it work? Why did it fail in these cases?
    What alternative explanations exist?

        ↓

COMMUNICATE
└── Tell the world what you found
    Academic: paper / talk / blog post
    Startup: product / pitch / case study

        ↓

ITERATE
└── The output of communicating is new observations
    New data. New questions. New hypotheses.
    The loop restarts, faster and with better questions.
```

---

## The Deeper Truth

Academic research and startup product research are not two different disciplines wearing the same name.

They are **one discipline** operating at different frequencies.

The academic researcher iterates over months. The founder iterates over weeks. The great technologist does both simultaneously — publishing the insight and building the product.

```
Academic cycle:   Problem → Research → Paper → Field advances
Startup cycle:    Problem → Research → Product → Market advances
Combined:         Problem → Research → Paper + Product → World advances
```

You are a CS student. You have been handed the rare gift of time and structure to develop the research mindset before the market pressure sets in.

Use this time to develop the habit of asking precise questions, of testing rather than assuming, of being honest about what you don't know.

**That habit — not the specific tools, not the frameworks, not the templates — is what makes a great researcher and a great founder.**

The tools change. The templates get updated. The habit of rigorous curiosity compounds forever.

---

*Document Version: 1.0*
*Last Updated: 2026*
*Total Length: ~12,000 words*
*Sections: 13 major sections, 50+ subsections*
*This is a living document — update it as you learn.*
