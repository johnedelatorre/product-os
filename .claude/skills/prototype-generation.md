# Skill: Claude Prototype Generation

Create clickable, self-contained HTML/React prototypes.

## When to Use

- Testing flows with users before visual design
- Getting stakeholder approval
- Communicating interactions to engineering
- Creating Claude.ai artifacts

## Quick Start

```
/product-os:prototype --from wireframes.md --flows flows.yaml
```

## Where It Goes and How to Open It

| File (in `initiatives/<initiative>/<project>/`) | How to view | Confluence |
|-------------------------------------------------|-------------|------------|
| `prototype.html`: clickable low-fi prototype, one self-contained file | Double-click to open in any browser; no install or server. Share the file or host it as static HTML | **Prototype** page under **2. Design** links to or attaches it. TBD: the publisher does not yet define attach vs hosted link; the PM decides per project |
| `prototype-react.tsx` | Paste into claude.ai and ask for an Artifact; it renders there as a clickable prototype | Link the artifact from the Prototype page |
| `prompt-pack.md` | Copy prompts into claude.ai to generate Artifacts | Not published |

In the prototype: `→`/`←` move through the flow, `a` toggles annotations.

## Output Formats

### Self-Contained HTML

Single file with embedded CSS and JS:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Prototype: [Project Name]</title>
  <style>
    /* All styles embedded */
    .screen { display: none; }
    .screen.active { display: block; }
  </style>
</head>
<body>
  <!-- SCR-001 · Landing -->
  <section id="scr-001" class="screen active">
    <h1>Welcome</h1>
    <button onclick="showScreen('scr-002')">Get Started</button>
  </section>
  
  <!-- SCR-002 · Register -->
  <section id="scr-002" class="screen">
    <h1>Create Account</h1>
    <form onsubmit="showScreen('scr-003'); return false;">
      <input placeholder="Email" required>
      <button type="submit">Sign Up</button>
    </form>
  </section>
  
  <script>
    function showScreen(id) {
      document.querySelectorAll('.screen').forEach(s => s.classList.remove('active'));
      document.getElementById(id).classList.add('active');
    }
  </script>
</body>
</html>
```

### React (Claude Artifact Compatible)

```tsx
import React, { useState } from 'react';

type Screen = 'landing' | 'register' | 'success';

export default function Prototype() {
  const [screen, setScreen] = useState<Screen>('landing');
  
  return (
    <div className="min-h-screen bg-gray-50 p-8">
      {screen === 'landing' && (
        <div className="text-center">
          <h1 className="text-3xl font-bold">Welcome</h1>
          <button 
            onClick={() => setScreen('register')}
            className="mt-4 px-6 py-2 bg-blue-600 text-white rounded"
          >
            Get Started
          </button>
        </div>
      )}
      
      {screen === 'register' && (
        <form onSubmit={(e) => { e.preventDefault(); setScreen('success'); }}>
          <h1 className="text-2xl font-bold">Create Account</h1>
          <input placeholder="Email" className="mt-4 p-2 border rounded w-full" />
          <button className="mt-4 px-6 py-2 bg-blue-600 text-white rounded w-full">
            Sign Up
          </button>
        </form>
      )}
      
      {screen === 'success' && (
        <div className="text-center">
          <h1 className="text-2xl font-bold text-green-600">Success!</h1>
        </div>
      )}
    </div>
  );
}
```

## Prompt Pack for Claude.ai

Generated prompts for manual artifact creation:

```markdown
# Prompt Pack: [Project]

## Prompt 1: Full Prototype

Create a React prototype with these screens:
1. Landing Page — Hero with CTA
2. Registration — Name, email, password form
3. Success — Confirmation message

Navigation:
- Landing → Register (click "Get Started")
- Register → Success (submit form)

Requirements:
- Self-contained React component
- useState for screen navigation
- Tailwind CSS
- Mobile-responsive
```

## Prototype Requirements

**Screen IDs (one convention everywhere):** screens are `SCR-###` (`SCR-001`, `SCR-002`, …), numbered in `wireframes.md`. The prototype section for a screen has `id="scr-###"` (lowercase, same number) and is opened by the hash link `#scr-###`; a state shown as its own section adds a suffix (`scr-002-error`). Flows (`screen_ref`), stories, critiques, UX reviews and accessibility audits cite the same IDs.

### Navigation
- All screens from flows
- Click targets navigate correctly
- Back navigation works
- No dead ends

### States
- Default state for each screen
- Loading states (simulated delay)
- Error states (accessible via keyboard shortcut)
- Success states

### Content
- Realistic content (not placeholder)
- Real data volumes
- Edge cases shown

### Annotations
- Current screen indicator
- Flow reference shown
- Toggle for design notes

## Keyboard Shortcuts

Build in for testing:

| Key | Action |
|-----|--------|
| `→` | Next screen in flow |
| `←` | Previous screen |
| `a` | Toggle annotations |
| `e` | Trigger error state |
| `r` | Reset to start |

## Quality Checklist

- [ ] All screens implemented
- [ ] Navigation matches flows
- [ ] Self-contained (no external deps)
- [ ] Realistic content
- [ ] States included (loading, error)
- [ ] Annotations toggle works
- [ ] Keyboard navigation works
- [ ] React version is Claude-compatible

## Tips

1. **Keep it simple** — prototype tests flows, not final UI
2. **Include all states** — loading, error, empty, success
3. **Make it realistic** — real content, real interactions
4. **Add annotations** — explain what's happening
5. **Test on mobile** — responsive from the start

## Related

- `/product-os:prototype` — Generate prototype
- `/product-os:wireframes` — Create wireframes first
- `.claude/agents/prototyper.md` — Full agent specification
