class UsernamePasswordValidator < ActiveModel::Validator
  def validate(record)
    unless record.user && record.password == "password"
      record.errors[:base] = "Username and/or Password are wrong."
    end
  end
end