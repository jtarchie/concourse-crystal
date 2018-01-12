require "clim"
require "yaml"
require "../pipeline/task"

module Concourse
  module Fly
    class Output
      property stdout : IO::Memory?
      property stderr : IO::Memory?
      property status : Process::Status?

      def initialize(@stdout : IO::Memory, @stderr : IO::Memory, @status : Process::Status)
      end
    end

    class CLI < Clim
      sub do
        command "execute"
        # array "-i name=directory", "--input=name=directory", desc: "An input to provide to the task", default: [] of String
        string "-c filename", "--config=filename", desc: "The task config to execute", required: true
        run do |opts, args|
          task = Concourse::Pipeline::Task::Config.from_yaml(File.read(opts["config"].as(String)))
          stdout, stderr = IO::Memory.new, IO::Memory.new
          status = Process.run(
            command: "docker",
            args: ["run", "-i", task.image_resource.source["repository"], task.run.path] + task.run.args,
            output: stdout,
            error: stderr
          )
          next Output.new(stdout: stdout, stderr: stderr, status: status)
        end
      end
    end
  end
end
