class Yapp < Formula
  desc "Yazi as a standalone macOS app with its own identity"
  homepage "https://github.com/tergel-996/yapp"
  url "https://github.com/tergel-996/yapp/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e91cf6a6ef49f77080f6fc082515d99972015e5868dded7c0dadac390c4e774e"
  license "MIT"

  depends_on "go" => :build
  depends_on "yazi"
  depends_on :macos

  def install
    ldflags = "-X github.com/tergel/yapp/internal/cli.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/yapp"
  end

  def post_install
    ohai "Run 'yapp install' to create the Yapp.app bundle"
    ohai "Run 'yapp set-terminal auto' to configure your terminal emulator"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/yapp version")
  end
end
