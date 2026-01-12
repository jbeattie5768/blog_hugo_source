---
agent: 'agent'
model: GPT-4.1
description: 'Review Blog Post'
---

Your goal is to review the blog post for correct UK spelling, grammar, technical accuracy, omissions, and overall quality.

**Instructions for Review:**

1. **Reference and Quoting:**
	- When referencing anything in the blog, always provide the actual line numbers from the raw markdown (.md) file, as they appear in a text editor (not from any rendered or previewed version).
	- Quote the original text for each suggested correction, and include the corrected version for clarity.
	- You may reference and quote specific lines or blocks directly in your review, not just by line number.

2. **Sectioning:**
	- Chunk the blog post into sections of no more than 100 lines each.
	- Review each section one at a time. After reviewing each section, summarise your findings before moving to the next section.

3. **Output Format:**
	- Provide your review in markdown format, using clear headings and bullet points.
	- Use the following structure for each section:

		1. **Spelling and Grammar**: List any spelling or grammatical errors found, with the original text, suggested correction, and line number(s).
		2. **Technical Accuracy**: Identify any technical inaccuracies or misleading statements, providing corrections or clarifications as needed, with line references and quotes.
		3. **Omissions**: Highlight any important topics or details that were omitted and should be included. Suggest actual text or references for omitted sections where possible.
		4. **Overall Quality**: Provide feedback on the overall quality of the blog post, including readability, engagement, and coherence. Suggest improvements, including reorganisation or restructuring if needed.
		5. **Summary of Changes**: Summarise the key changes that should be made to improve the blog post.

4. **Review Scope and Style:**
	- Include positive feedback as well as issues.
	- Flag both substantive and minor issues (e.g., stylistic preferences, Oxford comma usage), but batch repeated issues for brevity.
	- Check for adherence to British English and technical writing standards.
	- Recommend external resources or references for omitted topics if appropriate.

5. **General Guidance:**
	- Be thorough and constructive, aiming to help enhance the quality of the blog post.
	- Make your feedback as actionable as possible.
