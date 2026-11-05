Add-Type -AssemblyName System.Drawing
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
function Convert-Img($src, $dst, $maxSide = 1000, $q = 82) {
  $img = [System.Drawing.Image]::FromFile("$dir\$src")
  $scale = [Math]::Min(1.0, $maxSide / [Math]::Max($img.Width, $img.Height))
  $w = [int]($img.Width * $scale); $h = [int]($img.Height * $scale)
  $bmp = New-Object System.Drawing.Bitmap($w, $h)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.DrawImage($img, 0, 0, $w, $h)
  $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
  $ep = New-Object System.Drawing.Imaging.EncoderParameters(1)
  $ep.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]$q)
  $bmp.Save("$dir\$dst", $codec, $ep)
  $g.Dispose(); $bmp.Dispose(); $img.Dispose()
  Write-Host "$dst OK"
}
Convert-Img 'ep-castelos_src.png' 'ep-castelos.jpg'
Convert-Img 'tjola_src.png'       'tjola.jpg'
Convert-Img 'tremendo_src.png'    'tremendo.jpg'
Convert-Img 'construcao_src.png'  'construcao.jpg'
Convert-Img 'vol1_src.png'        'vol1.jpg'
Convert-Img 'foto1_src.png'       'foto1.jpg' 1100 85
Convert-Img 'foto2_src.png'       'foto2.jpg' 1100 85
