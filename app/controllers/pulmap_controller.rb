# frozen_string_literal: true

class PulmapController < ServiceController
  rescue_from ActionController::ParameterMissing, with: :show_query_errors

  def initialize
    super
    @service = Pulmap
  end
end
