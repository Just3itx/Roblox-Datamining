-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local UIBlox = require(ProfilePlatformParent.UIBlox)
local useTokens = require(ProfilePlatformParent.Foundation).Hooks.useTokens
local getPageMargin = UIBlox.App.Container.getPageMargin
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local useIsMeTab = require(ProfilePlatform.Hooks.useIsMeTab)
local Enums = require(ProfilePlatform.Common.Enums)
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab

return function()
    local var1 = if FFlagAXEnableProfileTab then useTokens() else nil
    local var2 = if FFlagAXEnableProfileTab then useIsMeTab() else nil
    local bool1 = if FFlagAXEnableProfileTab then useProfileFormFactor().formFactor == Enums.ProfileFormFactor.Wide else nil
    local var3, var4 = React.useState(24)

    local var5 = React.useCallback(function(arg1)
        local pageMargin = getPageMargin(arg1.AbsoluteSize.X)
        var4(pageMargin)
    end, {})

    local large = if FFlagAXEnableProfileTab then if bool1 then var1.Margin.Large else var1.Padding.Large else nil

    if FFlagAXEnableProfileTab and var2 then
        var3 = large
    end

    return var3, var5
end
