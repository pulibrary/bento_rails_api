# frozen_string_literal: true

# This class is responsible for querying the Summon API, aka "Articles+"
class SummonApi
  include ActiveModel::API
  include Parsed
  attr_reader :query_terms, :service

  delegate :documents, to: :service_response

  def initialize(query_terms:)
    @query_terms = query_terms
    summon_config = Rails.application.config_for(:allsearch)[:summon]
    @service = Summon::Service.new(access_id: summon_config[:access_id],
                                   secret_key: summon_config[:secret_key])
  end

  def service_response
    service.search('s.q' => query_terms, 's.fvf' => 'ContentType,Book')
  end

  def number
    service_response.record_count
  end

  def more_link
    URI::HTTPS.build(host: 'princeton.summon.serialssolutions.com', path: '/search',
                     query: service_response.query.query_string)
  end
end
