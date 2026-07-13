# TODO NOT READY
{
  lib,
  rustPlatform,
  nodejs,
  cargo-tauri,
  pkg-config,
  stdenv,
  glib-networking,
  openssl,
  webkitgtk_4_1,
  fetchPnpmDeps,
  pnpm_11,
  pnpmConfigHook,
  wrapGAppsHook4,
  fetchFromGitHub,
  nix-update-script,
}:
let
  pnpm = pnpm_11;
in
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "pot-translation";
  version = "3.0.7";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "pot-app";
    repo = "pot-desktop";
    tag = finalAttrs.version;
    hash = "sha256-0Q1hf1AGAZv6jt05tV3F6++lzLpddvjhiykIhV40cPs=";
  };

  cargoHash = "sha256-dyXINRttgsqCfmgtZNXxr/Rl8Yn0F2AVm8v2Ao+OBsw=";

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    glib-networking # Most Tauri apps need networking
    openssl
    webkitgtk_4_1
  ];

  nativeBuildInputs = [
    nodejs
    cargo-tauri.hook
    pkg-config
    pnpm
    pnpmConfigHook
    wrapGAppsHook4
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    inherit pnpm;
    fetcherVersion = 4;
    hash = "sha256-nspe4au3f2G1DSV+tYKqYpbA2JhKNWXJWYY8OplvbTs=";
  };

  cargoRoot = "src-tauri";
  buildAndTestSubdir = finalAttrs.cargoRoot;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "一个跨平台的划词翻译和OCR软件 | A cross-platform software for text translation and recognition";
    homepage = "https://github.com/pot-app/pot-desktop";
    changelog = "https://github.com/pot-app/pot-desktop/blob/${finalAttrs.src.rev}/CHANGELOG";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ god464 ];
    mainProgram = "pot-translation";
    platforms = lib.platforms.all;
  };
})
