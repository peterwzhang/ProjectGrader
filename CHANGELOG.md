# Changelog
## **3/12/21**  
- First Release
## **4/16/21**
- "GradingScriptNT.sh" and "GradingScriptNTP.sh" are no longer maintained.
- An option to ignore whitespace when checking outputs is added to "GradingScript.sh" and "GradingScriptP.sh".
- The example has been updated to show the ignore whitespace feature.

## **6/17/21**
- "GradingScriptP.sh" has been removed, but the functionality is now the default in "GradingScript.sh".
- "GradingScriptNT.sh" and "GradingScriptNTP.sh" have been removed from the current repository.
- "GradingScript.sh" will now read from "grading_config.ini" if one exists in the current directory.
- "GradingScript.sh" can now rerun grading without restarting the script.
- "GradingScript.sh" can clean the most recent files it makes before quitting, if wanted.
- "GradingScript.sh" grading has been reworked to handle some extreme cases better (negative grades).
- The example provided has been updated to show the features of this update (config file).
- The license of the repository has been changed to MIT for this release and all future updates.