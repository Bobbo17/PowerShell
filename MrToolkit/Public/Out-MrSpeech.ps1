function Out-MrSpeech {

<#
.SYNOPSIS
    Converts text to speech.

.DESCRIPTION
    The Out-MrSpeech function uses the System.Speech.Synthesis.SpeechSynthesizer class to convert
    text input to speech. The function can accept input from the pipeline and will speak each
    phrase it receives.

.PARAMETER Phrase
    The text phrase to be converted to speech. This parameter is mandatory and accepts input from
    the pipeline.

.EXAMPLE
    Out-MrSpeech -Phrase 'Hello, World!'

.EXAMPLE
    'Hello', 'How are you?', 'Goodbye' | Out-MrSpeech

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [string]$Phrase
    )

    Add-Type -AssemblyName System.Speech

    $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer

    $voice.Speak($Phrase)

}
