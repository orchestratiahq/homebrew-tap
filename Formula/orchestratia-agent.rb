class OrchestratiaAgent < Formula
  include Language::Python::Virtualenv

  desc "Cross-platform daemon for AI agent orchestration"
  homepage "https://orchestratia.com"
  url "https://github.com/kumarimlab/orchestratia-agent/archive/refs/tags/v0.15.0.tar.gz"
  sha256 "1b89ddd973082d44f67fdbed71cf88fa23b8eb438f4a3688bae25608efd58c9f"
  license "MIT"
  head "https://github.com/kumarimlab/orchestratia-agent.git", branch: "main"

  depends_on "python@3.12"
  depends_on "tmux"

  # Python deps are installed at install-time by pip from PyPI. This
  # tap-flavoured formula trades strict reproducibility (resource blocks
  # per dep) for simplicity — the agent has only 5 light dependencies
  # (httpx, websockets, pyyaml, psutil, pyte) and they all ship pre-built
  # wheels for macOS arm64/x86_64. If we ever submit to homebrew-core
  # we'll need to convert to resource blocks.
  def install
    venv = virtualenv_create(libexec, "python3.12")
    system venv.pip_path, "install", "--no-cache-dir", "."
    bin.install_symlink Dir["#{libexec}/bin/orchestratia*"]
  end

  # `brew services start orchestratia-agent` will run the daemon under
  # launchd. Logs land in /opt/homebrew/var/log/orchestratia.log (or
  # /usr/local/var/log on Intel Macs).
  service do
    run [opt_bin/"orchestratia-agent"]
    keep_alive true
    log_path var/"log/orchestratia.log"
    error_log_path var/"log/orchestratia.error.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/orchestratia-agent --version 2>&1")
  end
end
