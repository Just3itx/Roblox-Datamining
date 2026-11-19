-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:50:43Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local _SheetType = require(script.Parent.SheetType)

return React.createContext({
    sheetHeightAvailable = nil,
    setSheetHeightAvailable = function(_: number)
        error("No SheetContext available")
    end,
    actionsHeight = nil,
    setActionsHeight = function(_: number)
        error("No SheetContext available")
    end,
    hasActionsDivider = nil,
    setHasActionsDivider = function(_: boolean)
        error("No SheetContext available")
    end,
    sheetContentHeight = nil,
    setSheetContentHeight = function(_: number)
        error("No SheetContext available")
    end,
    safeAreaPadding = nil,
    bottomPadding = nil,
    innerScrollingEnabled = nil,
    innerScrollY = nil,
    innerScrollingRef = nil,
    setInnerScrollY = function(_: number)
        error("No SheetContext available")
    end,
    hasHeader = nil,
    setHasHeader = function(_: boolean)
        error("No SheetContext available")
    end,
    hasFullBleed = false,
    fullBleedHeight = nil,
    setFullBleedHeight = function(_: number)
        error("No SheetContext available")
    end,
    hasRadius = true,
    closeSheet = nil,
    sheetType = nil,
    innerSurface = nil,
    testId = nil,
    closeAffordanceRef = nil,
    contentStartRef = nil,
    setContentStartRef = function(_) end,
    isVerticalSheetGesture = nil,
    contentRevealOffset = nil,
    setIsContentReversed = nil
})
