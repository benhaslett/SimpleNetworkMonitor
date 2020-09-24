$monitorhost = "beast"


function Say-Text
{
    param ([Parameter(Mandatory=$true, ValueFromPipeline=$true)] [string] $Text)
    [Reflection.Assembly]::LoadWithPartialName('System.Speech') | Out-Null
    $object = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $object.Speak($Text)
}


While($true){
    $errormsg = $null

    while($null -eq $errormsg){
        try{
            Test-Connection $monitorhost -ErrorAction stop
        }
        catch{
            $errormsg = $_
        }
    }

    say-text "$monitorhost not responding"

    
    while(!(Test-Connection $monitorhost)){
        try{
            Test-Connection $monitorhost -ErrorAction stop
        }
        catch{
            $errormsg = $_
        }
    }
    say-text '$monitorhost BACK!'

}