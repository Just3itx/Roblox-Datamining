-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local SharedFlags = require(SplitPaneParent.SharedFlags)

local SplitPaneVariant = require(script.Parent.SplitPaneVariant)

local FFlagEnableSplitPane = SharedFlags.FFlagEnableSplitPane
local FFlagEnableSplitPaneAvatarOverlay = SharedFlags.FFlagEnableSplitPaneAvatarOverlay
local FFlagSplitPaneEducationalTour = SharedFlags.FFlagSplitPaneEducationalTour

local function isSplitPaneTourSupported()
    return FFlagEnableSplitPane
        and FFlagEnableSplitPaneAvatarOverlay
        and FFlagSplitPaneEducationalTour
        and SplitPaneVariant.isEducationModalEnabled()
end

return isSplitPaneTourSupported
