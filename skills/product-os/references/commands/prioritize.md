---
description: "Score and prioritize features using frameworks."
argument-hint: "--items <prd.md|features.md> --framework <rice|wsjf|moscow|kano>"
---
# /product-os:prioritize

Score and prioritize features using frameworks.

## Usage
```
/product-os:prioritize --items <prd.md|features.md> --framework <rice|wsjf|moscow|kano>
```

## Frameworks
- **RICE**: Reach × Impact × Confidence ÷ Effort
- **WSJF**: Cost of Delay ÷ Job Duration
- **MoSCoW**: Must/Should/Could/Won't
- **Kano**: Basic/Performance/Delighter

## Output
- `prioritization.md` — Scored and ranked items
- `priority-matrix.csv` — Export for spreadsheets

## Agent
Uses: `strategist.md`
