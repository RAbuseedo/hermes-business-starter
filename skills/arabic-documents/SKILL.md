---
name: arabic-documents
description: "Use when reading or producing Arabic/RTL documents, PDFs or slides."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [arabic, rtl, documents, translation]
    related_skills: [pdf, docx, powerpoint, agency-marketing]
---

# Arabic and RTL documents

## Reading
- Text layers in Arabic PDFs are often broken (reversed or disconnected letters). If extracted text looks wrong, render pages to images and read them visually instead; quote only what you can see.
- Always note which language each part of a bilingual document is in.

## Producing
- Word: set the paragraph direction to right-to-left for Arabic runs and use a font with good Arabic support (for example Noto Naskh Arabic, Dubai, or the client's brand font). With python-docx, set `w:bidi` on paragraphs and `w:rtl` on runs.
- Slides and PDFs: check alignment, numbers, punctuation and mixed English words inside Arabic sentences by rendering and looking at the result before sharing.
- Translation: meaning first, then tone; keep legal and official terms consistent with the client's own documents; flag anything you are not sure of rather than guessing.
- Final check by a native speaker on the team before anything goes to a client; say so in the handoff.
