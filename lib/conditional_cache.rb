module ConditionalCache
  class CacheKey
    attr_reader :models

    def initialize models
      @models = models
    end

    def updated_at
      DateTime.parse(latest_updated_at)
    end

    private

    def latest_updated_at
      result = ActiveRecord::Base.connection.execute(query)
      result[0]["last_updated_at"]
    end

    def query
      "SELECT MAX(updated_at) as last_updated_at from (#{sub_query}) tabl"
    end

    def sub_query
      models.map do |model|
      "SELECT updated_at from #{model.to_s.classify.constantize.table_name}"
      end.join(" UNION ")
    end

  end

  private

  def conditional_get *models
    raise "atleast one model must exist(usage: if_none_match :model_name1, :model_name2)" if models.empty?
    fresh_when cache_key(models), strong_etag: "#{current_user.id} #{request.url} #{request.request_parameters.to_s}"
  end


  def cache_key models
    obj = CacheKey.new models
    return obj
  end
end
