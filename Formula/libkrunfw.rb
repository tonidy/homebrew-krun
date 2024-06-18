class Libkrunfw < Formula
  desc "Dynamic library bundling a Linux kernel in a convenient storage format"
  homepage "https://github.com/tonidy/libkrunfw"
  url "https://github.com/tonidy/libkrunfw/releases/download/v4.1.0/v4.1.0-with_macos_prebuilts.tar.gz"
  sha256 "75120318f4615e1d4a8d53092062282b875443d75e0a7565df8a64f118dddafc"
  license all_of: ["GPL-2.0-only", "LGPL-2.1-only"]

  bottle do
    root_url "https://raw.githubusercontent.com/tonidy/homebrew-krun/master/bottles"
    sha256 cellar: :any, arm64_sonoma: "aad24831c461c7409f4ac0d5633176d1193eb670b494169f6d905e66faf23529"
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
