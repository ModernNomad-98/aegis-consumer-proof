import hashlib, json, sys
from pathlib import Path
root = Path(sys.argv[1]); out = Path(sys.argv[2])
rows = []
for p in sorted(root.rglob("*")):
    if p.is_file() and ".git" not in p.parts:
        b = p.read_bytes()
        rows.append({"path": p.relative_to(root).as_posix(), "bytes": len(b), "sha256": hashlib.sha256(b).hexdigest()})
out.write_text(json.dumps(rows, indent=2), encoding="utf-8")
print(json.dumps({"root": str(root), "files": len(rows), "total_bytes": sum(r["bytes"] for r in rows)}))
