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

class ThirdStep < Forminator::Step
  validations do
    required(:card_number) { filled? }
  end

  def persist?
    true
  end
end

class BogusStep < Object
  
end
