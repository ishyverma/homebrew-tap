class VaultSync < Formula
  desc "A fast, local-first note manager with multi-backend sync (Obsidian, Notion, Git)"
  homepage "https://vaultsync.dev"
  license "MIT"

  depends_on "go" => :build

  stable do
    url "https://github.com/ishyverma/vault-sync.git",
        tag:      "v1.0.0",
        revision: "c23493c1a184d79d11e3cf12f4d6de9a1cb32d87"
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
