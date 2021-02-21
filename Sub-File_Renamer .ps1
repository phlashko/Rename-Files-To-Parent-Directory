##########################################################################
# ****** This allows for dialog boxes to be utilized in the script *******
##########################################################################
[reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

##########################################################################
# ******************** This is the gui container *************************
##########################################################################
$folderForm = New-Object System.Windows.Forms.Form
$folderForm.Text = "Rename Sub-Files To Parent Directory"
$folderForm.Size = "395,160"

##########################################################################
# ******************** This is the file location box *********************
##########################################################################
$pathTextBox = New-Object System.Windows.Forms.TextBox

$pathTextBox.Location = '23,23'
$pathTextBox.Size = '250,23'

$folderForm.Controls.Add($pathTextBox)

##########################################################################
# **************** This adds Select button to the gui ******************** 
##########################################################################
$selectButton = New-Object System.Windows.Forms.Button

$selectButton.Text = 'Select'
$selectButton.Location = '290,22'

$folderForm.Controls.Add($selectButton)

##########################################################################
# ******** This makes the select button enable file selection ************
##########################################################################
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog

$selectButton.Add_Click({
    $folderBrowser.ShowDialog()
    $pathTextBox.Text = $folderBrowser.SelectedPath
})

##########################################################################
# **************** This adds the Rename button to the gui **************** 
##########################################################################
$RenButton = New-Object System.Windows.Forms.Button

$RenButton.Text = 'Click to Rename Files (MUST SELECT FOLDER ABOVE)'
$RenButton.Size = '343,50'
$RenButton.Location = '21,53'
$RenButton.BackColor = 'Green'

#############################################################################
# This makes the Rename Button rename all sub-files to the sub folder names #
#############################################################################

$RenButton.Add_Click({
    get-childitem $pathTextBox.Text -file -recurse | foreach {
        rename-item $_.fullname -new ($_.directory.name + $_.Extension)
        }
})

$folderForm.Controls.Add($RenButton)

##########################################################################
# ****** This is the end that shows everything above on one nice gui *****
##########################################################################
$folderForm.ShowDialog()