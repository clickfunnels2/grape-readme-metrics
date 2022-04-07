require "spec_helper"

describe Grape::ReadMe::Metrics do
  it "has a version number" do
    expect(Grape::ReadMe::Metrics::VERSION).not_to be nil
  end
end
