{ Chrono test runner (DUnitX console).
  Builds for Win32, Win64 and Linux64. Exit code is non-zero if any test fails.
  Run with --help to see the DUnitX command line options (filters, XML output, ...). }
program ChronoTests;

{$APPTYPE CONSOLE}
{$STRONGLINKTYPES ON}

uses
  System.SysUtils,
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  ChronoTypes in '..\Source\ChronoTypes.pas',
  ChronoTypes.Russian in '..\Source\ChronoTypes.Russian.pas',
  ChronoTypes.Ukrainian in '..\Source\ChronoTypes.Ukrainian.pas',
  ChronoTypes.Belarusian in '..\Source\ChronoTypes.Belarusian.pas',
  ChronoTypes.Polish in '..\Source\ChronoTypes.Polish.pas',
  ChronoTypes.Czech in '..\Source\ChronoTypes.Czech.pas',
  ChronoTypes.German in '..\Source\ChronoTypes.German.pas',
  ChronoTypes.French in '..\Source\ChronoTypes.French.pas',
  ChronoTypes.Italian in '..\Source\ChronoTypes.Italian.pas',
  ChronoTypes.Spanish in '..\Source\ChronoTypes.Spanish.pas',
  ChronoTypes.Portuguese in '..\Source\ChronoTypes.Portuguese.pas',
  ChronoTypes.Dutch in '..\Source\ChronoTypes.Dutch.pas',
  ChronoTypes.Danish in '..\Source\ChronoTypes.Danish.pas',
  ChronoTypes.Swedish in '..\Source\ChronoTypes.Swedish.pas',
  ChronoTypes.Tests in 'ChronoTypes.Tests.pas';

var
  Runner: ITestRunner;
  Results: IRunResults;
begin
  try
    TDUnitX.CheckCommandLine;
    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;
    Runner.FailsOnNoAsserts := False;
    Runner.AddLogger(TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet));
    if TDUnitX.Options.XMLOutputFile <> '' then
      Runner.AddLogger(TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile));

    Results := Runner.Execute;
    if not Results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done. Press <Enter> to quit.');
      System.Readln;
    end;
  except
    on E: Exception do
    begin
      System.Writeln(E.ClassName, ': ', E.Message);
      System.ExitCode := EXIT_ERRORS;
    end;
  end;
end.
