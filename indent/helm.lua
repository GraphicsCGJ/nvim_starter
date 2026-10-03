-- No indent rules exist for `helm` (tree-sitter `helm` has no indents.scm, runtime has no
-- indent/helm.vim), so `indentexpr` stays empty and Enter after `key:` only copies the previous
-- indent. Reuse the runtime YAML indent script (sets indentexpr=GetYAMLIndent(), indentkeys).
-- Must live in indent/, not ftplugin/: the indent handler runs after ftplugins and resets indent options.
vim.cmd("runtime! indent/yaml.vim")
