$RootSearch = "D:\*";
$ReportFileName = "Files.csv";

$IncludeExtensionsFile = Join-Path -Path $PSScriptRoot -ChildPath "SearchExtensions.txt" -Resolve;
$IncludeExtensions = @();

ForEach( $Extension In (Get-Content $IncludeExtensionsFile))
{
    $IncludeExtensions += $Extension;
}

$AllFiles = Get-ChildItem -Path $RootSearch -Include $IncludeExtensions -Recurse;

#Write Result To File
$ReportFile = Join-Path -Path $PSScriptRoot -ChildPath $ReportFileName;
If(Test-Path $ReportFile)
{
    Remove-Item -Path $ReportFile -Force;
}

Add-Content -Path $ReportFile -Value "FileName;Path;Size;";

ForEach($File In $AllFiles)
{
    $FileSize = [math]::Round($File.Length / 1mb)
    
    Add-Content -Path $ReportFile -Value "$($File.Name);$($File.Directory);$($FileSize);"
}