class Ansa < Formula
  desc "Tiny single point for agents to exchange messages"
  homepage "https://github.com/interpretica-io/ansa"
  # Stable release. After tagging `vX.Y.Z`, point `url` at that tag and set
  # `sha256` to the source tarball's checksum — `brew fetch ansa` prints it,
  # or run `shasum -a 256` on the downloaded tarball.
  url "https://github.com/interpretica-io/ansa/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "495ec0ffd9628e6ba5dcd5f3bb0eda55a1dbd489e10c363759fc4d1936d78631"
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
