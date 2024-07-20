package torchsfunctions.functions;

class MathTools {
    /**
    Returns the midpoint between 2 numbers. Can be useful for X or Y positions.

    @param val1 The initial number
    @param val2 The second number
	**/
    public static function midpoint(val1:Float, val2:Float) {
        return (val1 + val2) / 2;
    }
    /**
		Returns a decimal where the `baseValue` is divided by the `denominator`, in a sense splitting it like a fraction.
        Optionally, you can add the `numerator` value to increate the fraction you get back, ex 2/3 instead of 1/3.

        @param baseValue The value you want divided
        @param denominator The amount to divide by
        @param numerator How many pieces of the fraction you want
	**/
    public static function fractionAmount(baseValue:Float, denominator:Float, ?numerator:Float = 1) {
        return (baseValue / denominator) * numerator;
    }
}