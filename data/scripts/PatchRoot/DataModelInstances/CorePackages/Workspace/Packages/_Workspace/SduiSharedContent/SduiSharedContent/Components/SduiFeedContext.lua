-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:35Z
-- Luau bytecode version: 14 | Luau type version: 3
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent
local React = require(SduiSharedContentParent.React)
local _AppCommonLib = require(SduiSharedContentParent.AppCommonLib)

return React.createContext(
    {
        scrollViewPositionChangedSignal = nil,
        verticalScrollingFrameRef = nil,
        impressionsParentScrollingFrameRef = nil
    }
)
