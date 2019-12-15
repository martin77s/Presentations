#region Safety
## throw "You're not supposed to hit F5"
#endregion"

Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "This is not really notepad :-)"
$Form.TopMost = $true
$Form.Width = 650
$Form.Height = 300

$textBox = New-Object system.windows.Forms.TextBox
$textBox.Multiline = $true
$textBox.Width = 620
$textBox.Height = 270
$textBox.location = new-object system.drawing.point(6,4)
$textBox.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox)

[void]$Form.ShowDialog()
$Form.Dispose()