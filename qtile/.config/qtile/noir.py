palettes = {
    "base": {
        "base00": "#0f0f0f",  # background
        "base01": "#1a1a1a",  # lighter background
        "base02": "#262626",  # selection background
        "base03": "#4a4a4a",  # comments / inactive
        "base04": "#6f6f6f",  # subtle foreground
        "base05": "#bcbcbc",  # main foreground
        "base06": "#d0d0d0",  # bright foreground
        "base07": "#ffffff",  # highlight / strongest
        "base08": "#8f8f8f",  # warnings / muted red
        "base09": "#bcbcbc",  # constants
        "base0A": "#cfcfcf",  # keywords
        "base0B": "#a0a0a0",  # strings
        "base0C": "#9a9a9a",  # operators
        "base0D": "#e0e0e0",  # functions
        "base0E": "#cfcfcf",  # types
        "base0F": "#7a7a7a",  # deprecated
    },
}

def Noir(palette='base'):
    p = palettes.get(palette, palettes['base'])
    return {
        "bg": p["base00"],
        "bg_light": p["base01"],
        "select": p["base02"],
        "comment": p["base03"],
        "fg": p["base06"],
        "fg_dark": p["base04"],
        "text": p["base05"],
        "highlight": p["base07"],
        "highlight_sat": p["base08"],
        "red": "#ff0000",
        "transparent": "#00000000",
    }
