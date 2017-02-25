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
            if(ex instanceof Toybox.Lang.UnexpectedTypeException){
                return true;
            }
        }

        return false;
    }

    //! February on leap year has 29 days
    (:test)
    function testDaysPerFebruaryLeap(logger){
        var days = Dut.getDaysPerMonth(2, LEAP_YEAR);
        logger.debug("Days expected: 29, returned:" + days);
        return days == 29;
    }

    //! February on non-leap year has 28 days
    (:test)
    function testDaysPerFebruaryNonLeap(logger){
        var days = Dut.getDaysPerMonth(2, NON_LEAP_YEAR);
        logger.debug("Days expected: 28, returned:" + days);
        return days == 28;
    }

    (:test)
    function testIrrelevantmonthInputLow(logger){
        try{
            Dut.getDaysPerMonth(-1, NON_LEAP_YEAR);
        }
        catch (ex){
            if (ex instanceof InvalidValueException){
                return true;
            }
        }

        return false;
    }

    (:test)
    function testIrrelevantmonthInputHigh(logger){
        try{
            Dut.getDaysPerMonth(13, NON_LEAP_YEAR);
        }
        catch (ex){
            if (ex instanceof InvalidValueException){
                return true;
            }
        }

        return false;
    }

    //! Wrong input type throws an UnexpectedTypeException
    (:test)
    function testIrrelevantYearInput(logger){
        try{
            Dut.getDaysPerMonth(1, "hello");
        }
        catch (ex){
            
           if(ex instanceof Toybox.Lang.UnexpectedTypeException){
                logger.debug("Expected exception caught");
                logger.debug(ex.getErrorMessage());
                return true;
            } else {
                logger.warning("Different exception thrown!");
                logger.error(ex.printStackTrace());
                return false;
            }
        }
        logger.error("No expception thrown, that should not have happened!");
        return false;
    }

}