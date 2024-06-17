class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://buildah.io"
  url "https://github.com/containers/buildah/archive/refs/tags/v1.36.0.tar.gz"
  sha256 "c2dd61b3d31576c71001eae1b7cabd7e714bdef8dd7b84d8d59496f26810840d"
  license "Apache-2.0"

  bottle do
    root_url "https://raw.githubusercontent.com/you54f/homebrew-krun/master/bottles" 
    sha256 cellar: :any, arm64_sonoma: "5a7745bd51facf354df5f8ca9706d9a52106c24936e60ae7655a32e8a81633d3"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "gpgme"

  def install
    system "make", "bin/buildah", "docs"
    bin.install "bin/buildah" => "buildah"
    mkdir_p etc/"containers"
    etc.install "docs/samples/registries.conf" => "containers/registries.conf"
    etc.install "tests/policy.json" => "containers/policy.json"
    man1.install Dir["docs/*.1"]
  end

  test do
    assert_match "buildah version", shell_output("#{bin}/buildah -v")
  end
end
