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
  ChronoTypes.Chinese in '..\Source\ChronoTypes.Chinese.pas',
  ChronoTypes.Hindi in '..\Source\ChronoTypes.Hindi.pas',
  ChronoTypes.Arabic in '..\Source\ChronoTypes.Arabic.pas',
  ChronoTypes.Bengali in '..\Source\ChronoTypes.Bengali.pas',
  ChronoTypes.Japanese in '..\Source\ChronoTypes.Japanese.pas',
  ChronoTypes.Turkish in '..\Source\ChronoTypes.Turkish.pas',
  ChronoTypes.Korean in '..\Source\ChronoTypes.Korean.pas',
  ChronoTypes.Vietnamese in '..\Source\ChronoTypes.Vietnamese.pas',
  ChronoTypes.Indonesian in '..\Source\ChronoTypes.Indonesian.pas',
  ChronoTypes.Persian in '..\Source\ChronoTypes.Persian.pas',
  ChronoTypes.Urdu in '..\Source\ChronoTypes.Urdu.pas',
  ChronoTypes.Romanian in '..\Source\ChronoTypes.Romanian.pas',
  ChronoTypes.Hungarian in '..\Source\ChronoTypes.Hungarian.pas',
  ChronoTypes.Greek in '..\Source\ChronoTypes.Greek.pas',
  ChronoTypes.Finnish in '..\Source\ChronoTypes.Finnish.pas',
  ChronoTypes.Norwegian in '..\Source\ChronoTypes.Norwegian.pas',
  ChronoTypes.Slovak in '..\Source\ChronoTypes.Slovak.pas',
  ChronoTypes.Bulgarian in '..\Source\ChronoTypes.Bulgarian.pas',
  ChronoTypes.Serbian in '..\Source\ChronoTypes.Serbian.pas',
  ChronoTypes.Croatian in '..\Source\ChronoTypes.Croatian.pas',
  ChronoTypes.Lithuanian in '..\Source\ChronoTypes.Lithuanian.pas',
  ChronoTypes.Latvian in '..\Source\ChronoTypes.Latvian.pas',
  ChronoTypes.Estonian in '..\Source\ChronoTypes.Estonian.pas',
  ChronoTypes.Slovenian in '..\Source\ChronoTypes.Slovenian.pas',
  ChronoTypes.Catalan in '..\Source\ChronoTypes.Catalan.pas',
  ChronoTypes.Kazakh in '..\Source\ChronoTypes.Kazakh.pas',
  ChronoTypes.Uzbek in '..\Source\ChronoTypes.Uzbek.pas',
  ChronoTypes.Azerbaijani in '..\Source\ChronoTypes.Azerbaijani.pas',
  ChronoTypes.Georgian in '..\Source\ChronoTypes.Georgian.pas',
  ChronoTypes.Armenian in '..\Source\ChronoTypes.Armenian.pas',
  ChronoTypes.Kyrgyz in '..\Source\ChronoTypes.Kyrgyz.pas',
  ChronoTypes.Tajik in '..\Source\ChronoTypes.Tajik.pas',
  ChronoTypes.Turkmen in '..\Source\ChronoTypes.Turkmen.pas',
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
