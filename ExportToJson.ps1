#PowerShell скрипт для извлечения данных из AD и конвертации их в JSON
#DN вашего OU
$ou = "OU=Пользователи,DC=domen,DC=ru"
# PowerShell скрипт для извлечения данных из AD и конвертации их в JSON
$users = Get-ADUser -Filter * -SearchBase $ou -Property DisplayName, EmailAddress, OfficePhone, StreetAddress

# Создаем массив объектов для каждого пользователя
$userData = $users | ForEach-Object {
    @{
        name = $_.DisplayName       
        phone = $_.OfficePhone        
        address = $_.StreetAddress
        email = $_.EmailAddress
    }
}

# Конвертируем массив в JSON
$jsonData = $userData | ConvertTo-Json

# Сохраняем JSON в файл
$jsonData | Out-File "C:\Users\myuser\Desktop\users.json"
