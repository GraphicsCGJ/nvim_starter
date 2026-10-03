> 여러 머신 사이의 동기화 명령은 [SYNC.md](SYNC.md) 에 정리되어 있습니다.

**This repo is supposed to be used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# 구조 (Structure)

```
~/.config/nvim/
├── init.lua                   # 부트스트랩: lazy.nvim 설치 → NvChad 로드 → 테마 → options/autocmds/mappings
└── lua/
    ├── chadrc.lua             # NvChad 설정 (테마: everforest_light)
    ├── options.lua            # vim 옵션 + treesitter/conform(포맷터) 초기 setup
    ├── autocmds.lua           # 자동명령 (yank 레지스터 순환, 저장 시 trailing whitespace 제거)
    ├── mappings.lua           # 키 매핑
    ├── configs/
    │   ├── lazy.lua           # lazy.nvim 옵션
    │   ├── lspconfig.lua      # LSP 등록/활성화 (vim.lsp.config / vim.lsp.enable)
    │   └── lint.lua           # nvim-lint 린터 매핑 (단일 출처)
    ├── lsp/                   # 서버별 LSP 설정 — lspconfig.lua 가 require("lsp.<name>") 로 로드
    │   └── gopls.lua, clangd.lua, pyright.lua, rust_analyzer.lua, ... (서버별 1파일)
    └── plugins/
        └── init.lua           # 플러그인 목록 (conform, nvim-lint, fugitive, nvim-cmp, treesitter-context ...)
```

## 무엇이 어디서 동작하나

| 기능 | 담당 | 설정 위치 |
|------|------|-----------|
| 에러/자동완성/정의이동 | LSP | `lua/configs/lspconfig.lua` + `lua/lsp/<server>.lua` |
| 포맷 (저장 시 자동 정리) | conform.nvim | `lua/options.lua` (`require("conform").setup`) |
| 린트 (품질/버그 지적) | nvim-lint | `lua/configs/lint.lua` |

- **LSP 서버 추가**: `lua/lsp/<server>.lua` 작성 → `lspconfig.lua` 에 `vim.lsp.config()` + `vim.lsp.enable()` 추가.
- **린터 추가**: Mason 으로 도구 설치 후 `configs/lint.lua` 의 `linters_by_ft` 에 `ft = { "tool" }` 추가.
- **포맷터 추가**: Mason 으로 도구 설치 후 `options.lua` 의 `formatters_by_ft` 에 `ft = { "tool" }` 추가.
- Mason 설치 도구는 `lspconfig.lua` 첫 줄에서 PATH(`mason/bin`)에 추가됨.

# 테마 색 커스터마이즈 (base46 캐시 재컴파일)

`chadrc.lua` 의 `theme` 이나 `hl_override` (하이라이트 색 덮어쓰기)를 **바꿔도 nvim 을
재시작하는 것만으로는 반영되지 않는다.** NvChad 는 색을 매번 계산하지 않고
`~/.local/share/nvim/base46/` 에 **컴파일된 캐시**로 저장해두고, 캐시가 있으면 그대로
쓰기 때문이다. 그래서 캐시를 강제로 다시 굽기 전까지는 예전 색이 계속 적용된다.

저장 후 아래 중 하나로 캐시를 재컴파일하면 즉시 반영된다.

```vim
:lua require('base46').load_all_highlights()   " nvim 안에서: 재컴파일 + 즉시 적용
```

```bash
# nvim 밖에서(headless): 캐시만 다시 굽고 종료. 다음 실행부터 반영
nvim --headless "+lua require('base46').load_all_highlights()" +qa
```

> 막혔을 때는 캐시를 통째로 지워도 된다 (`rm -rf ~/.local/share/nvim/base46`).
> 다음 nvim 실행 시 자동으로 새로 컴파일된다.

**예시 — `hl_override` 로 색 덮어쓰기** (`lua/chadrc.lua`):

```lua
M.base46 = {
  theme = "flexoki-light",
  hl_override = {
    -- flexoki-light: 기본 선택줄 음영(#f2efe4)이 배경(#FFFCF0)과 거의 같아
    -- find(<leader>ff) 선택줄이 안 보임 → 대비 있는 색으로 덮어씀
    TelescopeSelection = { bg = "#d6d4ca" },
  },
}
```

# 새 머신에서 재현 (Fresh install)

설정은 **두 층**으로 나뉘고, git 으로 추적되는 범위가 다르다.

| 대상 | git 추적 | 재현 방법 |
|------|----------|-----------|
| **플러그인** | ✅ `lazy-lock.json` | 자동 — 아래 1번 |
| **Mason 도구** (LSP/린터/포맷터) | ✅ `lua/plugins/init.lua` 의 `tools` 목록 | 자동 — 아래 2번 |
| **Treesitter parser** | ✅ `lua/options.lua` 의 `ensure_installed` | 자동 — 아래 3번 |

새 머신에서 한 번에 받기 (nvim 을 켜지 않고 설치까지 끝냄):

```bash
git clone git@github.com:GraphicsCGJ/nvim_starter.git ~/.config/nvim
nvim --headless "+Lazy! restore" +qa                                   # 플러그인 (lazy-lock.json 커밋 그대로)
nvim --headless "+Lazy! load all" "+MasonToolsInstallSync" +qa          # Mason 도구
nvim --headless "+Lazy! load all" "+TSUpdateSync" +qa                   # Treesitter parser
```

다른 머신에서 바뀐 설정 받기: `git -C ~/.config/nvim pull` 후 nvim 을 켜면 누락된 도구와 parser 가 자동 설치된다.

### 1. 플러그인 — `lazy-lock.json` 그대로 받기

```bash
git clone <this-repo> ~/.config/nvim
nvim                       # 첫 실행 시 lazy.nvim 이 lazy-lock.json 에 고정된 커밋으로 자동 설치
```

`lazy-lock.json` 이 있으면 lazy 가 **잠긴 버전 그대로** 설치한다. 강제로 맞추거나 어긋났을 때:

```vim
:Lazy restore     " lazy-lock.json 에 적힌 정확한 커밋으로 복원 (재현용 — 이걸 사용)
:Lazy sync        " 최신으로 업데이트 + lazy-lock.json 갱신 (버전 올릴 때만)
```

### 2. Mason 도구 — `lazy-lock.json 에 포함되지 않음`

LSP 서버 / 린터 / 포맷터는 Mason 이 따로 설치하며 `lazy-lock.json` 에는 잡히지 않는다.
대신 `WhoIsSethDaniel/mason-tool-installer.nvim` 의 `tools` 목록
(`lua/plugins/init.lua`)으로 git 관리되며, **nvim 실행 시 누락된 도구가 자동 설치**된다.

- 새 머신: nvim 을 한 번 켜면 끝. (필요하면 `:MasonToolsInstall` 수동 실행)
- 도구 추가/제거: `lua/plugins/init.lua` 의 `tools` 만 수정 (이 README 갱신 불필요).
- `:Mason` 화면에서 직접 설치했다면 `:MasonToolsDiff` 로 목록에 빠진 도구를 확인하고 `tools` 에 추가한 뒤 커밋한다.
  목록에 없으면 다른 머신에는 설치되지 않는다.
- 일괄 업데이트: `:MasonToolsUpdate` (또는 spec 에서 `auto_update = true`).

### 3. Treesitter parser

`:TSInstall <lang>` 으로 직접 설치한 parser 도 다른 머신에는 따라가지 않는다.
`lua/options.lua` 의 `ensure_installed` 에 추가해 두면 nvim 실행 시 자동 설치된다.
현재 설치된 parser 목록은 `:TSInstallInfo` 로 확인한다.

# Helm / Kubernetes YAML

| 파일 | filetype | 동작하는 도구 |
|------|----------|---------------|
| `<chart>/templates/*.yaml`, `*.tpl` (위에 `Chart.yaml` 이 있을 때) | `helm` | `helm_ls` (`.Values.*` 자동완성, 정의 이동). yamllint/포맷터는 적용되지 않음 |
| `apiVersion` 과 `kind` 가 있는 YAML (경로 무관) | `yaml` | yamlls + kind 별 k8s 스키마 (`kind` 아래 필드 자동완성, 오타·타입 검증), yamllint |
| 그 밖의 YAML (`values.yaml`, compose, CI) | `yaml` | yamlls (SchemaStore), yamllint |

- k8s 스키마는 `schema-companion.nvim` 이 파일의 `apiVersion`/`kind` 를 읽어 kind 별 스키마
  (yannh/kubernetes-json-schema, CRD 는 datreeio/CRDs-catalog)를 yamlls 에 연결한다. 설정은 `lua/lsp/yamlls.lua`.
- yamlls 기본 `kubernetes` 스키마는 모든 kind 를 합친 스키마라서 검증만 되고 `spec:` 아래 자동완성이 되지 않는다.
  그래서 쓰지 않는다.
- 빈 파일에서 새로 쓸 때는 `apiVersion`/`kind` 를 입력하고 Insert 모드를 벗어나거나 저장하면 스키마가 연결된다.
- 수동 재매칭: `:lua require("schema-companion").match()`, 현재 스키마 확인: `:lua print(require("schema-companion").get_current_schemas())`

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
