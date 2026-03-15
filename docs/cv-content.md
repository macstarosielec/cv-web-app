# CV Content Feature

`packages/features/cv_content/` — the presentation layer for the public-facing CV.

## Structure

```
presentation/
├── models/          # DetailPanelType enum
├── home/            # Main orchestrator
│   ├── cubit/       # ProfileCubit + ProfileState
│   └── view/
│       ├── home_page.dart           # Provides cubits via MultiBlocProvider
│       ├── home_view.dart           # HookWidget: animation, breakpoint detection, layout branching
│       └── widgets/
│           ├── desktop_layout.dart   # Row-based layout (single + multi-panel)
│           ├── mobile_layout.dart    # Column-based layout (tablet + mobile breakpoints)
│           ├── multi_panel_item.dart # Per-panel widget with entry/exit/flip animations
│           ├── detail_panel.dart     # 3D card flip between panel types (single-panel mode)
│           ├── detail_panel_content.dart # Renders cubit content per DetailPanelType
│           ├── profile_card.dart     # GradientCard composing ProfileCardContent + NavigationChipsRow
│           └── profile_card_content.dart  # Stagger-animated profile sections
├── projects/
│   ├── cubit/       # ProjectsCubit + ProjectsState
│   └── view/widgets/
│       ├── projects_list.dart       # Layout orchestrator: single vs dual column
│       ├── projects_column.dart     # Stagger-animated column of project tiles
│       └── project_tile.dart        # Individual project card with hover effects
├── experience/
│   ├── cubit/       # WorkExperienceCubit + WorkExperienceState
│   └── view/widgets/
├── contact/
│   └── view/widgets/
└── widgets/         # Shared presentation widgets
    ├── section_title.dart
    └── navigation_chips_row.dart
```

## Cubits

Each cubit uses Freezed union states (`initial`, `loading`, `loaded`, `error`):

- `ProfileCubit` — loads profile data
- `ProjectsCubit` — loads project list
- `WorkExperienceCubit` — loads work experience list

## Responsive Layout

Three breakpoints (defined in `packages/core/shared/lib/utils/breakpoints.dart`):

| Breakpoint | Width | Layout |
|------------|-------|--------|
| **Desktop** | >= 1024px | Side-by-side Row: profile card + detail panel (max 1200px) |
| **Tablet** | 600–1023px | Vertical Column: profile card collapses to chips row + detail panel below |
| **Mobile** | < 600px | Same as tablet, but chips collapse to icon-only mode |

Key behaviors:
- **Profile card collapse**: When a detail panel opens, profile content collapses vertically via `ClipRect` + `Align(heightFactor)`, leaving only navigation chips visible
- **Continuous padding**: Padding lerps from 16px (600px width) to 32px (1024px width)
- **Breakpoint-crossing reset**: Crossing desktop/non-desktop boundary with a panel open resets and replays the animation
- **3D card flip**: Detail panel transitions between panel types using `Matrix4.rotationY()` with perspective

## Multi-Panel (Ultrawide / 4K)

On wide screens, multiple detail panels can be open simultaneously:

| Screen Width | Max Panels |
|-------------|------------|
| < 1600px | 1 (standard single-panel mode) |
| 1600–2199px | 2 |
| >= 2200px | 3 |

### Layout Mechanics

Width is divided into equal **slots** (profile card = 1 slot, each panel = 1 slot, capped at 500px per slot). The projects panel dynamically takes 1 or 2 slots depending on available space.

**Dynamic project sizing**: Projects gets double width when `otherActiveCount + 2 <= maxPanels` — i.e., there are enough remaining slots. When a new panel is added and space runs out, projects shrinks to single width. When a panel is closed and space frees up, projects expands back to double.

**Dual-column project content**: When the projects panel is double-width (>= 600px), `ProjectsList` switches to a two-column layout — commercial projects on the left, personal on the right. Each column is a `ProjectsColumn` widget with its own stagger animation. The commercial column uses a `GlobalKey` to preserve state across layout transitions, while the personal column gets a new key and re-animates when switching between single/dual column modes.

### Animation Architecture

Each panel is a `MultiPanelItem` `StatefulWidget` with its own animation controllers:

- **`_sizeController`** (300ms): Drives entry (0→1) and exit (1→0) animations. Width is applied via `ClipRect` + `Align(widthFactor: progress)` so content stays full-width and slides out cleanly rather than squishing.
- **`_flipController`** (500ms): 3D card flip when the panel type changes (reused from single-panel mode).
- **`_closingWidth` / `_closingGap`**: Cached when close starts so double-width panels animate out at their original size, not the recalculated single-slot size.

The profile card uses `AnimatedContainer` for smooth width transitions between collapsed (no panels) and slot width (panels open).

### Auto-Populate

On fresh load or window maximize to multi-panel width (if user hasn't interacted), panels are added one by one in priority order (`experience` → `projects` → `contact`) with 400ms stagger between each addition. Each panel's own `_sizeController` handles the entry animation.

### Panel State Management (in `HomeView`)

- `selectedPanels: List<DetailPanelType>` — ordered list of open panels
- `closingPanels: Set<DetailPanelType>` — panels currently animating out (still in `selectedPanels` until `onPanelClosed`)
- `hasInteracted: bool` — disables auto-populate once user clicks a chip
- Width calculations use only **active** panels (excluding closing ones) so remaining panels expand to fill space as closing ones shrink out
