module ModelHelper
  # Class Methods
  def presence_with_question_mark(methods)
    methods.each do |method|
      define_method("#{method}?") do
        send(method).present?
      end
    end
  end
end
