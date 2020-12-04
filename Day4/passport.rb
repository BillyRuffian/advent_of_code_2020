class Passport
  attr_accessor :byr, :iyr, :eyr, :hgt, :hcl, 
                :ecl, :pid, :cid
  
  def valid?
    byr && iyr && eyr && hgt && hcl && ecl && pid
  end
end

class Passport2 < Passport
  def byr=(value)
    @byr = value[/^\d{4}$/]&.to_i&.then { (1920..2002).include?(_1) ? _1 : nil }
  end

  def iyr=(value)
    @iyr = value[/^\d{4}$/]&.to_i&.then { (2010..2020).include?(_1) ? _1 : nil }
  end

  def eyr=(value)
    @eyr = value[/^\d{4}$/]&.to_i&.then { (2020..2030).include?(_1) ? _1 : nil }
  end

  def hgt=(value)
    measure, units = /^(\d+)(in|cm)$/.match(value)&.captures
    @hgt = if units == 'cm'
             measure[/^\d+$/]&.to_i&.then { (150..193).include?(_1) ? value : nil }
           elsif units == 'in'
             measure[/^\d+$/]&.to_i&.then { (59..76).include?(_1) ? value : nil }
           else
             nil
           end
  end

  def hcl=(value)
    @hcl = value[/^#[0-9a-f]{6}$/]
  end

  def ecl=(value)
    @ecl = value if %w[amb blu brn gry grn hzl oth].include?(value)
  end

  def pid=(value)
    @pid = value[/^\d{9}$/]
  end
end