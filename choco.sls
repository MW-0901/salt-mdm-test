choco_install:
  cmd.run:
    - name: |
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    - shell: powershell
    - unless: powershell -Command "Get-Command choco -ErrorAction SilentlyContinue"
