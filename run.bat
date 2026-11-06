@echo off
setlocal
cd /d "%~dp0"

if defined JAVA_HOME if exist "%JAVA_HOME%\bin\javac.exe" (
  set "JAVAC=%JAVA_HOME%\bin\javac.exe"
  set "JAVA=%JAVA_HOME%\bin\java.exe"
)
if not defined JAVAC (
  for /d %%D in ("%ProgramFiles%\Java\jdk-*") do (
    if exist "%%~fD\bin\javac.exe" (
      set "JAVAC=%%~fD\bin\javac.exe"
      set "JAVA=%%~fD\bin\java.exe"
    )
  )
)
if not defined JAVAC if exist "%ProgramFiles%\Java\latest\bin\javac.exe" (
  set "JAVAC=%ProgramFiles%\Java\latest\bin\javac.exe"
  set "JAVA=%ProgramFiles%\Java\latest\bin\java.exe"
)
if not defined JAVAC (
  set "JAVAC=javac"
  set "JAVA=java"
)

"%JAVAC%" -version >nul 2>nul
if errorlevel 1 (
  echo Java JDK not found. Install JDK 17 or newer and add its bin folder to PATH.
  exit /b 1
)
if not exist out mkdir out
dir /s /b src\*.java > sources.txt
"%JAVAC%" -encoding UTF-8 -d out @sources.txt
if errorlevel 1 (
  echo Compilation failed. Review the errors above.
  del sources.txt 2>nul
  exit /b 1
)
del sources.txt 2>nul
"%JAVA%" -cp out aistudyplanner.Main
exit /b %errorlevel%
