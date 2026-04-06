class Yapp < Formula
  desc "Yazi as a standalone macOS app with its own identity"
  homepage "https://github.com/tergel-996/yapp"
  url "https://github.com/tergel-996/yapp/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "c66ee7f7e49bb01f8652979b9d1e301a3696ee4518ad17e6c7ebf55bbf08e258"
  license "MIT"

  depends_on "go" => :build
  depends_on "yazi"
  depends_on :macos

  def install
    ldflags = "-X github.com/tergel/yapp/internal/cli.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:, output: bin/"yapp-cli"), "./cmd/yapp"
  end

  def post_install
    ohai "Run 'yapp-cli install' to create the Yapp.app bundle"
    ohai "Run 'yapp-cli set-terminal auto' to configure your terminal emulator"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/yapp-cli version")
  end
end
