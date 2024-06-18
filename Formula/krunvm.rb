class Krunvm < Formula
  desc "Manage lightweight VMs created from OCI images"
  homepage "https://github.com/tonidy/krunvm"
  url "https://github.com/tonidy/krunvm/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "9361fe4b67b864394f6c0e2e42e8d1f8fdd374c5cab9c60fe6b583fb6a5a031f"
  license "Apache-2.0"

  bottle do
    root_url "https://raw.githubusercontent.com/tonidy/homebrew-krun/master/bottles"
    sha256 cellar: :any, arm64_sonoma: "05ba8d56e77f6c589afeec923bb4d80d1ccea764766daa877efa2750c3847a7e"
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
