$URL = "https://chatbat-39793-default-rtdb.firebaseio.com"

Clear-Host
Write-Host "=== ChatBAT ==="
Write-Host ""

$Nome = Read-Host "Seu nome"
$Sala = Read-Host "Sala"

$UltimaQuantidade = 0

while ($true)
{
    Clear-Host

    Write-Host "=== Sala: $Sala ==="
    Write-Host ""

    try
    {
        $Mensagens = Invoke-RestMethod "$URL/salas/$Sala.json"

        if ($Mensagens)
        {
            $Lista = $Mensagens.PSObject.Properties.Value

            foreach ($m in $Lista)
            {
                Write-Host "[$($m.hora)] $($m.nome): $($m.texto)"
            }

            $UltimaQuantidade = $Lista.Count
        }
    }
    catch
    {
        Write-Host "Erro ao carregar mensagens."
    }

    Write-Host ""
    $Texto = Read-Host "Mensagem (/sair para fechar)"

    if ($Texto -eq "/sair")
    {
        break
    }

    $Msg = @{
        nome  = $Nome
        texto = $Texto
        hora  = Get-Date -Format "HH:mm:ss"
    } | ConvertTo-Json

    try
    {
        Invoke-RestMethod `
            -Uri "$URL/salas/$Sala.json" `
            -Method Post `
            -Body $Msg `
            -ContentType "application/json" | Out-Null
    }
    catch
    {
        Write-Host "Erro ao enviar."
        Start-Sleep 2
    }
}