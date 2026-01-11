#!/usr/bin/env bash

declare -A THEME_COLORS=(
    # Core System Colors
    [transparent]="NONE"
    [none]="NONE"

    # Background Colors
    [background]="#0c0b0a"        # bg
    [background-alt]="#0d0b0a"    # bg1
    [surface]="#171513"           # bg_light
    [overlay]="#282A2D"           # fg_dark0 (used as surface/overlay)

    # Text Colors
    [text]="#282A2D" #"#a0a4a8"              # fg
    [text-muted]="#80868B"        # fg_dark1
    [text-disabled]="#3C4043"     # fg_dark

    # Border Colors
    [border]="#282A2D"             # fg_dark0
    [border-subtle]="#171513"      # bg_light
    [border-strong]="#5a6b75"      # tertiary

    # Semantic Colors (PowerKit Standard)
    [accent]="#9486a3"             # accent
    [primary]="#7691a3"            # secondary
    [secondary]="#171513"          # bg_light
    [secondary-strong]="#0c0b0a"   # bg

    # Status Colors (PowerKit Standard)
    [success]="#80a8a2"            # cyan
    [warning]="#949669"            # yellow
    [error]="#916666"              # red
    [info]="#7691a3"               # secondary

    # Interactive States
    [hover]="#171513"              # bg_light
    [active]="#5a6b75"             # tertiary
    [focus]="#9486a3"              # accent
    [disabled]="#3C4043"           # fg_dark

    # Additional Variants
    [success-subtle]="#9abfb9"     # cyan (lighter)
    [success-strong]="#5a6f6b"     # cyan (darker)
    [warning-strong]="#6e7050"     # yellow (darker)
    [error-strong]="#6b4a4a"       # red (darker)
    [info-subtle]="#8ea7b6"        # secondary (lighter)
    [info-strong]="#4f6370"        # secondary (darker)
    [error-subtle]="#a87c7c"       # red (lighter)
    [warning-subtle]="#a8aa83"     # yellow (lighter)

    # System Colors
    [white]="#ffffff"
    [black]="#0c0b0a"
)
