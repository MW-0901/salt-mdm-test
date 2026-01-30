refresh_winrepo_git:
  module.run:
    - name: winrepo.update_git_repos

refresh_winrepo_db:
  pkg.refresh_db:
    - require:
      - module: refresh_winrepo_git
