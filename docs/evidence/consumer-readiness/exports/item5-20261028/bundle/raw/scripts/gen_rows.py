import json, hashlib
from pathlib import Path
se = Path(r"C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e")
v = json.loads((se / "raw/fixtures/install-verify.json").read_text(encoding="utf-8"))
lines = ["| Path (consumer-relative) | Bytes | LF | SHA-256 |", "| --- | --- | --- | --- |"]
for r in v["rows"]:
    lines.append("| " + r["path"] + " | " + str(r["bytes"]) + " | " + str(r["lf"]) + " | " + r["sha256"] + " |")
lines.append("| **Total: 41 files** | **369093** | **5841** | " + v["aggregate"] + " |")
(se / "raw/fixtures/rows-table.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
print("\n".join(lines))
v1 = Path(r"C:/src/Project Aegis/_A/remediation/handshake/four-priority-item1/docs/evidence/consumer-readiness/local-starter-v1.md").read_bytes()
print("V1_BYTES=" + str(len(v1)) + " V1_LF=" + str(v1.count(bytes([10]))) + " V1_SHA=" + hashlib.sha256(v1).hexdigest())
