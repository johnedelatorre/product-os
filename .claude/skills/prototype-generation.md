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
  <!-- Screen: Landing -->
  <section id="screen-landing" class="screen active">
    <h1>Welcome</h1>
    <button onclick="showScreen('screen-register')">Get Started</button>
  </section>
  
  <!-- Screen: Register -->
  <section id="screen-register" class="screen">
    <h1>Create Account</h1>
    <form onsubmit="showScreen('screen-success'); return false;">
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
