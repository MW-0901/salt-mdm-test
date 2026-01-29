test_file:
  file.managed:
    - name: C:\Users\test\test.txt
    - contents: "Salt is working! Updated at {{ salt['cmd.run']('powershell -Command "Get-Date"') }}"
    - makedirs: True
