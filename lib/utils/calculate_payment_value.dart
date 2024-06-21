double getAllRisksPaymentValue(int yearOfMake, double carValue) {
  double allRisksMinValue = 465.0;
  double rate = 0.0;

  if (carValue < 25000) {
    if (yearOfMake >= 2021) {
      rate = 0.0265;
    } else if (yearOfMake >= 2017) {
      rate = 0.0285;
    } else if (yearOfMake >= 2013) {
      rate = 0.029;
    } else if (yearOfMake >= 2000) {
      rate = 0.03;
    }
  } else if (carValue >= 25001) {
    if (yearOfMake >= 2021) {
      rate = 0.026;
    } else if (yearOfMake >= 2017) {
      rate = 0.0275;
    } else if (yearOfMake >= 2013) {
      rate = 0.0285;
    } else if (yearOfMake >= 2000) {
      rate = 0.0295;
    }
  }

  double value = carValue * rate;
  return rate > 0 && value <= allRisksMinValue
      ? allRisksMinValue
      : value.ceilToDouble() + 10;
}

double getAllRisksPlusPaymentValue(int yearOfMake, double carValue) {
  double allRisksPlusMinValue = (yearOfMake >= 2021) ? 665.0 : 565.0;
  double rate = 0.0;

  if (carValue < 25000) {
    if (yearOfMake >= 2021) {
      rate = 0.0275;
    } else if (yearOfMake >= 2017) {
      rate = 0.0295;
    } else if (yearOfMake >= 2013) {
      rate = 0.0325;
    } else if (yearOfMake >= 2000) {
      rate = 0.0345;
    }
  } else if (carValue <= 50000) {
    if (yearOfMake >= 2021) {
      rate = 0.027;
    } else if (yearOfMake >= 2017) {
      rate = 0.029;
    } else if (yearOfMake >= 2013) {
      rate = 0.031;
    } else if (yearOfMake >= 2000) {
      rate = 0.035;
    }
  } else if (carValue <= 100000) {
    if (yearOfMake >= 2021) {
      rate = 0.025;
    } else if (yearOfMake >= 2017) {
      rate = 0.0265;
    } else if (yearOfMake >= 2013) {
      rate = 0.028;
    } else if (yearOfMake >= 2000) {
      rate = 0.03;
    }
  } else if (carValue <= 200000) {
    if (yearOfMake >= 2021) {
      rate = 0.024;
    } else if (yearOfMake >= 2017) {
      rate = 0.0255;
    } else if (yearOfMake >= 2013) {
      rate = 0.027;
    } else if (yearOfMake >= 2000) {
      rate = 0.0285;
    }
  }

  double value = carValue * rate;
  return (rate > 0 && value <= allRisksPlusMinValue)
      ? allRisksPlusMinValue
      : value.ceilToDouble() + 10;
}
