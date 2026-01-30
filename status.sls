status:
  file.managed:
    - name: C:\Users\danwi\salt-status\status.txt
    - contents: "Updated at {{ salt['grains.get']('localtime') }}"
    - makedirs: True