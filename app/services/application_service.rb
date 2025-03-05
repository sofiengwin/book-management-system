class ApplicationService
  def self.call(**kwargs)
    new(**kwargs).call
  rescue ActiveRecord::RecordInvalid => e
    OpenStruct.new(success?: false, error: "Validation failed: #{e.message}")
  end

  private

  def success(value)
    OpenStruct.new(success?: true, value: value)
  end

  def failure(error)
    OpenStruct.new(success?: false, error: error)
  end
end
