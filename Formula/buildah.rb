class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://buildah.io"
  url "https://github.com/containers/buildah/archive/refs/tags/v1.32.0.tar.gz"
  sha256 "806ed541ea3cc761e0fa2dde8c6ee2d6ed258baf1cc5bd72b6b0cf1e876dda15"
  license "Apache-2.0"

  bottle do
    root_url "https://raw.githubusercontent.com/you54f/homebrew-krun/master/bottles" 
    sha256 cellar: :any, arm64_sonoma: "728efb36e8cb36e6b9e87c3946d6f6e39c8262e1da3bdc3c5d2ada5c4c8c0df7"
    # sha256 cellar: :any, arm64_ventura: "62df65e2b7a98f59dd3e683c18992c35144ea780947cb0fc164165329972d878"
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
