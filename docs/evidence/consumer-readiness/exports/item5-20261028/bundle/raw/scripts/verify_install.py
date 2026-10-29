import hashlib, json, re, subprocess
from pathlib import Path
se = Path(r"C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e")
env = json.loads((se / "raw/fixtures/env.json").read_text(encoding="utf-8"))
dest = Path(env["dest"]); src = Path(env["src"])
page = Path(r"C:/src/Project Aegis/_A/remediation/handshake/four-priority-item1/docs/consumer-starter-package.md")
lines = page.read_text(encoding="utf-8").split("\n")
start = next(i for i, l in enumerate(lines) if l.strip().startswith("### 2.3"))
rows = []
for l in lines[start:]:
    if l.startswith("|") and l.count("|") == 4:
        cells = [c.strip().strip(chr(96)) for c in l.strip().strip("|").split("|")]
        if len(cells) == 3 and (cells[0].startswith(".claude/") or cells[0] in ("AGENTS.md","CLAUDE.md")):
            try:
                rows.append((cells[0], int(cells[1].replace(",","")), int(cells[2].replace(",",""))))
            except ValueError:
                pass
    if l.strip().startswith("| **Total") and rows:
        break
assert len(rows) == 41, len(rows)
pin = "ffb040c7a363648856475280646bbd142dfabe4e"
def blob(path):
    return subprocess.run(["git","-C",str(src),"cat-file","blob",pin+":"+path], capture_output=True, check=True).stdout
calc = []
problems = []
for path, pbytes, plf in rows:
    p = dest / path
    if not p.is_file():
        problems.append("missing "+path); continue
    b = p.read_bytes()
    h = hashlib.sha256(b).hexdigest()
    lf = b.count(b"\n")
    bl = blob(path)
    if (len(b), lf) != (pbytes, plf):
        problems.append("page row mismatch "+path)
    if b != bl:
        problems.append("installed != pinned blob "+path)
    calc.append({"path":path,"bytes":len(b),"lf":lf,"sha256":h})
calc.sort(key=lambda r: r["path"])
serialized = "".join(str(r["path"])+"\t"+str(r["bytes"])+"\t"+str(r["lf"])+"\t"+str(r["sha256"])+"\n" for r in calc).encode("utf-8")
agg = hashlib.sha256(serialized).hexdigest()
pub = "fcff1124d9d15e7d7230fd317350e0eb3b097b453bb6b911cdc1e2485525b699"
skill_dirs = sorted({"/".join(r["path"].split("/")[:3]) for r in calc if r["path"].startswith(".claude/skills/")})
extra = []
for d in skill_dirs:
    for p in (dest / d).rglob("*"):
        if p.is_file():
            rel = p.relative_to(dest).as_posix()
            if rel not in {r["path"] for r in calc}:
                extra.append(rel)
inv = []
for p in dest.rglob("*"):
    if p.is_file() and ".git" not in p.parts:
        inv.append(p.relative_to(dest).as_posix())
record = dest / "docs/consumer-install-record.md"
rec_bytes = record.read_bytes() if record.is_file() else b""
rec_text = rec_bytes.decode("utf-8")
rec_rows = []
record_paths = []
m = re.search(r"Rows: (\d+); serialized bytes: (\d+); aggregate: ([0-9a-f]{64})", rec_text)
for l in rec_text.split("\n"):
    if l.startswith("|") and l.count("|") == 5:
        cells = [c.strip().strip(chr(96)) for c in l.strip().strip("|").split("|")]
        if len(cells) == 4 and cells[0] in {r["path"] for r in calc}:
            rec_rows.append((cells[0], int(cells[1]), int(cells[2]), cells[3]))
            record_paths.append(cells[0])
record_row_map = {r[0]: r[1:] for r in rec_rows}
record_mismatch = [r["path"] for r in calc if record_row_map.get(r["path"]) != (r["bytes"], r["lf"], r["sha256"])]
unrelated_before = json.loads((se / "raw/fixtures/unrelated-before.json").read_text(encoding="utf-8"))
unrelated_after = []
for u in unrelated_before:
    p = dest / u["path"]
    unrelated_after.append({"path":u["path"],"bytes":p.stat().st_size if p.is_file() else None,"sha256":hashlib.sha256(p.read_bytes()).hexdigest() if p.is_file() else None})
unrelated_ok = all(a["bytes"] == b["bytes"] and a["sha256"] == b["sha256"] for a,b in zip(unrelated_before, unrelated_after))
result = {
  "package_rows_parsed": len(rows),
  "installed_rows": len(calc),
  "skills": len(skill_dirs),
  "total_bytes": sum(r["bytes"] for r in calc),
  "total_lf": sum(r["lf"] for r in calc),
  "aggregate": agg,
  "published_aggregate": pub,
  "aggregate_matches": agg == pub,
  "serialized_bytes": len(serialized),
  "serialized_bytes_expected": 5420,
  "row_problems": problems,
  "extra_files_in_skill_dirs": extra,
  "destination_files_excluding_git": len(inv),
  "record_bytes": len(rec_bytes),
  "record_sha256": hashlib.sha256(rec_bytes).hexdigest(),
  "record_aggregate_line": m.groups() if m else None,
  "record_rows": len(rec_rows),
  "record_table_mismatches": record_mismatch,
  "record_row_order_matches_ordinal": record_paths == [r["path"] for r in calc],
  "unrelated_unchanged": unrelated_ok,
  "unrelated_before": unrelated_before,
  "unrelated_after": unrelated_after,
  "installed_paths": [r["path"] for r in calc],
  "rows": calc,
}
(se / "raw/fixtures/install-verify.json").write_text(json.dumps(result, indent=2), encoding="utf-8")
print(json.dumps({k:v for k,v in result.items() if k not in ("rows","installed_paths","unrelated_before","unrelated_after")}, indent=2))
