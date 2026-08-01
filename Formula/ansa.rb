class Ansa < Formula
  desc "Tiny single point for agents to exchange messages"
  homepage "https://github.com/interpretica-io/ansa"
  # Stable release. After tagging `vX.Y.Z`, point `url` at that tag and set
  # `sha256` to the source tarball's checksum — `brew fetch ansa` prints it,
  # or run `shasum -a 256` on the downloaded tarball.
  url "https://github.com/interpretica-io/ansa/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "967f3eca4af882a39e5360f95eb688ed5dc635af5c503d4a5a91c1077f5ef5c2"
  license "MIT"
  head "https://github.com/interpretica-io/ansa.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      To teach an assistant how to use the bus:
        ansa install-skill claude    # Claude Code skill -> ~/.claude/skills
        ansa install-skill codex     # Codex CLI skill   -> ~/.codex/skills
        ansa install-skill chatgpt   # Custom GPT files + setup steps
    EOS
  end

  test do
    port = free_port
    ENV["ANSA_ADDR"] = "127.0.0.1:#{port}"
    pid = fork { exec bin/"ansa" }
    begin
      output = shell_output(
        "curl -s --retry 5 --retry-connrefused http://127.0.0.1:#{port}/health",
      )
      assert_equal "ok", output
    ensure
      Process.kill("TERM", pid)
    end
  end
end
