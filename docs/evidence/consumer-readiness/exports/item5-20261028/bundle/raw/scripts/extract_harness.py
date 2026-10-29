import hashlib, json, re
from pathlib import Path
root = Path(r"C:/src/Project Aegis/_A/remediation/handshake/four-priority-item1")
page = root / "docs/consumer-starter-package.md"
lines = page.read_bytes().split(b"\n")
# find the fenced block that starts with 'param('
fence_start = None
for i, ln in enumerate(lines):
    if ln.strip() == b'```powershell' and i + 1 < len(lines) and lines[i+1].startswith(b'param('):
        fence_start = i
        break
assert fence_start is not None, "harness fence not found"
end = None
for j in range(fence_start + 1, len(lines)):
    if lines[j].strip() == b'```':
        end = j
        break
assert end is not None, "closing fence not found"
body = b"\n".join(lines[fence_start+1:end]) + b"\n"
out = Path(r"C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e/raw/fixtures/install-starter.ps1")
out.parent.mkdir(parents=True, exist_ok=True)
out.write_bytes(body)
print(json.dumps({
  "page": str(page),
  "fence_start_line_1based": fence_start + 1,
  "param_line_1based": fence_start + 2,
  "closing_fence_line_1based": end + 1,
  "body_bytes": len(body),
  "body_lf": body.count(b"\n"),
  "body_cr": body.count(b"\r"),
  "sha256": hashlib.sha256(body).hexdigest(),
  "first_line": body.split(b"\n")[0].decode(),
  "last_line": body.rstrip(b"\n").split(b"\n")[-1].decode(),
  "starts_bom": body.startswith(b"\xef\xbb\xbf"),
}, indent=2))
