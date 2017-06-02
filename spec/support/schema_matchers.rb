RSpec::Matchers.define :match_schema do |schema|
  match do |obj|
    schema_directory = Rails.root.join("spec", "support", "schemas") # "#{Rails.root}/spec/support/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, obj, strict: true)
  end
end
