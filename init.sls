test_file:
  file.managed:
    - name: C:\Users\danwi\test\test.txt
    - contents: "Salt is DEFINITELY working, and was updated automatically! Updated at {{ salt['cmd.run']('powershell -Command "Get-Date"') }}"
    - makedirs: True
