class FirstStep < Forminator::Step
  validations do
    required(:email) { filled? }
    required(:name) { filled? }
  end

  def persist?
    true
  end
end

class SecondStep < Forminator::Step
  validations do
    required(:address) { filled? }
    required(:description) { filled? }
  end

  def persist?
    true
  end
end
