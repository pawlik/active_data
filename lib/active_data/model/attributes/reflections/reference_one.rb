module ActiveData
  module Model
    module Attributes
      module Reflections
        class ReferenceOne < Base
          def self.build target, generated_methods, name, *args, &block
            options = args.extract_options!
            generate_methods name, generated_methods
            new(name, options)
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
            RUBY
          end

          def association
            @association ||= options[:association].to_s
          end

          def inspect_reflection
            "#{name}: (#{association} reference)"
          end

          def type
            Integer
          end
        end
      end
    end
  end
end