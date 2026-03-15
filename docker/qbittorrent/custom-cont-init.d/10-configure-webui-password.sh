#!/usr/bin/with-contenv bash
set -eu

if [ -z "${QBITTORRENT_WEBUI_PASSWORD:-}" ]; then
  echo "[qbittorrent-webui-password] QBITTORRENT_WEBUI_PASSWORD is empty; keeping qBittorrent's generated password behavior."
  exit 0
fi

config_dir="/config/qBittorrent"
config_file="${config_dir}/qBittorrent.conf"

mkdir -p "${config_dir}"

python3 - "${config_file}" <<'PY'
import base64
import hashlib
import os
import pathlib
import sys

config_path = pathlib.Path(sys.argv[1])
password = os.environ["QBITTORRENT_WEBUI_PASSWORD"]

salt = os.urandom(16)
password_hash = hashlib.pbkdf2_hmac("sha512", password.encode("utf-8"), salt, 100000)
config_value = '@ByteArray({}:{})'.format(
    base64.b64encode(salt).decode("ascii"),
    base64.b64encode(password_hash).decode("ascii"),
)

if config_path.exists():
    lines = config_path.read_text(encoding="utf-8").splitlines()
else:
    lines = ["[LegalNotice]", "Accepted=true", "", "[Preferences]"]

lines = [
    line for line in lines
    if not line.startswith("WebUI\\Password_PBKDF2=")
    and not line.startswith("WebUI\\Password_ha1=")
]

if "[Preferences]" not in lines:
    if lines and lines[-1] != "":
        lines.append("")
    lines.append("[Preferences]")

pref_index = lines.index("[Preferences]")
insert_at = pref_index + 1

while insert_at < len(lines):
    line = lines[insert_at]
    if line.startswith("[") and line.endswith("]"):
        break
    insert_at += 1

lines.insert(insert_at, f'WebUI\\Password_PBKDF2="{config_value}"')

config_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
PY

echo "[qbittorrent-webui-password] Applied password from QBITTORRENT_WEBUI_PASSWORD to ${config_file}."
