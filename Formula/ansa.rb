class Ansa < Formula
  desc "Tiny single point for agents to exchange messages"
  homepage "https://github.com/interpretica-io/ansa"
  # Stable release. After tagging `vX.Y.Z`, point `url` at that tag and set
  # `sha256` to the source tarball's checksum — `brew fetch ansa` prints it,
  # or run `shasum -a 256` on the downloaded tarball.
  url "https://github.com/interpretica-io/ansa/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0ee80dbf61ed6eab51b967b58d0a8e1b881325bca27db719610aa04f81c00f29"
  license "MIT"
  head "https://github.com/interpretica-io/ansa.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
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
