@ECHO OFF
REM Some variables
SET "EMBEDDED_DIR=%~dp0\..\embedded"

REM Save some variables we're going to change so we can restore them later
SET "VAGRANT_GEM_HOME_SAVED=%GEM_HOME%"
SET "VAGRANT_GEM_PATH_SAVED=%GEM_PATH%"
SET "VAGRANT_GEMRC_SAVED=%GEMRC%"
SET "VAGRANT_PATH_SAVED=%PATH%"
SET "VAGRANT_RUBYOPT_SAVED=%RUBYOPT%"

REM Set environmental variables
SET "GEM_HOME=%EMBEDDED_DIR%\gems"
SET "GEM_PATH=%GEM_HOME%"
SET "GEMRC=%EMBEDDED_DIR%\etc\gemrc"

REM Export an enviromental variable to say we're in a Vagrant
REM installer created environment.
SET "VAGRANT_INSTALLER_ENV=1"
SET "VAGRANT_INSTALLER_EMBEDDED_DIR=%EMBEDDED_DIR%"
SET "VAGRANT_INSTALLER_VERSION=2"

REM Prepend embedded bin to PATH so we prefer those binaries
SET "PATH=%EMBEDDED_DIR%\bin;%EMBEDDED_DIR%\gnuwin32\bin;%PATH%"

REM Remove RUBYOPT, which causes serious problems.
SET RUBYOPT=

REM Run Vagrant...
"%EMBEDDED_DIR%\..\embedded\bin\ruby.exe" "%EMBEDDED_DIR%/../embedded/gems/bin/%~n0" %*

REM Store the exit status so we can re-use it later
SET "VAGRANT_EXIT_STATUS=%ERRORLEVEL%"

REM Restore some environmental variables we changed
SET "GEM_HOME=%VAGRANT_GEM_HOME_SAVED%"
SET "GEM_PATH=%VAGRANT_GEM_PATH_SAVED%"
SET "GEMRC=%VAGRANT_GEMRC_SAVED%"
SET "PATH=%VAGRANT_PATH_SAVED%"
SET "RUBYOPT=%VAGRANT_RUBYOPT_SAVED%"

REM Exit with the proper exit status from Vagrant
exit /b %VAGRANT_EXIT_STATUS%
