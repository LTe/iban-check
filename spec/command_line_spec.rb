require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'aruba/api'

describe "Command line" do
  include Aruba::Api

  before(:all) do
    @aruba_timeout_seconds = 10
    extra_path_folder = File.join(File.expand_path(File.dirname(__FILE__)), '../bin')
    ENV['PATH'] = [extra_path_folder, ENV['PATH']].join(File::PATH_SEPARATOR)
  end

  describe 'when given no arguments' do
    before { run 'iban-check' }
    specify { assert_matching_output 'Exactly one argument expected', all_stderr }
    specify { assert_exit_status 1 }
  end

  describe 'when given a valid IBAN between double-quotes' do
    before { run 'iban-check "PL27 1140 2004 0000 3002 0135 5387"' }
    specify { assert_matching_output 'Valid IBAN', all_stdout }
    specify { assert_exit_status 0 }
  end

  describe 'when given a valid IBAN without double-quotes nor spaces' do
    before { run 'iban-check PL27114020040000300201355387' }
    specify { assert_matching_output 'Valid IBAN', all_stdout }
    specify { assert_exit_status 0 }
  end

  describe 'when given an invalid IBAN' do
    before { run 'iban-check "PL27 1140 2004 0000 3002 0135 5388"' }
    specify { assert_matching_output 'Invalid IBAN', all_stderr }
    specify { assert_exit_status 1 }
  end

  describe 'when given an invalid country code' do
    before { run 'iban-check "Z927 1140 2004 0000 3002 0135 5388"' }
    specify { assert_matching_output 'Invalid country', all_stderr }
    specify { assert_exit_status 1 }
  end

end
