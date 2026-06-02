# Neovim 소스 빌드 & 설치 가이드

이 config가 사용하는 Neovim은 패키지 매니저 버전이 아니라 **소스에서 직접 빌드**한 것이다.
새 환경(서버, WSL, 새 노트북 등)에서 동일한 nvim을 그대로 재현하기 위한 문서.

## 현재 설치된 버전 (기준값)

```
NVIM v0.11.3-dev-41+gce292026ea
Build type: RelWithDebInfo
LuaJIT 2.1.1741730670
```

| 항목 | 값 |
|------|-----|
| Repo | `git@github.com:neovim/neovim.git` (https: `https://github.com/neovim/neovim.git`) |
| Commit | `ce292026ea` (`git describe` → `v0.11.2-44-gce292026ea`) |
| Build type | `RelWithDebInfo` |
| Install prefix | `/usr/local` (→ 바이너리: `/usr/local/bin/nvim`) |
| 로컬 소스 경로 | `~/neovim_build` (참고용, 새 환경에선 새로 clone) |

> 정확히 이 빌드를 재현하려면 아래 clone 후 `git checkout ce292026ea` 로 commit을 고정한다.
> 그냥 안정 최신을 원하면 `git checkout stable` 사용.

---

## 1. 빌드 의존성 설치

OS에 맞는 한 줄만 실행하면 된다.

```bash
# Ubuntu / Debian / WSL
sudo apt-get install ninja-build gettext cmake curl build-essential

# Fedora
sudo dnf -y install ninja-build cmake gcc make gettext curl glibc-gconv-extra

# openSUSE
sudo zypper install ninja cmake gcc-c++ gettext-tools curl

# Alpine
sudo apk add build-base cmake coreutils curl gettext-tiny-dev

# macOS (Homebrew)
brew install ninja cmake gettext curl
```

---

## 2. 소스 받기

```bash
git clone https://github.com/neovim/neovim.git ~/neovim_build
cd ~/neovim_build

# (선택) 위 기준값과 100% 동일하게 맞추려면:
git checkout ce292026ea
# 또는 안정 최신:
# git checkout stable
```

---

## 3. 빌드 → 설치

현재 설치본과 동일한 설정(`RelWithDebInfo`, prefix `/usr/local`):

```bash
cd ~/neovim_build

# 빌드 (CPU 코어 수만큼 병렬)
make CMAKE_BUILD_TYPE=RelWithDebInfo

# 설치 (/usr/local 에 들어가므로 sudo 필요)
sudo make install
```

`make` 가 내부적으로 cmake + ninja 를 호출한다 (ninja가 설치돼 있으면 자동 사용).
별도로 `cmake`/`cmake install` 명령을 직접 칠 필요 없다.

> **prefix를 바꾸고 싶다면** (예: sudo 없이 홈 디렉토리에 설치)
> ```bash
> make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local
> make install        # 이 경우 sudo 불필요
> ```
> 이후 `$HOME/.local/bin` 이 PATH에 있어야 한다.

---

## 4. 설치 확인

```bash
which nvim          # → /usr/local/bin/nvim
nvim --version      # → NVIM v0.11.x ... / Build type: RelWithDebInfo
```

처음 실행하면 이 config(`~/.config/nvim`)의 플러그인 매니저가 플러그인을 자동 설치한다.

---

## 5. 재빌드 / 업데이트

```bash
cd ~/neovim_build
git pull                      # 또는 git fetch && git checkout <원하는 commit/tag>
make distclean                # 이전 빌드 캐시 정리 (prefix 변경했을 때 특히 중요)
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

---

## 6. 제거

```bash
cd ~/neovim_build
sudo cmake --build build --target uninstall
# (build/install_manifest.txt 에 설치된 파일 목록이 남아있다)
```

---

## 트러블슈팅

- `msgfmt: command not found` → `gettext` 패키지 미설치. 위 의존성 설치 단계 다시 확인.
- 빌드 캐시가 꼬였을 때 → `make distclean` 후 재빌드.
- 설치 후에도 옛 버전이 잡힐 때 → `which -a nvim` 으로 PATH 우선순위 확인 (apt로 깐 `/usr/bin/nvim` 가 남아있을 수 있음).
