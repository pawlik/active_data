module ActiveData
  module Model
    module Attributes
      module Reflections
        class Attribute < Base
          def self.build target, generated_methods, name, *args, &block
            attribute = build_instance(target, generated_methods, name, *args, &block)
            generate_methods name, generated_methods
            attribute
          end

          def self.generate_methods name, target
            target.class_eval <<-RUBY, __FILE__, __LINE__ + 1
              def #{name}
                attribute('#{name}').read
              end

              def #{name}= value
                attribute('#{name}').write(value)
              end

              def #{name}?
                attribute('#{name}').value_present?
              end

              def #{name}_before_type_cast
                attribute('#{name}').read_before_type_cast
              end

              def #{name}_default
                attribute('#{name}').default
              end

              def #{name}_values
                attribute('#{name}').enum.to_a
              end
            RUBY
          end

          def defaultizer
            @defaultizer ||= options[:default]
          end

          def typecaster
            @typecaster ||= ActiveData.typecaster(type.ancestors.grep(Class))
          end

          def enumerizer
            @enumerizer ||= options[:enum] || options[:in]
          end

          def normalizers
            @normalizers ||= Array.wrap(options[:normalize] || options[:normalizer] || options[:normalizers])
          end
        end
      end
    end
  end
end