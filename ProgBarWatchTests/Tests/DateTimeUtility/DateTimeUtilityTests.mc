using DateTimeUtility as Dut;

module DateTimeUtilityTests{
    hidden const LEAP_YEAR = 2016;
    hidden const NON_LEAP_YEAR = 2011;

    //! Test if the input year is correctly evaluated as leap year
    (:test)
    function testLeapYear(logger){
        return Dut.isLeapYear(LEAP_YEAR);
    }

    //! Test if the input year is correctly evaluated as non-leap year
    (:test)
    function testNonLeapYear(logger){
        return !Dut.isLeapYear(NON_LEAP_YEAR);
    }

    //! Wrong argument type in the leap year testing method should throw an exception
    (:test)
    function testInvalidLeapYearArgument(logger){
        try{
            Dut.isLeapYear("Wrong argument...");
        } catch (ex) {
            if(ex instanceof UnexpectedTypeException){
                return true;
            }
        }

        return false;
    }


}