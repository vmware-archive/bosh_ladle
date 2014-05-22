require 'bosh_ladle/ami'
require 'webmock'

module BOSHLadle
  describe AMI do
    include WebMock::API

    describe '.latest' do
      let(:latest_ami) { 'magical-image' }
      let(:several_amis) { "foo\nbar\nbaz\n#{latest_ami}" }
      before do
        stub_request(:get, "http://bosh-lite-build-artifacts.s3.amazonaws.com/ami/bosh-lite-ami.list").
            to_return(:status => 200, :body => several_amis, :headers => {})

      end

      it 'returns the GUID of the last uploaded BOSH-liute AMI' do
        expect(AMI.latest).to eq latest_ami
      end
    end
  end
end