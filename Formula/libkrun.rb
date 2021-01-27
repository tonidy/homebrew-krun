class Libkrun < Formula
  desc "Dynamic library providing KVM-based process isolation capabilities"
  homepage "https://github.com/containers/libkrun"
  url "https://github.com/containers/libkrun/releases/download/v0.1.3/v0.1.3-with_prebuilts.tar.gz"
  sha256 "a8d5d2d7f631ba42b25a7b977349e8856b9d025e405afc50fd0ba992671afce5"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/slp/bottles-krun"
    cellar :any
    sha256 "b8a811eaa7bf07e826c20a4e502ae2a0bbd1aa6000af21278b31af5325786a40" => :arm64_big_sur
  end

  depends_on "rust" => :build
  depends_on "dtc"
  depends_on "libkrunfw"

  def install
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
