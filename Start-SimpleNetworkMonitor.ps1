$monitorhost = "www.google.com"


function Out-TextToVoice{
    param ([Parameter(Mandatory=$true, ValueFromPipeline=$true)] [string] $Text)
    Add-Type -AssemblyName System.Speech
    (New-Object -ComObject SAPI.SpVoice).Speak("$text")
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

    Out-TextToVoice "$monitorhost not responding"

    
    while(!(Test-Connection $monitorhost)){
        try{
            Test-Connection $monitorhost -ErrorAction stop
        }
        catch{
            $errormsg = $_
        }
    }
    Out-TextToVoice "$monitorhost BACK!"

}