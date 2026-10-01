# Xihan Yao — CV and Resume

LaTeX sources for my academic CV and my job-search resume. Every push to `main`
rebuilds the PDFs and publishes them, so these links always point at the
current version:

- CV: <https://xyaoaf.github.io/XihanYao_CV/cv.pdf>
- Resume: <https://xyaoaf.github.io/XihanYao_CV/resume.pdf>
- <https://xyaoaf.github.io/XihanYao_CV/> redirects to the CV

## Documents

| Source | What it is | Published |
|---|---|---|
| `cv.tex` | Full academic CV | yes |
| `resume.tex` | General resume for job applications | yes |
| `resume_ExxonMobil.tex` | Resume tailored to ExxonMobil | no |
| `resume_ReadyNet.tex` | Resume tailored to ReadyNet | no |

The tailored resumes are compiled in CI as a check that they still build, but
they are not published.

## Public and private builds

The phone number is left out of the default build, because that is the build
published to the public site. `make private` puts it back, for copies sent
directly to people.

```sh
make            # cv.pdf, resume.pdf, ...                  no phone; what CI publishes
make private    # cv_private.pdf, resume_private.pdf, ...  with phone
make cv         # one document only
make clean      # remove intermediate files
make distclean  # remove the PDFs as well
```

Each source reads a `\PrivateBuild` flag that defaults to 0. `make private`
sets it to 1 from the command line, so switching never means editing a
source. Private PDFs get a different file name so the publish step cannot pick
them up, and every PDF is gitignored.

## Building locally

Needs a TeX distribution with XeLaTeX, latexmk and biber (TeX Live or MacTeX).
The sources load `fontspec` and `xeCJK`, so they compile with XeLaTeX only, not
pdfLaTeX.

Fonts:

- **TeX Gyre Termes, Heros and Cursor.** TeX Live ships these, but fontspec
  looks fonts up by name in the system font database, and TeX Live does not
  register them there. On macOS, copy them in once:

  ```sh
  cp /usr/local/texlive/*/texmf-dist/fonts/opentype/public/tex-gyre/texgyre{termes,heros,cursor}-*.otf ~/Library/Fonts/
  ```

  A symlink is not enough; macOS does not follow it. On Debian or Ubuntu,
  install `fonts-texgyre` instead.

- **CJK.** The Chinese name in the CV header is set in Noto Serif CJK SC where
  that font exists (Overleaf, the CI runner) and falls back to Songti SC on
  macOS. Neither needs any setup.

## Publishing

`.github/workflows/build.yml` runs on every push to `main`. It installs TeX Live
and the fonts, checks that every font the sources name resolves, runs `make`,
and force-pushes `cv.pdf`, `resume.pdf` and `index.html` to the orphan `build`
branch, which GitHub Pages serves. A push is a release; nothing else needs
doing by hand.

## Overleaf

This repository is also linked to an Overleaf project through Overleaf's
GitHub integration. That sync is manual in both directions: after pushing from
here, pull the GitHub changes into Overleaf from its GitHub menu before editing
there, or the two copies will diverge. This repository is the source of truth.

## Credits

Built on the [autoCV](https://github.com/jitinnair1/autoCV) template by Jitin
Nair, MIT License.
