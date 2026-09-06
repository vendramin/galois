# Package: mynotes.sty 

My personal LaTeX style for lecture notes. Colored section headings, a
lecture tracker for the margin, exercise/problem/question boxes, an
index, and a pile of math macros.

## Quick start

```latex
\documentclass[12pt]{amsproc}
\usepackage{mynotes}
\renewcommand{\course}{My course}
\title{\course}
\author{...}

\begin{document}
\maketitle
\lecture Today we start with... % marks a new lecture in the margin

\begin{definition}
...
\end{definition}
\end{document}
```

See [`example.tex`](example.tex) for a minimal working file.

## What it gives you

**Theorem-like environments** (all numbered together within a
section, via `theorem`): `theorem`, `lemma`, `proposition`,
`corollary`, `definition`, `example`, `remark`, `convention`, plus
unnumbered `claim`.

**Colored boxes**, each wrapping its own counter:

| Environment  | Box color | Counter        |
|--------------|-----------|-----------------|
| `problem`    | blue      | `open` (Open problem) |
| `question`   | blue      | `que` (Question) |
| `conjecture` | blue      | `conj` (Conjecture) |
| `exercise`   | green     | `xca` (Exercise) |
| `bonus`      | yellow    | `bxca` (Bonus exercise) |
| `optional`   | pink/red  | — (free-standing comment box) |

**Solutions.** `\begin{sol}{<label>} ... \end{sol}` writes a proof
titled by whatever `<label>` refers to (e.g. an exercise number),
with no QED box.

**Lectures.** `\lecture` starts a new lecture: it stamps a numbered
bubble in the margin and logs the point into `\jobname.lec`.
`\listoflectures` prints a clickable index built from that log
(needs a second compile).

**Nice TOC headers.** `\TOC{Part I}` inserts a colored heading line
into the table of contents.

**Misc.** `\emph` is red/blue bold instead of italic; section
headings are colored and centered; the running header shows
`\course`; code listings default to a small `Magma` language
definition; an index is enabled (`\makeindex` — run `makeindex`
separately and add `\printindex`).

## Notes 

- `\course` must be set with `\renewcommand{\course}{...}` before
  `\begin{document}`.
- The lecture list and margin bubbles need a second LaTeX pass (and a
  clean `.lec` file if things look stale — delete it and recompile
  twice).
- The index needs `makeindex <jobname>` between two `pdflatex` runs,
  plus `\printindex` somewhere in the document.

