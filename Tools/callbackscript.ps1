# Select current WTF Path by user selection
function Find-Folders {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = "C:\"
	$browse.RootFolder = [System.Environment+SpecialFolder]'MyComputer'
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select a directory"

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
		
		#Scan for all TellMeWhen files... 
		Get-Childitem -path $browse.SelectedPath -Filter *.lua -Recurse | where-object {$_.Name -ilike "TellMeWhen*"} | Remove-Item -Force 
		#Also remove .bak files
		Get-Childitem -path $browse.SelectedPath -Filter *.bak -Recurse | where-object {$_.Name -ilike "TellMeWhen*"} | Remove-Item -Force 
		
        } else
        {
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                #Ends script
                return
            }
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
} Find-Folders













