

$today = [datetime]::Now

$today = Get-Date



calc;calc;calc
Get-Process | Where-Object { $_.Name -eq 'notepad' } | ForEach-Object { $_.Kill() }

calc;calc;calc
Get-Process notepad | Stop-Process

calc;calc;calc
ps calc | kill


# .NET
[net.httpWebRequest] $request = [net.webRequest]::create("http://www.bing.com")
[net.httpWebResponse] $response = $request.getResponse()
$responseStream = $response.getResponseStream()
$sr = New-Object IO.StreamReader($responseStream)
$res1 = $sr.ReadToEnd()
$res1 

# PS ( >= 3)
$res2 = Invoke-WebRequest "http://www.bing.com"
$res2.RawContent




# Common exceptions:
[math]::Round(456.234456677,2)
[System.IO.Path]::GetTempFileName()
[System.IO.Path]::GetRandomFileName()
[guid]::NewGuid()