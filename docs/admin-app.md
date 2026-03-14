# Admin App

`apps/admin_app/` — admin dashboard for managing CV content. **Designed for desktop browsers** (not optimized for tablet/mobile). Uses Firebase Auth for authentication and features animated login-to-dashboard transitions.

## Theme

Electric blue accent (`#2563EB`) with square/sharp-cornered design throughout. Dark theme only. Background uses `bg.jpg` (same as cv_app) set in `web/index.html`.

## Authentication Flow

The auth feature (`packages/features/auth/`) provides:

- **LoginCard**: GradientCard with email/password form
- **Form validation**: Email regex, required fields
- **Input sanitization**: Strips injection characters (`< > " { } | \ ^` backtick)
- **Show/hide password**: Toggle visibility icon
- **ActionChip button**: Shared widget with horizontal fill animation on hover

## AdminAuthShell — Animated Transitions

`AdminAuthShell` is an app-level orchestration widget that sits above routing and manages a multi-phase animation state machine for login/dashboard transitions.

### Animation Phases

**Login → Dashboard:**
1. `fadeOutContent` — fade out login form content (300ms)
2. `morphCard` — interpolate login card position/size to nav card position (500ms)
3. `staggerNav` — stagger-animate nav items into the card
4. `revealContent` — slide in content panel from right (400ms)

**Dashboard → Login (reverse):**
1. `hideContent` — reverse content panel reveal
2. `unstaggerNav` — fade out nav items
3. `unmorphCard` — reverse card morph back to center
4. `fadeInContent` — fade in login form content

### Key Implementation Details

- Uses `BlocListener<AuthCubit, AuthState>` for state changes + `didChangeDependencies` to catch synchronous emissions during `BlocProvider.create`
- Default phase is `login` (not `initializing`) to avoid spinner flicker on load
- 4 AnimationControllers: fade, morph, contentReveal, navFade
- Exact pixel interpolation between login card (centered, 400x380) and nav card (left 24px, 250px wide, full height)

## Dashboard Layout

Two-panel layout with `Row`:
- **Nav card** (left, 250px): GradientCard with NavigationChips (stretched, full-width) + ActionChip sign out button pinned to bottom via `Spacer`
- **Content card** (right, fills remaining): GradientCard with selected content panel
- **Card transitions**: Old content card slides down off-screen, new card slides in from top (full-viewport animation using `Positioned` in a `Stack`)

Both panels use `CrossAxisAlignment.stretch` to fill available height.

## Content Pages

All content pages use a **two-column layout** (form left, item list right) with stagger animations on initial load.

### Profile

Inline editor with grouped fields:
- Name + Title in one row, About below
- Email + Phone in one row, LinkedIn + GitHub in one row
- Skills editor (chip-based with optional category)
- Languages + Interests editors side by side

### Projects

- **Left column**: Always-visible project form with type selector (Commercial/Personal), name, description, company/role or GitHub URL, tech stack (chip-based), responsibilities
- **Right column**: Scrollable project list with edit/delete actions
- **Add/Edit mode**: Button label changes; Discard button appears when form is dirty or editing
- Form populates/clears in-place via `didUpdateWidget` (no widget rebuild)

### Work Experience

- **Left column**: Always-visible experience form with title + company, date pickers (start/end with "Present" option), responsibilities
- **Right column**: Scrollable experience list with edit/delete actions
- Same Add/Edit/Discard behavior as Projects
