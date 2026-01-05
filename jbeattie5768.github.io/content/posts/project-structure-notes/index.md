+++
date = '2025-07-29'
draft = true
title = 'Project Structure Notes'
tags = []
+++

- <https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/>
- <https://github.com/pypa/sampleproject>
- <https://jcalderone.livejournal.com/39794.html>
- Different for different projects
- Example directories may be:

    ```markdown
    my_application
    │   .gitignore
    │   .python-version
    │   pyproject.toml
    │   README.md
    ├───docs
    │       Installation.md
    |───images
    ├───libs
    ├───src
    │   └───myapp
    │           main.py
    │           py.typed
    ├───tests
    |
    ```

What does this give?  
[CoPilot Folder Structure Blueprint Generator Prompt](https://github.com/github/awesome-copilot/blob/main/prompts/folder-structure-blueprint-generator.prompt.md)  
Try it on this example structure: [WebDevSimplified]](<https://github.com/WebDevSimplified/parity-deals-clone/tree/feature-folder-structure#>)

- Don’t crowd the root directory
- Be consistent
  - Make it habit-forming
- Use a [VCS](https://www.notion.so/Git-and-GitHub-165f7ac5770a4041add289b41c0d790a?pvs=21) immediately
  - Make your Git history meaningful
- Be modular and componentize (many files are ok)
- Documentation ← , at a minimum, includes an installation guide
- Testing, not always necessary, but shows commitment and a basic “will do” attitude
- Dependency management ← are the packages maintained
- CI/CD
- Code review ← take a step back/away and the review
- [Make it Work, Make it Right, Make it Fast](https://www.notion.so/Python-Setup-1e40fdecfb4b427ea97af3232691ee84?pvs=21)
