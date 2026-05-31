# homebrew-tap

Homebrew tap for [**phasor**](https://github.com/interpretica-io/phasor) — a
terminal and browser dashboard to monitor and orchestrate AI coding agents in
tmux.

## Install

```sh
brew install --HEAD interpretica-io/tap/phasor   # latest from main (builds from source)
brew install interpretica-io/tap/phasor          # tagged release
```

The tagged form needs a published release whose `sha256` is set in
`Formula/phasor.rb`; until then use `--HEAD`. Both build from source and pull in
Rust (build) and tmux (runtime) automatically.

> phasor also drives the Claude Code CLI (`claude`), which is not available via
> Homebrew — install it separately and keep it on your `PATH`.
