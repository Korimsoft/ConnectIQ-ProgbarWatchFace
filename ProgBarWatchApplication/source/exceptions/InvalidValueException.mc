class InvalidValueException extends Toybox.Lang.Exception{
    hidden var message = null;

    function initialize(errorMessage){
        Toybox.Lang.Exception.initialize();
        me.message = errorMessage;
    }

    function getErrorMessage(){
        return me.message;
    }
}