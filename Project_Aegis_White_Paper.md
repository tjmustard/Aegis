# **Project Aegis: Deterministic State Machines for Automated Career Artifact Generation**

## **Abstract**

The modern job application process requires hyper-targeted resumes and cover letters. However, utilizing standard Large Language Models (LLMs) to rewrite application materials frequently results in hallucinated metrics, generic phrasing, and broken document formatting. Project Aegis introduces a First Principles approach to career data management. By deconstructing professional history into a strictly typed YAML database, governing a CLI-based LLM with a rigid State Machine, and utilizing a hermetic Typst compilation pipeline, Aegis completely decouples career data from its presentation layer. This architecture enables the rapid, deterministic generation of ATS-optimized artifacts without the risk of generative hallucination.

## **1\. Introduction: The Failure of Unstructured Prompting**

The conventional method of using generative AI for resume tailoring involves passing a flat text document to an LLM and requesting a customized output. This zero-shot approach is fundamentally flawed. Unstructured text forces the model to guess the underlying business context and metrics. Consequently, the model will often invent statistics or misattribute skills to satisfy the constraints of the target Job Description (JD).

To achieve high-fidelity generation, we must abandon flat text. Project Aegis treats a professional career not as a document, but as a relational database. By forcing the LLM to interact strictly with this database via a controlled protocol, we eliminate hallucination and guarantee data integrity.

## **2\. Data Architecture: The Master Career Database**

The core of Aegis is the master\_career\_db.yaml schema. This structure abandons traditional paragraph-based experience summaries in favor of discrete, atomic nodes.

### **2.1. Atomic Achievements and Skill Tagging**

Within the database, every professional milestone is logged as an "Atomic Achievement." Each achievement requires two mandatory arrays: impact\_metrics and skills\_applied.

If an engineer migrated a database, the text of the achievement is isolated from the tools used (e.g., Python, AWS) and the quantifiable result (e.g., 40% latency reduction). When the system ingests a new Job Description, it does not rely on semantic similarity to rewrite paragraphs. Instead, it programmatically queries these skill tags, ensuring a deterministic match between the candidate's actual history and the employer's explicit requirements.

## **3\. The Cognitive Engine: Enforcing the State Machine**

LLMs possess an autoregressive architecture. When given a complex task, they naturally attempt to generate the entire solution in a single, unbroken output stream. For a tailored resume, this bypasses the critical step of human review.

Aegis solves this by implementing the Interactive Tailoring Skill. This is not a standard prompt. It is a strict State Machine protocol that governs the claude-code CLI agent.

### **3.1. The Phased Generation Loop**

The State Machine forces the agent through a rigid sequence:

1. **JD Deconstruction:** The agent analyzes the target job and outputs a required profile. It must then halt execution.  
2. **Node Selection:** The agent proposes specific atomic achievements from the YAML database that match the profile. It must explicitly justify why certain bullets were selected or dropped. It halts again.  
3. **Drafting:** The agent drafts the cover letter based only on the approved nodes. It halts a final time.  
4. **Compilation:** Upon final user approval, the agent exports a temporary tailored\_resume.yaml subset.

By injecting hard \[WAITING FOR USER APPROVAL\] stops into the prompt, the architecture ensures the human operator maintains absolute veto power over the final data payload.

## **4\. Presentation Layer and Hermetic Compilation**

Aegis enforces a strict separation of content and presentation. The LLM is expressly forbidden from writing typesetting code during the tailoring loop.

### **4.1. Typst for ATS Optimization**

Standard Markdown-to-PDF converters produce unpredictable text layers, which often fail parsing by Applicant Tracking Systems (ATS). LaTeX provides precision but introduces massive dependency chains and slow compilation times.

Aegis utilizes Typst, a modern, Rust-based typesetting engine. Typst natively parses YAML data. The Aegis Typst templates are configured as pure functions that ingest tailored\_resume.yaml and output clean, standard-font PDFs with perfectly extractable text layers.

### **4.2. Ephemeral Build Orchestration**

To prevent local environment rot, the build pipeline is managed by a single Python script utilizing the uv package manager. The script leverages PEP 723 inline metadata to request the Typst compiler at runtime. The user simply executes the script, uv builds a hermetic environment, compiles the PDF, and exits cleanly. There are no persistent virtual environments to maintain.

## **5\. Epistemic Constraints and Vulnerabilities**

The Aegis architecture relies on a clear understanding of its operational limits.

1. **Vision Model Limitations:** Aegis includes a skill for replicating existing resume layouts by passing an image of a PDF to the LLM. However, current vision models lack the spatial reasoning required for pixel-perfect typographical replication. The generated Typst templates will always require a human-in-the-loop to manually adjust margins, fonts, and kerning.  
2. **Context Bloat:** Maintaining a directory of few-shot examples (successful past resumes and cover letters) grounds the model's writing style. If this directory grows too large, the total token count will degrade the agent's performance. The example repository must be strictly curated.

## **6\. Conclusion**

Project Aegis demonstrates that resume tailoring is a data routing problem, not a creative writing exercise. By combining a strictly typed YAML database, a State Machine protocol to throttle LLM autoregression, and an ephemeral compilation engine, Aegis provides a frictionless, zero-maintenance pipeline for generating highly targeted professional artifacts.