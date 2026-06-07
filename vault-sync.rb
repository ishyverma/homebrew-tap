class VaultSync < Formula
  desc "A fast, local-first note manager with multi-backend sync (Obsidian, Notion, Git)"
  homepage "https://vaultsync.dev"
  license "MIT"

  depends_on "go" => :build

  stable do
    url "https://github.com/ishyverma/vault-sync.git",
        tag: "v1.0.1"",
        revision: "7805d71e51cf9ec214bf2dfa008dc24d830d876c"
  end

  head do
    url "https://github.com/ishyverma/vault-sync.git", branch: "main"
  end

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"vault"), "./cmd/vault"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"vaultd"), "./cmd/vaultd"
  end

  test do
    assert_match "vault", shell_output("#{bin}/vault --help")
  end
end
