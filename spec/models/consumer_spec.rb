require 'rails_helper'
require Rails.root.join "spec/models/concerns/clean_up_user_input_spec.rb"

RSpec.describe Consumer, type: :model do
  it_behaves_like 'clean_up_user_input'
end
