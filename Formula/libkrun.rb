class Libkrun < Formula
  desc "Dynamic library providing KVM-based process isolation capabilities"
  homepage "https://github.com/you54f/libkrun"
  url "https://github.com/you54f/libkrun/releases/download/v1.6.0/v1.6.0-with_macos_prebuilts.tar.gz"
  sha256 "280b2711e76d9be72e64bb9b67d11b038e98eb56312c68fc6c51bb76b0e28d9a"
  license "Apache-2.0"

  bottle do
    root_url "https://raw.githubusercontent.com/you54f/homebrew-krun/master/bottles"
    sha256 cellar: :any, arm64_sonoma: "fb16e28247b95ad3dbcb501a7797584f7e16c07649b4161a61388d0dd78e96a4"
    # sha256 cellar: :any, arm64_ventura: "16e011e8d435e1b400ef1db790094acf47986e60e7f29a9aff39e6de94f43929"
  end

  depends_on "rust" => :build
  # Upstream only supports Hypervisor.framework on arm64
  depends_on arch: :arm64
  depends_on "dtc"
  depends_on "libkrunfw"

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libkrun.h>
      int main()
      {
         int c = krun_create_ctx();
         return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lkrun", "-o", "test"
    system "./test"
  end
end
