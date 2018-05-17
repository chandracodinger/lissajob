require 'rails_helper'

RSpec.describe Vacancy, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:salary) }
  it { should validate_presence_of(:requipment) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:expired) }
end
