Remove-Item .\public\ -Recurse
Remove-Item .\resources\ -Recurse
Remove-Item -Path ".\static\imgs" -Recurse
Copy-Item -Path ".\imgs" -Destination ".\static\imgs" -Recurse

hugo server 
