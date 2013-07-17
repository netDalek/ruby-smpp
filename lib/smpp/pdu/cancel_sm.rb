# Sending an MT message
class Smpp::Pdu::CancelSm < Smpp::Pdu::Base
  handles_cmd CANCEL_SM
  attr_reader :service_type, :message_id, :source_addr_ton, :source_addr_npi, :source_addr,
              :dest_addr_ton, :dest_addr_npi, :destination_addr

  def initialize(message_id, source_addr, destination_addr, options={}, seq = nil)
    @service_type            = options[:service_type]? options[:service_type] :''
    @message_id              = message_id
    @source_addr_ton         = options[:source_addr_ton]?options[:source_addr_ton]:0 # network specific
    @source_addr_npi         = options[:source_addr_npi]?options[:source_addr_npi]:1 # unknown
    @source_addr             = source_addr
    @dest_addr_ton           = options[:dest_addr_ton]?options[:dest_addr_ton]:1 # international
    @dest_addr_npi           = options[:dest_addr_npi]?options[:dest_addr_npi]:1 # unknown 
    @destination_addr        = destination_addr

    # craft the string/byte buffer
    pdu_body = sprintf("%s\0%s\0%c%c%s\0%c%c%s\0", @service_type, @message_id, @source_addr_ton, @source_addr_npi, @source_addr,
      @dest_addr_ton, @dest_addr_npi, @destination_addr)

    seq ||= next_sequence_number

    super(CANCEL_SM, 0, seq, pdu_body)
  end
end
