-- Helm chart templates (`<chart>/templates/*.yaml|*.tpl`) and helmfile gotmpl files are
-- Go templates wrapped around YAML. Neovim's runtime (this build) detects them as plain
-- `yaml`, so yaml-language-server and yamllint parse every `{{ ... }}` as a YAML syntax
-- error ("Unexpected flow-map-end token", "too many spaces inside braces", ...).
-- Detecting them as `helm` (tree-sitter `helm` grammar = gotmpl with YAML injection)
-- keeps those two tools on real YAML only: yamlls's `filetypes` and nvim-lint's
-- `linters_by_ft` are both keyed on `yaml`.

-- Only treat `templates/*` as Helm when a Chart.yaml is above it, so other projects'
-- `templates/` directories (cookiecutter, ansible, ...) keep their normal detection.
local function helm_if_in_chart(path)
  local found = vim.fs.find("Chart.yaml", {
    upward = true,
    path = vim.fs.dirname(path),
    stop = vim.uv.os_homedir(),
    limit = 1,
  })
  if #found > 0 then
    return "helm"
  end
  -- nil = no match; fall through to the runtime's default detection (yaml, etc.)
end

vim.filetype.add({
  extension = {
    -- helmfile `*.yaml.gotmpl` is Go template over YAML too; other `.gotmpl` stay gotmpl
    gotmpl = function(path)
      if path:match("%.ya?ml%.gotmpl$") then
        return "helm"
      end
      return "gotmpl"
    end,
  },
  pattern = {
    [".*/templates/.*%.ya?ml"] = helm_if_in_chart,
    [".*/templates/.*%.tpl"] = helm_if_in_chart,
    [".*/templates/NOTES%.txt"] = helm_if_in_chart,
  },
})
