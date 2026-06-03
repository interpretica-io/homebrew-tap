class Basis < Formula
  desc "Constellation build system: build, version and sync groups of repositories"
  homepage "https://github.com/interpretica-io/basis"
  # Stable release. After tagging `vX.Y.Z`, point `url` at that tag and set
  # `sha256` to the source tarball's checksum — `brew fetch basis` prints it,
  # or run `shasum -a 256` on the downloaded tarball.
  url "https://github.com/interpretica-io/basis/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "3110f5645172cbbbb01ee23b25d46e4d3ae3144a84443c7744e6830e6808cd29"
  license "MIT"
  head "https://github.com/interpretica-io/basis.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/basis --version")
  end
end
