# Genera og-image.png (1200x630) y apple-touch-icon.png (180x180) a partir de profile.jpg
# Uso: powershell -NoProfile -ExecutionPolicy Bypass -File .\generar-imagenes.ps1
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$dir = (Get-Location).Path
$photoPath = Join-Path $dir 'profile.jpg'
if (!(Test-Path $photoPath)) { throw "No se encontró profile.jpg" }

$bg    = [System.Drawing.Color]::FromArgb(255, 11, 18, 32)
$green = [System.Drawing.Color]::FromArgb(255, 102, 187, 106)
$white = [System.Drawing.Color]::FromArgb(255, 232, 236, 244)
$muted = [System.Drawing.Color]::FromArgb(255, 154, 167, 194)

$img = [System.Drawing.Image]::FromFile($photoPath)

# ---------- og-image.png (1200x630) ----------
$W = 1200; $H = 630
$bmp = [System.Drawing.Bitmap]::new($W, $H)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = 'AntiAlias'
$g.TextRenderingHint = 'AntiAliasGridFit'
$g.Clear($bg)

$brushGreen = [System.Drawing.SolidBrush]::new($green)
$brushWhite = [System.Drawing.SolidBrush]::new($white)
$brushMuted = [System.Drawing.SolidBrush]::new($muted)
$penGreen   = [System.Drawing.Pen]::new($green, 3)

# Barra de acento a la izquierda
$g.FillRectangle($brushGreen, 70, 175, 8, 150)

# Nombre (se reduce si no cabe en el ancho disponible)
$name = 'Randall Castillo Guillén'
$size = 46
$font = [System.Drawing.Font]::new('Segoe UI', $size, [System.Drawing.FontStyle]::Bold)
while ($g.MeasureString($name, $font).Width -gt 740 -and $size -gt 24) {
  $size -= 2
  $font.Dispose()
  $font = [System.Drawing.Font]::new('Segoe UI', $size, [System.Drawing.FontStyle]::Bold)
}
$g.DrawString($name, $font, $brushWhite, 100, 165)

$fontRole = [System.Drawing.Font]::new('Segoe UI', 23, [System.Drawing.FontStyle]::Regular)
$g.DrawString('Analista de Datos & Desarrollador de Software', $fontRole, $brushGreen, 102, 252)

$fontInfo = [System.Drawing.Font]::new('Segoe UI', 18, [System.Drawing.FontStyle]::Regular)
$g.DrawString('Alajuela, Costa Rica  |  14 años de experiencia', $fontInfo, $brushMuted, 102, 302)
$g.DrawString('LinkedIn: in/randall-castillol-5161174b  ·  GitHub: rcg700-cmd', $fontInfo, $brushMuted, 102, 336)

# Foto (recorte cuadrado centrado en la parte superior)
$side = [Math]::Min($img.Width, $img.Height)
$sx = [int](($img.Width - $side) / 2)
$sy = [int](($img.Height - $side) * 0.25)
$destRect = [System.Drawing.Rectangle]::new(870, 165, 260, 260)
$srcRect  = [System.Drawing.Rectangle]::new($sx, $sy, $side, $side)
$g.DrawImage($img, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
$g.DrawRectangle($penGreen, 870, 165, 260, 260)

# Franja inferior de acento
$g.FillRectangle($brushGreen, 0, 622, 1200, 8)

$ogPath = Join-Path $dir 'og-image.png'
if (Test-Path $ogPath) { [System.IO.File]::Delete($ogPath) }
$bmp.Save($ogPath, [System.Drawing.Imaging.ImageFormat]::Png)

$font.Dispose(); $fontRole.Dispose(); $fontInfo.Dispose()
$brushGreen.Dispose(); $brushWhite.Dispose(); $brushMuted.Dispose(); $penGreen.Dispose()
$g.Dispose(); $bmp.Dispose()

# ---------- apple-touch-icon.png (180x180) ----------
$ico = [System.Drawing.Bitmap]::new(180, 180)
$gi = [System.Drawing.Graphics]::FromImage($ico)
$gi.Clear($bg)
$gi.DrawImage($img, [System.Drawing.Rectangle]::new(0, 0, 180, 180), [System.Drawing.Rectangle]::new($sx, $sy, $side, $side), [System.Drawing.GraphicsUnit]::Pixel)
$gi.Dispose()
$icoPath = Join-Path $dir 'apple-touch-icon.png'
if (Test-Path $icoPath) { [System.IO.File]::Delete($icoPath) }
$ico.Save($icoPath, [System.Drawing.Imaging.ImageFormat]::Png)
$ico.Dispose()

$img.Dispose()

Write-Host "OK: og-image.png ($([System.IO.File]::ReadAllBytes($ogPath).Length) bytes) y apple-touch-icon.png ($([System.IO.File]::ReadAllBytes($icoPath).Length) bytes)"
