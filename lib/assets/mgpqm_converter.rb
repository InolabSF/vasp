IGNORE_LIST = ['N/A', 'n/a', 'none']

# CO

CO_MOLECULAR_MASS = 28.01

CO_MAX_PPM_VALUE = 10000.0    #ppm
CO_MIN_PPM_VALUE = 0.0


# SO2

SO2_MOLECULAR_MASS = 64.066

TC_SO2 = 0.01
TIA_SO2 = 100
VREF_SO2 = 1.2
VOFFSET_SO2 = 0.2


# Ozone_S

OZONE_S_MOLECULAR_MASS = 48

OZONE_RL = 910
OZONE_R0 = 4500

OZONE_MAX_PPM_VALUE = 1000.0

TC_O3 = 0.01
TIA_O3 = 499
VREF_O3 = 1.2
VOFFSET_O3 = 0.2


# UV
UVI_THD_MV = [
  0.050,
  0.227,
  0.318,
  0.408,
  0.503,
  0.606,
  0.696,
  0.795,
  0.881,
  0.976,
  1.079
]


# MGQMConverter
class MGQMConverter

  # initialize
  def initialize(sensitivity_code_so2, sensitivity_code_ozone_s)
    @sensitivity_code_so2 = sensitivity_code_so2
    @sensitivity_code_ozone_s = sensitivity_code_ozone_s
  end

  # convert co
  def convert_co(adval, temp)
    adval = float_or_nil(adval)
    return 0.0 unless adval

    res = (adval == 0) ? CO_MAX_PPM_VALUE : 10.0 ** (2.0 - Math.log(1024.0/adval - 1, 5))

    ppm_to_mgqm(res, CO_MOLECULAR_MASS, temp)
  end

  # convert so2
  def convert_so2(adval, temp)
    adval = float_or_nil(adval)
    return 0.0 unless adval

    code = @sensitivity_code_so2
    m = code * TIA_SO2 * 10 ** (-6)
    mc = m * (1 + TC_SO2 * (20 - temp))
    return 0.0 if mc == 0
    vgas = adval / 1024 * 3.3
    c = 1/mc * (vgas - VREF_SO2 - VOFFSET_SO2)

    ppm_to_mgqm(c, SO2_MOLECULAR_MASS, temp)
  end

  # convert ozone_s
  def convert_ozone_s(adval, temp)
    adval = float_or_nil(adval)
    return 0.0 unless adval

    code = @sensitivity_code_ozone_s
    m = code * TIA_O3 * 10 ** (-6)
    mc = m * (1 + TC_O3 * (20 - temp))
    return 0.0 if mc == 0
    vgas = adval / 1024 * 3.3
    c = 1/mc * (vgas - VREF_O3 - VOFFSET_O3)

    ppm_to_mgqm(c, OZONE_S_MOLECULAR_MASS, temp)
  end

  # convert uv
  def convert_uv(analog_value)
    analog_value = float_or_nil(analog_value)
    return 0.0 unless analog_value
    value = analog_value / 1024.0 * 3.3

    uvi = UVI_THD_MV.length
    UVI_THD_MV.each_with_index do |thd, index|
      uvi = index; break if value < thd
    end

    uvi
  end

  # convert ppm to mgqm
  def ppm_to_mgqm(ppm, molecular_mass, temp)
    molar_volume_of_air = (273.0 + temp) / 273.0 * 22.4
    return 0.0 if molar_volume_of_air == 0

    # ppm * 1000.0 * molecular_mass / molar_volume_of_air
    ppm * molecular_mass / molar_volume_of_air
  end

  # get float or nil from string
  def float_or_nil(str)
    return nil if IGNORE_LIST.include?(str)
    return nil if str == -1
    Float(str || '')
  rescue ArgumentError
    nil
  end

end


#sensitivity_code_so2 = 30.0
#sensitivity_code_ozone_s = 17.55
#co = 95
#so2 = 547.0
#ozone_s = 508.6
#uv = 2.0
#temp = 27.2
#
#converter = MGQMConverter.new(sensitivity_code_so2, sensitivity_code_ozone_s)
#puts converter.convert_co(co, temp)
#puts converter.convert_so2(so2, temp)
#puts converter.convert_ozone_s(ozone_s, temp)
#puts converter.convert_uv(uv)
