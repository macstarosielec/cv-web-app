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
│           ├── desktop_layout.dart   # Row-based layout (desktop breakpoint)
│           ├── mobile_layout.dart    # Column-based layout (tablet + mobile breakpoints)
│           ├── profile_card.dart     # GradientCard composing ProfileCardContent + NavigationChipsRow
│           ├── profile_card_content.dart  # Stagger-animated profile sections
│           └── detail_panel.dart     # 3D card flip between panel types
├── projects/
│   ├── cubit/       # ProjectsCubit + ProjectsState
│   └── view/widgets/
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
