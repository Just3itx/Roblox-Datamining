-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Responsive = require(AppChatParent.Responsive)
local useIsWideMode = require(AppChatParent.SocialCommon).Hooks.useIsWideMode

local FIntAppChatWideBreakpointMinHeight = require(AppChat.Flags.FIntAppChatWideBreakpointMinHeight)
local FIntAppChatWideBreakpointMinWidth = require(AppChat.Flags.FIntAppChatWideBreakpointMinWidth)

return function(bool1: boolean): boolean
    local var1 = useIsWideMode()
    local var2 = Responsive.useOrientation()
    local bool2 = Responsive.useResponsive(
        {{
            Key = "wide",
            minWidth = FIntAppChatWideBreakpointMinWidth,
            minHeight = FIntAppChatWideBreakpointMinHeight
        }}
    ) == "wide"

    if bool1 then
        return not not (var2 ~= Responsive.Keys.Portrait and bool2)
    end

    return var1
end
