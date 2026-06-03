# homebrew-tap

Homebrew tap for [**interpretica-io**](https://github.com/interpretica-io)
projects.

## Formulae

- [**phasor**](https://github.com/interpretica-io/phasor) — a terminal and
  browser dashboard to monitor and orchestrate AI coding agents in tmux.
- [**basis**](https://github.com/interpretica-io/basis) — the Constellation
  build system: build, version and sync groups of repositories.

## Install

```sh
brew install --HEAD interpretica-io/tap/phasor   # latest from main (builds from source)
brew install interpretica-io/tap/phasor          # tagged release

brew install --HEAD interpretica-io/tap/basis    # latest from main (builds from source)
brew install interpretica-io/tap/basis           # tagged release
```

The tagged form needs a published release whose `sha256` is set in the formula
(`Formula/<name>.rb`); until then use `--HEAD`. Both formulae build from source
and pull in Rust automatically.

> phasor also drives the Claude Code CLI (`claude`), which is not available via
> Homebrew — install it separately and keep it on your `PATH`.
