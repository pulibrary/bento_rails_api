# frozen_string_literal: true

class Document
  def initialize(json:, doc_keys:)
    @json = json
    @doc_keys = doc_keys
  end

  def to_h
    doc_hash = {}
    @doc_keys.each do |key|
      val = send(key)
      doc_hash[key] = val if val
    end
    doc_hash
  end

  private

  def other_fields
    doc_keys&.index_with { |key| send(key) }
  end
end
