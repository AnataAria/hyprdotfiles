import QtQuick

QtObject {
    // Scale factor from Hyprland monitor
    property real scaleFactor: 1.0

    // Bigger, more scalable metrics - all scaled by scaleFactor
    readonly property int barHeight: Math.round(44 * scaleFactor)
    readonly property int barMargin: Math.round(10 * scaleFactor)
    readonly property int barPaddingH: Math.round(20 * scaleFactor)
    readonly property int barPaddingV: Math.round(8 * scaleFactor)

    // Spacing
    readonly property int spacingTiny: Math.round(8 * scaleFactor)
    readonly property int spacingSmall: Math.round(10 * scaleFactor)
    readonly property int spacingMedium: Math.round(14 * scaleFactor)
    readonly property int spacingLarge: Math.round(18 * scaleFactor)
    readonly property int spacingXL: Math.round(24 * scaleFactor)

    // Border radius
    readonly property int radiusSmall: Math.round(6 * scaleFactor)
    readonly property int radiusMedium: Math.round(8 * scaleFactor)
    readonly property int radiusLarge: Math.round(12 * scaleFactor)

    // Icon sizes - bigger
    readonly property int iconSmall: Math.round(15 * scaleFactor)
    readonly property int iconMedium: Math.round(17 * scaleFactor)
    readonly property int iconLarge: Math.round(20 * scaleFactor)

    // Font sizes - bigger
    readonly property int fontTiny: Math.round(15 * scaleFactor)
    readonly property int fontSmall: Math.round(16 * scaleFactor)
    readonly property int fontMedium: Math.round(17 * scaleFactor)
    readonly property int fontLarge: Math.round(18 * scaleFactor)
    readonly property int fontXL: Math.round(19 * scaleFactor)
}
