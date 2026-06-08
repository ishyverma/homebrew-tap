class VaultSync < Formula
  desc "A fast, local-first note manager with multi-backend sync (Obsidian, Notion, Git)"
  homepage "https://vaultsync.dev"
  license "MIT"

  depends_on "go" => :build

  stable do
    url "https://github.com/ishyverma/vault-sync.git",
        tag: "v0.1.0",
        revision: "d5fb346958e3da53dd716758b82e6930963d0fa8"
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
