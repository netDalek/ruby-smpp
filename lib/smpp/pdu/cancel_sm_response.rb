class Smpp::Pdu::CancelSmResponse < Smpp::Pdu::Base
  handles_cmd CANCEL_SM_RESP

  def initialize(seq, status)
    seq ||= next_sequence_number
    super(CANCEL_SM_RESP, status, seq)
  end

  def self.from_wire_data(seq, status, body)
    new(seq, status)
  end
end
