# 설정 동기화 명령 모음

여러 머신에서 같은 nvim 환경을 쓰기 위한 명령을 상황별로 정리한 문서입니다.
아래 세 가지는 모두 git 으로 관리하므로, 이 저장소를 pull 하면 다른 머신에도 그대로 적용됩니다.

| 대상 | 목록 위치 |
|------|-----------|
| 플러그인 | `lazy-lock.json` |
| Mason 도구 (LSP, 린터, 포매터) | `lua/plugins/init.lua` 의 `tools` |
| Treesitter parser | `lua/options.lua` 의 `ensure_installed` |

## 1. 새 머신에서 처음 설치할 때

```bash
git clone git@github.com:GraphicsCGJ/nvim_starter.git ~/.config/nvim
nvim --headless "+Lazy! restore" +qa                              # 플러그인 (lazy-lock.json 에 적힌 커밋)
nvim --headless "+Lazy! load all" "+MasonToolsInstallSync" +qa     # Mason 도구
nvim --headless "+Lazy! load all" "+TSUpdateSync" +qa              # Treesitter parser
```

headless 명령을 쓰지 않고 nvim 을 그냥 켜도 됩니다. 그러면 위 세 가지가 백그라운드에서 자동으로 설치됩니다.

## 2. 다른 머신에서 바뀐 설정을 받을 때

```bash
git -C ~/.config/nvim pull
nvim --headless "+Lazy! restore" +qa                                   # lazy-lock.json 이 바뀌었을 때
nvim --headless "+lua require('base46').load_all_highlights()" +qa     # 테마(chadrc.lua)가 바뀌었을 때
```

Mason 도구와 parser 는 nvim 을 켜면 빠진 것만 자동으로 설치됩니다.
테마는 캐시를 다시 만들지 않으면 예전 색이 그대로 남으므로, `chadrc.lua` 가 바뀌었다면 두 번째 명령을 꼭 실행합니다.

## 3. 이 머신에서 바꾼 설정을 올릴 때

```bash
git -C ~/.config/nvim pull                       # 다른 머신에서 올린 변경을 먼저 받습니다
git -C ~/.config/nvim add -A
git -C ~/.config/nvim commit -m "(misc) <what changed>"
git -C ~/.config/nvim push
```

## 4. 도구나 parser 를 직접 설치했을 때

`:Mason` 이나 `:TSInstall` 로 직접 설치한 것은 목록에 추가하기 전까지 다른 머신에 설치되지 않습니다.

```vim
:MasonToolsDiff     " 'not in ensure_installed' 에 나온 이름을 lua/plugins/init.lua 의 tools 에 추가합니다
:TSInstallInfo      " 설치된 parser 를 확인하고 lua/options.lua 의 ensure_installed 에 추가합니다
```

목록을 고친 뒤에는 3번 절차로 커밋하고 push 합니다.

## 5. 플러그인을 업데이트할 때

```vim
:Lazy sync          " 플러그인을 최신으로 올리고 lazy-lock.json 을 갱신합니다
:MasonToolsUpdate   " Mason 도구를 최신으로 올립니다 (버전은 git 에 기록되지 않습니다)
```

`:Lazy sync` 를 실행하면 `lazy-lock.json` 이 바뀌므로 3번 절차로 커밋합니다.
다른 머신에서는 2번 절차의 `Lazy! restore` 로 같은 버전을 받습니다.
