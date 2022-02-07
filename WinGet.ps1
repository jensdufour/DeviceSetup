function Provision-Device {
    <#
    .SYNOPSIS
      This is a device provisioning function to include all the 
      required programs either for a personal or enterprise device.
      These will be kept updated through a recurring task. 
    .PARAMETER InputObject
      The main parameter. Is passed via the pipline and is named "InputObject" by convention
    .PARAMETER Number
      A numeric value. ValidateRange keeps this value between 0 and 10
    .PARAMETER AGroup
      A string parameter used to show how parameter sets work
    .PARAMETER BGroup
      A string parameter used to show how parameter sets work
    .EXAMPLE
      "inputText" | Invoke-Boilerplate -Number 10
    .EXAMPLE
      1..10 | % {[PSCustomObject]@{
          InputObject = "inputText"
          Number = 5
          AGroup = "Test String"
      } | Invoke-Boilerplate -Number 10
    #>
    [CmdletBinding()]
    param (
        [ValidateScript( { $_.StartsWith("TestValue") })]
        [Parameter(ValueFromPipeline)]
        [String]
        $InputObject,

        [ValidateRange(0, 10)]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Int]
        $Number,
        
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = "ParamA")]
        [String]
        $AGroup,

        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = "ParamB")]
        [String]
        $BGroup
    )
    process {
        foreach ($value in $InputObject) {
            if ($AGroup) {
                # Do A group stuff
                # Not included: Mobalytics, Battle.NET
                Winget import .\Personal
                Winget import .\Shared
            }
            elseif ($BGroup) {
                # Do B group stuff
                Winget import .\Enterprise
                Winget import .\Shared
            }
            else {
                # Do other stuff
                Winget upgrade --all
            }
        }
    }
}