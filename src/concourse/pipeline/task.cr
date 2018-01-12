require "yaml"
require "./version"

module Concourse
  module Pipeline
    class ImageResource
      YAML.mapping(
        type: String,
        source: Hash(String, String),
        params: Hash(String, String)?,
        version: Version?,
      )
    end

    class Input
      YAML.mapping(
        name: String,
        path: String?
      )
    end

    class Output
      YAML.mapping(
        name: String,
        path: String?
      )
    end

    class Cache
      YAML.mapping(
        path: String
      )
    end

    class Run
      YAML.mapping(
        path: String,
        args: {
          type: Array(String),
          default: [] of String,
        },
        dir: String?,
        user: String?
      )
    end

    class Task
      class Config
        YAML.mapping(
          platform: String,
          image_resource: ImageResource,
          rootfs_uri: String?,
          inputs: {
            type: Array(Input)?,
            default: [] of Input,
          },
          outputs: {
            type: Array(Output)?,
            default: [] of Output,
          },
          caches: {
            type: Array(Cache)?,
            default: [] of Cache,
          },
          run: Run,
          params: Hash(String, String)?,
        )
      end
    end
  end
end
