# Skill: Wireframing

Create low-fidelity wireframes that structure screens before visual design.

## When to Use

- After user flows are approved
- Before visual design begins
- Stakeholder review of layout
- Engineering estimation

## Quick Start

```
/product-os:wireframes --from flows.yaml --brief design-brief.md
```

## Where It Goes and How to View It

| File (in `initiatives/<initiative>/<project>/`) | How to view | Confluence |
|-------------------------------------------------|-------------|------------|
| `wireframes.md`: screen inventory + one ASCII wireframe per screen (`SCR-###`) with annotations | Any Markdown viewer (GitHub, VS Code, claude.ai) | **Wireframes** page under **2. Design**, via `/product-os:publish` |
| Optional HTML wireframes, e.g. `wireframes/registration.html` | Open in a browser | Linked from the Wireframes page |

Wireframes are static. For a **clickable** low-fi version, run `/product-os:prototype --from wireframes.md --flows flows.yaml`.

## Wireframe Formats

### ASCII (Default)

```
┌─────────────────────────────────────────────────────────────┐
│ SCREEN: Registration                                         │
│ FLOW: FLOW-001, Step 2                                      │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Logo                    [Already have account?]      │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Create your account                     │   │
│  │                                                      │   │
│  │  Full Name                                          │   │
│  │  ┌────────────────────────────────────────────┐     │   │
│  │  │ Jane Smith                                 │     │   │
│  │  └────────────────────────────────────────────┘     │   │
│  │                                                      │   │
│  │  Email                                              │   │
│  │  ┌────────────────────────────────────────────┐     │   │
│  │  │ jane@company.com                           │     │   │
│  │  └────────────────────────────────────────────┘     │   │
│  │                                                      │   │
│  │  ┌────────────────────────────────────────────┐     │   │
│  │  │           Create Account                    │     │   │
│  │  └────────────────────────────────────────────┘     │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### HTML (Higher Fidelity)

```html
<div class="wireframe">
  <header>Logo | Already have account?</header>
  <main>
    <h1>Create your account</h1>
    <label>Full Name</label>
    <input placeholder="Jane Smith">
    <label>Email</label>
    <input placeholder="jane@company.com">
    <button>Create Account</button>
  </main>
</div>
```

## Required Annotations

Every wireframe needs:

### 1. Interactions
```
INTERACTIONS:
- [Create Account] button: Submits form, shows loading state
- [Already have account?] link: Navigates to login
- Form fields: Validate on blur
```

### 2. Responsive Behavior
```
RESPONSIVE:
- Desktop (>1024px): Centered card, 480px max width
- Tablet (768-1024px): Same as desktop
- Mobile (<768px): Full-width with padding
```

### 3. Accessibility
```
ACCESSIBILITY:
- Focus order: Logo → Name → Email → Password → Submit
- Labels associated via htmlFor/id
- Error messages linked via aria-describedby
- Submit button disabled during loading
```

### 4. States
```
STATES:
- Default: As shown
- Loading: Button shows spinner, form disabled
- Error: Fields show red border + message
- Success: Redirect to verification
```

## Content Guidelines

| Do | Don't |
|----|-------|
| Use realistic names | Use "John Doe" |
| Show realistic data volumes | Show 3 items when users have 50 |
| Include edge cases | Only show happy path |
| Use actual copy | Use lorem ipsum |

## Screen Inventory

**Screen IDs (one convention everywhere):** screens are `SCR-###` (`SCR-001`, `SCR-002`, …), numbered in `wireframes.md`. The prototype section for a screen has `id="scr-###"` (lowercase, same number) and is opened by the hash link `#scr-###`; a state shown as its own section adds a suffix (`scr-002-error`). Flows (`screen_ref`), stories, critiques, UX reviews and accessibility audits cite the same IDs.

Create before wireframing:

```markdown
| Screen ID | Name | Flow | Step | PRD Refs |
|-----------|------|------|------|----------|
| SCR-001 | Landing | FLOW-001 | 1 | REQ-001 |
| SCR-002 | Registration | FLOW-001 | 2 | REQ-001,002 |
| SCR-003 | Verification | FLOW-001 | 4 | REQ-003 |
```

## Fidelity Levels

| Level | Focus | Exclude |
|-------|-------|---------|
| **Lo-fi** | Structure, layout, content hierarchy | Colors, final type, images |
| **Mid-fi** | Component details, spacing | Brand colors, photography |
| **Hi-fi** | Final visual design | Leave to visual designers |

Wireframes should be **lo-fi** — structure only.

## Quality Checklist

- [ ] All flow screens have wireframes
- [ ] Realistic content (no lorem ipsum)
- [ ] Annotations complete (interactions, responsive, a11y, states)
- [ ] States documented (default, loading, error, empty, success)
- [ ] Flow and PRD references included
- [ ] Screen inventory matches wireframes

## Tips

1. **Start with mobile** — forces content prioritization
2. **Gray boxes only** — no colors, no final fonts
3. **Annotate everything** — wireframes without notes are useless
4. **Include edge cases** — long names, missing data, errors
5. **Number screens** — makes references easier

## Related

- `/product-os:wireframes` — Generate wireframes
- `/product-os:flows` — Create flows first
- `/product-os:prototype` — Make wireframes clickable
- `.claude/agents/wireframer.md` — Full agent specification
