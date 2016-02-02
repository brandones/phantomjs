class Phantomjs < Formula
  desc "Headless WebKit scriptable with a JavaScript API"
  homepage "http://phantomjs.org/"
  url "https://github.com/brandones/phantomjs.git",
      :tag => "2.1.2",
      :revision => "da1b0a39bab762ea0e6fd16880b9573e2408e8de"
  head "https://github.com/brandones/phantomjs.git"

  bottle do
    cellar :any
    sha256 "f66255cd772834de297a10fc7053800bfbd99c4833196958c18f05299dec6bc9" => :el_capitan
  end

  depends_on :xcode => :build
  depends_on "openssl"

  def install
    inreplace "build.py", "/usr/local", HOMEBREW_PREFIX
    system "./build.py", "--confirm", "--jobs", ENV.make_jobs
    bin.install "bin/phantomjs"
    pkgshare.install "examples"
  end

  test do
    path = testpath/"test.js"
    path.write <<-EOS
      console.log("hello");
      phantom.exit();
    EOS

    assert_equal "hello", shell_output("#{bin}/phantomjs #{path}").strip
  end
end
