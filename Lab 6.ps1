Set-Location C:\

Function FileCreation {
#This function will ask the user what he wants the file to be named, and where it will be located. Then it creates the files
    $FileName = read-host Name of the folder?
    $FilePath = read-host Path of the folder?
    $FileAnswer = read-host 'Are you sure? (Y/N)'
    $x = 1
        While ($x -eq 1){
            if ($FileAnswer -eq 'Y'){
                New-item -type directory -name $FileName -Path $FilePath
                $Names = import-csv employeelist.csv
                #This assumes employeelist.csv is located in C:\
                    ForEach ($Name in $Names){
                        New-item -type directory -name $Name.Name.Replace(' ','').ToLower() -Path $FilePath\$FileName
                        New-item -type file -name hello.txt -Value "Welcome, $($Name.Name)" -Path $FilePath\$FileName\$($Name.Name.Replace(' ','').ToLower())
                    }
                    $x++
        }
            if ($FileAnswer -eq 'N'){
                $FileName = read-host Name of the folder?
                $FilePath = read-host Path of the folder?
                $FileAnswer = read-host 'Are you sure? (Y/N)'

            }
        }
    }


Function Multiplication {
#This function will multiply the numbers inside the num variable by an amount the user specifies and outputs the result
    $num = 5,50,50,3,1
        foreach ($number in $num){
            $times = read-host "Multiply $number by how much?"
            $calc = $number*$times
            write-host "$number * $times is $calc"
        }
}

Function ServerCheck {
#This function will ping the servers and tell you whether at least 1 ping was successfull or not
    $serverlist = import-csv serverlist.csv
    #This assumes serverlist.csv is located in C:\
        foreach ($server in $serverlist){
            if (Test-Connection -ComputerName $server.Servers.Replace('@{','').Replace('}','') -Quiet){
            write-host $server.Servers.Replace('@{','').Replace('}','') ' is Good'
            }

            else{
            write-host $server.Servers.Replace('@{','').Replace('}','') ' is bad'
            }
        }
}

Function PrinterFiles {
#This function will get all the printers on the system and create a folder for each with information about the printer inside a "Printers" folder
    $Printers = Get-Printer
    New-item -type directory -name Printers -Path C:\
        foreach ($Printer in $Printers.name){
            New-item -type directory -name $Printer -path C:\Printers
            Get-Printer $Printer | ConvertTo-Json | out-file C:\Printers\$Printer\$Printer.json
        }
}

