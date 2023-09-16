class Libkrunfw < Formula
  desc "Dynamic library bundling a Linux kernel in a convenient storage format"
  homepage "https://github.com/you54f/libkrunfw"
  url "https://github.com/you54f/libkrunfw/releases/download/v3.13.0/v3.13.0-with_macos_prebuilts.tar.gz"
  sha256 "9e2841d64a048403876a9bce960c20a7f840ed937773273a0cda337c2519d4f9"
  license all_of: ["GPL-2.0-only", "LGPL-2.1-only"]

  bottle do
    root_url "https://raw.githubusercontent.com/you54f/homebrew-krun/master/bottles"
    # sha256 cellar: :any, arm64_ventura: "1c423c2240ef907eca6df8dfdb5e534b2fa7e7c7425f28be4fec83b13e3d0a42"
    sha256 cellar: :any, arm64_sonoma: "4508a8b4995411311a5f8a5907dc12ba129dbf235ab2f79cea64b6307338e3e3"
  end

  # libkrun, our only consumer, only supports Hypervisor.framework on arm64
  depends_on arch: :arm64

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      int krunfw_get_version();
      int main()
      {
         int v = krunfw_get_version();
         return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lkrunfw", "-o", "test"
    system "./test"
  end
end
