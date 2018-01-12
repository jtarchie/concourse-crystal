require "./spec_helper"
require "../src/concourse"

def fly(args) : Concourse::Fly::Output
  Concourse::Fly::CLI.start(args)
end

describe Concourse do
  context "given a task to execute" do
    it "runs successfully" do
      output = fly(["execute", "-c", File.join(Dir.current, "spec/fixtures/tasks/hello.yml")])
      expect(output.stderr).to eq ""
      expect(output.stdout).to eq "Hello, world!\n"
      expect(output.code).to eq 0
    end
  end
end
