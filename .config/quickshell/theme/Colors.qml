import QtQuick

QtObject {
    // Modern dark theme with glassmorphism vibes
    readonly property color bg: "transparent"
    readonly property color bgBlur: "#0f0f0f"
    readonly property color bgCard: "#18181b"
    readonly property color bgCardHover: "#27272a"
    readonly property color bgHighlight: "#fda4af"

    // Modern accent - vibrant pink/rose
    readonly property color accent: "#fda4af"
    readonly property color accentFg: "#18181b"
    readonly property color accentHover: "#fb7185"
    readonly property color accentDim: "#9f1239"
    readonly property color accentBright: "#fecdd3"

    // High contrast modern text
    readonly property color fg: "#fafafa"
    readonly property color fgDim: "#71717a"
    readonly property color fgMuted: "#52525b"

    // Modern status colors
    readonly property color success: "#86efac"
    readonly property color warning: "#fcd34d"
    readonly property color error: "#fca5a5"
    readonly property color info: "#93c5fd"
    readonly property color purple: "#c084fc"
    readonly property color cyan: "#67e8f9"

    // Workspace colors
    readonly property color workspaceActive: accent
    readonly property color workspaceInactive: "#3f3f46"
    readonly property color workspaceOccupied: "#71717a"
}
