using DateTimeUtility as Dut;
using Toybox.Time;
using Toybox.System;

//! Tests for DateTimeUtility functions. They use Time.FORMAT_SHORT as reference output since only this format is currently used
//! in the project.
module DateTimeUtilityTests{
    hidden const DEFAULT_YEAR = 2016;
    hidden const DEFAULT_MONTH = FEBRUARY;
    hidden const DEFAULT_DAY = 14;

    hidden const DEFAULT_HOUR = 13;
    hidden const DEFAULT_MINUTE = 37;
    hidden const DEFAULT_SECOND = 42;

    hidden const LEAP_YEAR = DEFAULT_YEAR;
    hidden const NON_LEAP_YEAR = 2011;

    hidden const FEBRUARY=2;

	// For testing the moment setting
    hidden const DEFAULT_OPTIONS = {
        :year=>DEFAULT_YEAR,
        :month=>DEFAULT_MONTH,
        :day=>DEFAULT_DAY,
        :hour=>DEFAULT_HOUR,
        :minute=>DEFAULT_MINUTE,
        :second=>DEFAULT_SECOND};

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

        var days = Dut.getDaysPerMonth(FEBRUARY, LEAP_YEAR);
        logger.debug("Days expected: 29, returned:" + days);
        return days == 29;
    }

    //! February on non-leap year has 28 days
    (:test)
    function testDaysPerFebruaryNonLeap(logger){
        var days = Dut.getDaysPerMonth(FEBRUARY, NON_LEAP_YEAR);
        logger.debug("Days expected: 28, returned:" + days);
        return days == 28;
    }

    //! Attempting to pass a month with number lower than 1 should result in Exception.
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

    //! Attempting to pass a month with number higher than 12 should result in an Exception,
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

	//! Test setting up a moment
    (:test)
    function testMoment(logger){

		// moment takes time in UTC as an argument,
		// DateTimeUtility returns local time however
		// For the test, the returned values must be corrected.
		// ClockTime.timeZoneOffset is in seconds
		var timeZoneOffset = Toybox.System.getClockTime().timeZoneOffset/3600;
		
        Dut.moment(DEFAULT_OPTIONS);

        var year = Dut.getCurrentYear();
        var month = Dut.getCurrentMonth();
        var day = Dut.getCurrentDay();
        var hour = Dut.getCurrentHour();
        var min = Dut.getCurrentMinute();
        var sec = Dut.getCurrentSecond();
        
        logger.debug("Original values (UTC): "
        	+ DEFAULT_OPTIONS[:year] + "-" 
        	+ DEFAULT_OPTIONS[:month] + "-" 
        	+ DEFAULT_OPTIONS[:day] + " "
        	+ DEFAULT_OPTIONS[:hour] + ":"
        	+ DEFAULT_OPTIONS[:minute] + ":"
        	+ DEFAULT_OPTIONS[:second] 
        );
        
        logger.debug("Retrieved values (local time): " 
        	+ year + "-" 
        	+ month + "-" 
        	+ day + " "
        	+ hour + ":"
        	+ min + ":"
        	+ sec + " offset: " + timeZoneOffset);
		
        var yearMatch = (year == DEFAULT_OPTIONS[:year]);
        var monthMatch = (month == DEFAULT_OPTIONS[:month]);
        var dayMatch = (day == DEFAULT_OPTIONS[:day]); 
        var hourMatch = (hour == DEFAULT_OPTIONS[:hour] + timeZoneOffset);
        var minuteMatch = (min == DEFAULT_OPTIONS[:minute]);
        var secondMatch = (sec == DEFAULT_OPTIONS[:second]);

        return yearMatch &&
            monthMatch &&
            dayMatch &&
            hourMatch &&
            minuteMatch && 
            secondMatch;
    }

	//! Invalid value should throw an UnexpectedTypeException.
	//! This test should prevent the situation when the behavior changes and
	//! a nonsense date/time value is set instead of crashing. 
    (:test)
    function testMomentInvalidValue(logger){
    	var invalidOptions={:hour=>"SOMETHING SOMETHING!!!"};
    	try{
			Dut.moment(invalidOptions);
		}
		catch(exception){
			if(exception instanceof Toybox.Lang.UnexpectedTypeException){
				logger.debug("Correct exception thrown");
				return true;
			} else {
				logger.warning("Unexpected exception caught");
				return false;
			}
			
		}
		
		logger.warning("No exception caught! Expected an UnexpectedTypeException!");
		return false;
    }


}