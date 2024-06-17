class Krunvm < Formula
  desc "Manage lightweight VMs created from OCI images"
  homepage "https://github.com/tonidy/krunvm"
  url "https://github.com/tonidy/krunvm/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "c600d35f330820d015818482b3c6311f94fbe63a340d03c5c7ff938cbf2e5bc4"
  license "Apache-2.0"

  bottle do
    root_url "https://raw.githubusercontent.com/tonidy/homebrew-krun/master/bottles"
    sha256 cellar: :any, arm64_sonoma: "e4df1d7f3f0f8408f0057da28485cc741b3d1873e7c0e892bef8a81ccbb942aa"
  end

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build
  # We depend on libkrun, which only supports Hypervisor.framework on arm64
  depends_on arch: :arm64
  depends_on "buildah"
  depends_on "libkrun"

  def install
    system "make"
    bin.install "target/release/krunvm"
    man1.install Dir["target/release/build/krunvm-*/out/*.1"]
  end

  test do
    system "krunvm", "--version"
  end
end
