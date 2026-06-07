class VaultSync < Formula
  desc "A fast, local-first note manager with multi-backend sync (Obsidian, Notion, Git)"
  homepage "https://vaultsync.dev"
  license "MIT"

  depends_on "go" => :build

  stable do
    url "https://github.com/ishyverma/vault-sync.git",
        tag:      "v1.0.0",
        revision: "c23493c49a6ef3b42d250d58570c04668dfa372d"
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
