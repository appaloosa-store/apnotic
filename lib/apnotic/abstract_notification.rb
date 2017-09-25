# frozen_string_literal: true

require 'securerandom'
require 'json'

module Apnotic
  class AbstractNotification
    attr_reader :token
    attr_accessor :apns_id,
                  :expiration,
                  :priority,
                  :topic,
                  :apns_collapse_id,
                  :authorization

    def initialize(token)
      @token   = token
      @apns_id = SecureRandom.uuid
    end

    def body
      JSON.dump(to_hash).force_encoding(Encoding::BINARY)
    end

    def authorization_header
      authorization ? "bearer #{authorization}" : nil
    end

    private

    def aps
      {}
    end

    def to_hash
      { aps: aps }
    end
  end
end
