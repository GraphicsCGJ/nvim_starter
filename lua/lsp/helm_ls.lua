---@brief
---
--- https://github.com/mrjosh/helm-ls
---
--- Language server for Helm chart templates (filetype `helm`, set in filetype.lua).
--- It runs yaml-language-server internally for the YAML parts of a template.
return {
  cmd = { 'helm_ls', 'serve' },
  filetypes = { 'helm', 'yaml.helm-values' },
  root_markers = { 'Chart.yaml' },
  settings = {
    ['helm-ls'] = {
      yamlls = { path = 'yaml-language-server' },
    },
  },
}
