Set oShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set objNet = CreateObject("WScript.Network")

usuario = objNet.UserName
tempFolder = oShell.ExpandEnvironmentStrings("%TEMP%")
logPath = tempFolder & "\log_simulacion.txt"
htaPath = tempFolder & "\bloqueo.hta"
psPath = tempFolder & "\bloqueo_cursor.ps1"
pidPath = tempFolder & "\cursor_pid.txt"
stopPath = tempFolder & "\detener_cursor.ps1"

' Crear script PowerShell que bloquea el cursor y guarda su PID
Set psFile = fso.CreateTextFile(psPath, True)
psFile.WriteLine "$pid | Out-File -FilePath '" & pidPath & "'"
psFile.WriteLine "Add-Type -AssemblyName System.Windows.Forms"
psFile.WriteLine "Add-Type -AssemblyName System.Drawing"
psFile.WriteLine "while ($true) {"
psFile.WriteLine "  $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds"
psFile.WriteLine "  $centerX = $screen.Width / 2"
psFile.WriteLine "  $centerY = $screen.Height / 2"
psFile.WriteLine "  [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($centerX, $centerY)"
psFile.WriteLine "  Start-Sleep -Milliseconds 200"
psFile.WriteLine "}"
psFile.Close

' Crear script PowerShell para detener bloqueo
Set stopFile = fso.CreateTextFile(stopPath, True)
stopFile.WriteLine "$pid = Get-Content '" & pidPath & "'"
stopFile.WriteLine "Stop-Process -Id $pid -Force"
stopFile.Close

' Ejecutar bloqueo de cursor
oShell.Run "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & psPath & """", 0, False

' Log de actividad
Set logFile = fso.OpenTextFile(logPath, 8, True)
logFile.WriteLine "----- SIMULACI�N DE PHISHING / RANSOMWARE -----"
logFile.WriteLine "Usuario: " & usuario
logFile.WriteLine "Fecha: " & Now

' Mensajes enga�osos
MsgBox ChrW(161) & " �ALERTA M�XIMA!", 16, "Virus detectado"
MsgBox "Un archivo cr�tico ha sido infectado por malware.", 48, "An�lisis urgente"
MsgBox "Intentando eliminar amenaza...", 64, "Acci�n en progreso"
WScript.Sleep 1500

respuesta = MsgBox("�Deseas enviar tus credenciales para intentar salvar el sistema?", 4 + 32, "Soporte t�cnico")
If respuesta = 6 Then
    MsgBox "ERROR FATAL: Credenciales comprometidas.", 16, ChrW(161) & "Atenci�n cr�tica"
    logFile.WriteLine "Respuesta: ACEPT� enviar credenciales"
Else
    MsgBox "Intentando contener la amenaza, pero el sistema est� en riesgo.", 48, "Advertencia cr�tica"
    logFile.WriteLine "Respuesta: NO acept� enviar credenciales"
End If

WScript.Sleep 1500
MsgBox "0x000000F4: CRITICAL_OBJECT_TERMINATION", 16, "ERROR FATAL DEL SISTEMA"
WScript.Sleep 1500
MsgBox "INFECCI�N MASIVA DETECTADA", 16, "SISTEMA COMPROMETIDO"
WScript.Sleep 1500


oShell.Run "cmd /c echo Iniciando escaneo de amenazas... & ping -n 3 127.0.0.1 >nul & echo AMENAZAS DETECTADAS: 9 & echo INICIANDO ELIMINACI�N... & ping -n 2 127.0.0.1 >nul & echo ERROR: Falla cr�tica en limpieza", 1, True

' Crear HTA falsa de ransomware
Set htaFile = fso.CreateTextFile(htaPath, True)
htaFile.WriteLine "<html>"
htaFile.WriteLine "<head>"
htaFile.WriteLine "<title>�Sistema Comprometido!</title>"
htaFile.WriteLine "<HTA:APPLICATION APPLICATIONNAME='BloqueoPantalla' BORDER='none' CAPTION='no' SHOWINTASKBAR='no' SINGLEINSTANCE='yes' SYSMENU='no' WINDOWSTATE='maximize' SCROLL='no' CONTEXTMENU='no' INNERBORDER='no' SELECTION='no' />"
htaFile.WriteLine "<style>"
htaFile.WriteLine "body {margin:0;padding:0;background-color:#111;color:white;font-family:'Segoe UI';font-size:28px;display:flex;flex-direction:column;justify-content:center;align-items:center;height:100vh;text-align:center;}"
htaFile.WriteLine "button { font-size: 22px; margin-top: 30px; padding: 10px 20px; border-radius: 6px; background-color:red; color:white; border:none; cursor:pointer; }"
htaFile.WriteLine "#errorMsg { color: red; font-size: 18px; margin-top: 20px; display: none; }"
htaFile.WriteLine "</style>"
htaFile.WriteLine "<script language='VBScript'>"
htaFile.WriteLine "Sub desbloquear()"
htaFile.WriteLine "  Dim clave"
htaFile.WriteLine "  clave = InputBox(""Tus archivos han sido cifrados. Ingresa la clave para restaurarlos:"", ""Desbloqueo requerido"")"
htaFile.WriteLine "  If clave = ""Conciencia2025"" Then"
htaFile.WriteLine "    Set oShell = CreateObject(""WScript.Shell"")"
htaFile.WriteLine "    oShell.Run ""powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File " & Replace(stopPath, "\", "\\") & """, 0, True"
htaFile.WriteLine "    window.close"
htaFile.WriteLine "  Else"
htaFile.WriteLine "    errorMsg.style.display = ""block"""
htaFile.WriteLine "  End If"
htaFile.WriteLine "End Sub"
htaFile.WriteLine "</script>"
htaFile.WriteLine "<body>"
htaFile.WriteLine "<div>"
htaFile.WriteLine "<h1>�TU EQUIPO HA SIDO CIFRADO!</h1>"
htaFile.WriteLine "<p>Todos tus archivos han sido encriptados.<br>Para recuperar el acceso, env�a 0.05 BTC a:<br><b>1FAKEbtcADDRess1234567890</b><br>Luego, haz clic en 'Ya he pagado' para ingresar la clave de desbloqueo.</p>"
htaFile.WriteLine "<i>Si cierras esta ventana sin pagar, tus datos se perder�n para siempre.</i><br><br>"
htaFile.WriteLine "<button onclick='desbloquear'>Ya he pagado</button>"
htaFile.WriteLine "<div id='errorMsg'>Clave incorrecta. Intenta nuevamente o contacta a IT.</div>"
htaFile.WriteLine "</div>"
htaFile.WriteLine "<audio autoplay loop>"
htaFile.WriteLine "  <source src='https://www.soundjay.com/misc/sounds/bell-ringing-05.mp3' type='audio/mpeg'>"
htaFile.WriteLine "</audio>"
htaFile.WriteLine "</body>"
htaFile.WriteLine "</html>"
htaFile.Close

' Ejecutar pantalla de bloqueo
oShell.Run Chr(34) & htaPath & Chr(34), 1, True

' Mensajes finales de concientizaci�n
MsgBox ChrW(9888) & " ESTA FUE UNA SIMULACI�N DE ATAQUE DE RANSOMWARE", 64, "Concientizaci�n en Ciberseguridad"
MsgBox "Nunca ingreses credenciales ni realices pagos sin verificar con tu equipo de IT. Esta simulaci�n fue parte de una campa�a de formaci�n interna.", 64, "�Gracias por participar!"

logFile.WriteLine "Simulaci�n completada exitosamente."
logFile.Close