status:
  file.managed:
    - name: C:\Users\danwi\salt-status\status.txt
    - contents: "Updated at {{ salt['cmd.run']('powershell -Command "Get-Date"') }}"
    - makedirs: True
