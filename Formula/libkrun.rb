class Libkrun < Formula
  desc "Dynamic library providing KVM-based process isolation capabilities"
  homepage "https://github.com/containers/libkrun"
  url "https://github.com/tonidy/libkrun/releases/download/v1.9.2/v1.9.2-with_macos_prebuilts.tar.gz"
  sha256 "357cf2759494ae70ec9f7b69aa4a32057f70bf90ceaed4381475a9319f6f24f8"
  license "Apache-2.0"

  bottle do
    root_url "https://raw.githubusercontent.com/tonidy/homebrew-krun/master/bottles"
    sha256 cellar: :any, arm64_sonoma: "ed58433d296355e1c8bb097e2d25aed82d1135857439641d541ef30c56d68a5a"
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
