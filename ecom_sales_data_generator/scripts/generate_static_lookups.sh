#!/usr/bin/env bash
set -euo pipefail

CONFIG_PATH="${1:-config/ecom_sales_gen_template.yaml}"
OUTPUT_DIR="${2:-artifacts/static_lookups}"

mkdir -p "$OUTPUT_DIR"

ecomgen \
  --config "$CONFIG_PATH" \
  --output-dir "$OUTPUT_DIR" \
  --messiness-level none \
  --generate-lookups-only
