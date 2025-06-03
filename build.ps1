try {
    Remove-Item -Path ".\public" -Recurse
}catch {
    Write-Warning "无法删除"
}
Remove-Item -Path ".\static\imgs" -Recurse
Copy-Item -Path ".\imgs" -Destination ".\static\imgs" -Recurse

# try {
#     Start-Process -FilePath "msedge.exe" -ArgumentList $hugoServerUrl
# }
# catch {
#     Write-Warning "无法通过 Edge 打开网站。请手动访问 $hugoServerUrl"
# }
Start-Process "msedge.exe" "http://localhost:1313"

hugo server 
