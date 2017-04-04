#! /bin/bash

KEY_LOCATION=~/Development/Keys/Garmin.der

# Replace with your tested application folder
APP_DIR=./ProgBarWatchApplication
GARMIN_HOME=$HOME/SDKs/Garmin-ConnectIQ/connectiq-sdk-win-2.2.4

# Keep this script located in the Tests folder
TEST_DIR=./ProgBarWatchTests
RESULT_DIR=$TEST_DIR/TestResults

echo "====Running the unit tests===="

# Get current date and time for the result file name
DATETIME=$(date +"%Y-%m-%d_%H-%M-%S")


echo "Start your horses"

$(connectiq)&

# This building process should be more automated...

java -Dfile.encoding=UTF-8 -Dapple.awt.UIElement=true -jar \
"$GARMIN_HOME/bin/monkeybrains.jar"\
 -t -o "$TEST_DIR/bin/ProgBarWatchTests.prg" \
 -w -y $KEY_LOCATION -m "$TEST_DIR/manifest.xml" \
 -z "$APP_DIR/resources/drawables/drawables.xml":\
"$APP_DIR/resources/layouts/layout.xml":\
"$APP_DIR/resources/settings/properties.xml":\
"$APP_DIR/resources/settings/settings.xml":\
"$APP_DIR/resources/strings/strings.xml":\
"$APP_DIR/resources-ces/strings/strings.xml":\
"$APP_DIR/resources-deu/strings/strings.xml"\
 "$TEST_DIR/source/ProgBarWatchViewMock.mc"\
 "$TEST_DIR/source/ProgBarWatchTestsApp.mc"\
 "$TEST_DIR/Tests/DateTimeUtility/DateTimeUtilityTests.mc"\
 "$TEST_DIR/Tests/ProgressBar/ProgressBarTests.mc"\
 "$TEST_DIR/Tests/ProgressBar/DrawingContextMock.mc"\
 "$TEST_DIR/Tests/ActivityUtility/ActivityUtilityTests.mc"\
 "$TEST_DIR/Tests/ActivityUtility/ActivityInfoMock.mc"  \
 "$APP_DIR/source/utility/SystemUtility.mc"\
 "$APP_DIR/source/utility/DateTimeUtility.mc"\
 "$APP_DIR/source/utility/ActivityUtility.mc"\
 "$APP_DIR/source/ProgBarWatchView.mc"\
 "$APP_DIR/source/drawables/ProgressBar.mc"\
 "$APP_DIR/source/exceptions/InvalidValueException.mc"

# Here it should be checked if the build was successful before running the tests...

echo "Do the monkey business..."

if !(test -e $RESULT_DIR)
then
    mkdir $RESULT_DIR
fi

$(monkeydo "$TEST_DIR/bin/ProgBarWatchTests.prg" -t) > "$RESULT_DIR/TestResult_$DATETIME.txt"
echo "Tests done, see the results..."


