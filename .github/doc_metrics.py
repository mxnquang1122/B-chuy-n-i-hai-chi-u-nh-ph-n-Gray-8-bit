import json
import sys

if len(sys.argv) < 2:
    print("Usage: python3 .github/doc_metrics.py <metrics.json>")
    sys.exit(1)

metrics_path = sys.argv[1]

with open(metrics_path, "r", encoding="utf-8") as f:
    metrics = json.load(f)

print("=== RTL-to-GDSII Metrics ===")

keys = [
    "design__instance__count",
    "design__instance__area",
    "timing__setup__ws",
    "timing__setup__tns",
    "power__total",
]

for key in keys:
    if key in metrics:
        print(f"{key}: {metrics[key]}")

print("=== End of Metrics ===")
