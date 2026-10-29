import hashlib, json
from pathlib import Path
se = Path(r"C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e")
rows = []
for p in sorted(se.rglob("*")):
    if p.is_file() and p.name != "ARTIFACT-MANIFEST.txt":
        b = p.read_bytes()
        rows.append({"path": p.relative_to(se).as_posix(), "bytes": len(b), "sha256": hashlib.sha256(b).hexdigest()})
out = []
for r in rows:
    out.append(r["sha256"] + "  " + str(r["bytes"]) + "  " + r["path"])
(se / "ARTIFACT-MANIFEST.txt").write_text("\n".join(out) + "\n", encoding="utf-8")
print(json.dumps({"files": len(rows), "total_bytes": sum(r["bytes"] for r in rows), "manifest_bytes": (se / "ARTIFACT-MANIFEST.txt").stat().st_size}, indent=2))
