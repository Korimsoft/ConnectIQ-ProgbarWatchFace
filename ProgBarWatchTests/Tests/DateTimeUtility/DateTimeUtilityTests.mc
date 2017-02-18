using DateTimeUtility as Dut;

module DateTimeUtilityTests{
    hidden const LEAP_YEAR = 2016;
    hidden const NON_LEAP_YEAR = 2011;

    (:test)
    function testLeapYear(logger){
        return Dut.isLeapYear(LEAP_YEAR);
    }

    (:test)
    function testNonLeapYear(logger){
        return !Dut.isLeapYear(NON_LEAP_YEAR);
    }

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