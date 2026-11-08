# Skill: UX Heuristics Evaluation

Evaluate designs against Nielsen's heuristics and Laws of UX.

## When to Use

- Evaluating design without user testing
- Training junior designers
- Quick usability assessment
- Pre-launch review

## Quick Start

```
/product-os:ux-review --designs wireframes.md --flows flows.md
```

## Nielsen's 10 Heuristics

### 1. Visibility of System Status
**Keep users informed through timely feedback.**

✅ Check for:
- Loading indicators
- Progress bars for multi-step processes
- Confirmation messages
- Current location in navigation

❌ Common violations:
- Silent form submission
- No loading state during async ops
- Unclear current step

### 2. Match Between System and Real World
**Speak the user's language.**

✅ Check for:
- Plain language (not technical jargon)
- Familiar icons and metaphors
- Natural information order

❌ Common violations:
- "404 Error" instead of "Page not found"
- Cryptic field names
- Technical error codes

### 3. User Control and Freedom
**Provide emergency exits.**

✅ Check for:
- Undo for destructive actions
- Cancel in multi-step processes
- Back navigation
- Dismiss for modals

❌ Common violations:
- No undo for delete
- Can't cancel mid-process
- Modal traps user

### 4. Consistency and Standards
**Same words and actions mean the same thing.**

✅ Check for:
- Consistent button styles
- Same terminology throughout
- Platform conventions followed

❌ Common violations:
- "Submit" vs "Save" vs "Done" for same action
- Different styles for same button type

### 5. Error Prevention
**Prevent problems before they occur.**

✅ Check for:
- Input constraints
- Confirmation for destructive actions
- Smart defaults
- Inline validation

❌ Common violations:
- Accepting invalid input
- No confirmation before delete
- Easy to make mistakes

### 6. Recognition Rather Than Recall
**Minimize memory load.**

✅ Check for:
- Visible options
- Search suggestions
- Recent items accessible
- Context provided

❌ Common violations:
- Hidden navigation
- No autocomplete
- Instructions that disappear

### 7. Flexibility and Efficiency
**Support both novice and expert users.**

✅ Check for:
- Keyboard shortcuts
- Power user features
- Customization options
- Frequent actions accessible

❌ Common violations:
- No shortcuts
- Everyone forced through same flow
- No way to customize

### 8. Aesthetic and Minimalist Design
**No irrelevant information.**

✅ Check for:
- Essential information only
- Progressive disclosure
- Clear visual hierarchy
- No clutter

❌ Common violations:
- Everything visible at once
- Competing CTAs
- Decorative elements that distract

### 9. Help Users Recover from Errors
**Express errors in plain language with solutions.**

✅ Check for:
- Human-readable messages
- Specific problem identified
- Solution suggested
- Recovery path clear

❌ Common violations:
- "Error 500"
- "Something went wrong"
- No guidance on fixing

### 10. Help and Documentation
**Provide task-focused help.**

✅ Check for:
- Easy to find help
- Task-based documentation
- Contextual help
- Search in docs

❌ Common violations:
- No help
- Technical documentation
- No contextual help

---

## Laws of UX

### Fitts's Law
**Larger, closer targets are easier to acquire.**

→ Important buttons should be large
→ Related actions close together
→ Touch targets ≥ 24×24px (WCAG 2.2 AA minimum), 44×44px recommended

### Hick's Law
**More choices = longer decision time.**

→ Limit choices per screen (≤7)
→ Use progressive disclosure
→ Provide sensible defaults

### Jakob's Law
**Users expect your site to work like others.**

→ Follow platform conventions
→ Use familiar patterns
→ Don't innovate on basics

### Miller's Law
**Working memory holds 7±2 items.**

→ Chunk information
→ Limit steps to 5-7
→ Format phone numbers

### Von Restorff Effect
**Distinctive items are remembered.**

→ Make CTAs visually distinct
→ Highlight important info
→ Don't overuse highlighting

---

## Evaluation Template

```markdown
## Heuristic Findings

### H4: Consistency and Standards

**Status:** ⚠️ Minor Issues

**Evidence:**
- "Save" button on profile, "Submit" on forms, "Done" on modals
- Primary button is blue on home, green on checkout

**Finding:**
Inconsistent button labels and colors create cognitive load.

**Severity:** Major

**Recommendation:**
1. Standardize on "Save" for data persistence
2. Use blue (#2563eb) for all primary buttons
```

## Quality Checklist

- [ ] All 10 heuristics evaluated
- [ ] Key Laws of UX checked
- [ ] Evidence documented (not opinions)
- [ ] Severity assigned
- [ ] Recommendations are concrete
- [ ] Positives noted

## Related

- `/product-os:ux-review` — Run UX evaluation
- `/product-os:critique` — Visual design critique
- `.claude/agents/ux-reviewer.md` — Full agent specification
