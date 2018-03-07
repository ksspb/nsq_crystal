require "../spec_helper"

# def setup
#   # Spec.before_each do
#   #   @cluster = NsqCluster.new(nsqd_count: 1)
#   #   @nsqd = @cluster.nsqd.first
#   #   @connection = Nsq::Connection.new(host: @cluster.nsqd[0].host, port: @cluster.nsqd[0].tcp_port)
#   # end

#   #@connection = Nsq::Connection.new(host: "localhost", port: "4151")
# end

# def shutdown
#  # @connection.close
# end

# Spec.after_each do
#   @connection.close
#   @cluster.destroy
# end
describe Nsq::Connection do
  describe "::stats" do
    it "should return stats as json data" do
      connection = Nsq::Consumer.new({:host => "localhost", :port => 4150, :topic => "topic", :channel => "channel"})

      json = connection.stats("topic", "channel")
      p json
    end
  end

  describe "::new" do
    it "should raise an exception if it cannot connect to nsqd" do
      # @nsqd.stop

      expect_raises(Errno) do
        connection = Nsq::Connection.new({:host => "localhost", :port => 4152, :topic => "topic", :channel => "channel"})
      end
      # }.to raise_error(Errno::ECONNREFUSED)
    end

    it "should raise an exception if it connects to something that isn\'t nsqd" do
      connection = Nsq::Connection.new({:host => "localhost", :port => 4150, :topic => "topic", :channel => "channel"})
    end

    it "should raise an exception if max_in_flight is above what the server supports" do
      expect_raises(Exception) do
        Nsq::Connection.new({:host => "localhost", :port => 4150, :max_in_flight => 1_000_000, :topic => "topic", :channel => "channel"})
      end
    end

    # %w(tls_options ssl_context).map(&:to_sym).each do |tls_options_key|
    #   context "when #{tls_options_key} is provided" do
    #     it "validates when tls_v1 is true" do
    #       params = {
    #         host: @nsqd.host,
    #         port: @nsqd.tcp_port,
    #         tls_v1: true
    #       }
    #       params[tls_options_key] = {
    #         certificate: "blank"
    #       }

    #       expect{
    #         Nsq::Connection.new(params)
    #       }.to raise_error ArgumentError, /key/
    #     end
    #     it "skips validation when tls_v1 is false" do
    #       params = {
    #         host: @nsqd.host,
    #         port: @nsqd.tcp_port,
    #         tls_v1: false
    #       }
    #       params[tls_options_key] = {
    #         certificate: "blank"
    #       }

    #       expect{
    #         Nsq::Connection.new(params)
    #       }.not_to raise_error
    #     end
    #     it "raises when a key is not provided" do
    #       params = {
    #         host: @nsqd.host,
    #         port: @nsqd.tcp_port,
    #         tls_v1: true
    #       }
    #       params[tls_options_key] = {
    #         certificate: "blank"
    #       }

    #       expect{
    #         Nsq::Connection.new(params)
    #       }.to raise_error ArgumentError, /key/
    #     end

    #     it "raises when a certificate is not provided" do
    #       params = {
    #         host: @nsqd.host,
    #         port: @nsqd.tcp_port,
    #         tls_v1: true
    #       }
    #       params[tls_options_key] = {
    #         key: "blank"
    #       }

    #       expect{
    #         Nsq::Connection.new(params)
    #       }.to raise_error ArgumentError, /certificate/
    #     end

    #     it "raises when the key or cert files are not readable" do
    #       params = {
    #         host: @nsqd.host,
    #         port: @nsqd.tcp_port,
    #         tls_v1: true
    #       }
    #       params[tls_options_key] = {
    #         key: "blank",
    #         certificate: "blank"
    #       }

    #       expect{
    #         Nsq::Connection.new(params)
    #       }.to raise_error LoadError, /unreadable/
    #     end
    #   end
    # end
  end

  describe "#close" do
    it "can be called multiple times, without issue" do
      connection = Nsq::Connection.new({:host => "localhost", :port => 4150})
      connection.close
      connection.close
      connection.close
    end
    # we should
    # it "can be called multiple times, without issue" do
    #   connection = Nsq::Connection.new({:host =>  "localhost", :port =>  4150, :topic => "topic", :channel => "channel"})
    #   connection.close
    #   connection.close
    #   connection.close
    # end
  end

  # This is really testing the ability for Connection to reconnect
  describe "#connected?" do
    # before do
    #   # For speedier timeouts
    #   set_speedy_connection_timeouts!
    # end

    it "should return true when nsqd is up and false when nsqd is down" do
      # wait_for{@connection.connected?}
      # expect(@connection.connected?).to eq(true)
      # @nsqd.stop
      # wait_for{!@connection.connected?}
      # expect(@connection.connected?).to eq(false)
      # @nsqd.start
      # wait_for{@connection.connected?}
      # expect(@connection.connected?).to eq(true)
    end
  end

  # describe "private methods" do
  #  describe "#frame_class_for_type" do
  #    MAX_VALID_TYPE = described_class::FRAME_CLASSES.length - 1
  #    it "returns a frame class for types 0-#{MAX_VALID_TYPE}" do
  #      (0..MAX_VALID_TYPE).each do |type|
  #        expect(
  #          described_class::FRAME_CLASSES.include?(
  #            @connection.send(:frame_class_for_type, type)
  #          )
  #        ).to be_truthy
  #      end
  #    end
  #    it "raises an error if invalid type > #{MAX_VALID_TYPE} specified" do
  #      expect {
  #        @connection.send(:frame_class_for_type, 3)
  #      }.to raise_error(RuntimeError)
  #    end
  #  end
  #
  #
  #  describe "#handle_response" do
  #    it "responds to heartbeat with NOP" do
  #      frame = Nsq::Response.new(described_class::RESPONSE_HEARTBEAT, @connection)
  #      expect(@connection).to receive(:nop)
  #      @connection.send(:handle_response, frame)
  #    end
  #  end
  # end
end
