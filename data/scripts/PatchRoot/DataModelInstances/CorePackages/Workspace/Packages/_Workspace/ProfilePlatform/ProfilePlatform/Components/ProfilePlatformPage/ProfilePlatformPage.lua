-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Cryo = require(ProfilePlatformParent.Cryo)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local React = require(ProfilePlatformParent.React)
local useStyle = UIBlox.Core.Style.useStyle

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileScrollContext = require(ProfilePlatform.Contexts.ProfileScrollContext.useProfileScrollContext)
local getPeekViewOpenHeightByProfileType = require(ProfilePlatform.Utils.getPeekViewOpenHeightByProfileType)
local FFlagProfilePlatformEnableImpressions = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableImpressions

local function ProfilePlatformPage(tbl1)
    local profileType = useProfileWrapperContext().profileType

    local var1 = useProfileScrollContext()

    local var2 = useProfileFormFactor()
    local bool1 = var2.formFactor == Enums.ProfileFormFactor.Wide
    local isFullView = var2.isFullView

    local theme = useStyle().Theme
    local var3 = if FFlagProfilePlatformEnableImpressions then useProfileAnalyticsContext() else nil
    local scrollViewPositionChangedSignal = if FFlagProfilePlatformEnableImpressions then var3.scrollViewPositionChangedSignal else nil
    local var4 = Cryo.Dictionary.join({
        bottomPadding = React.createElement("Frame", { Size = UDim2.fromOffset(0, 8), BackgroundTransparency = 1, LayoutOrder = 99999 })
    }, tbl1.children)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, getPeekViewOpenHeightByProfileType(profileType)),
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        BackgroundTransparency = if profileType == Enums.ProfileTypes.Community and not (bool1 or isFullView) then theme.BackgroundContrast.Transparency else theme.BackgroundDefault.Transparency,
        BackgroundColor3 = if profileType == Enums.ProfileTypes.Community and not (bool1 or isFullView) then theme.BackgroundContrast.Color else theme.BackgroundDefault.Color
    }

    tbl2[React.Change.AbsolutePosition] = function(arg1)
        var1.setAbsoluteYPosition(arg1.AbsolutePosition.Y)
        scrollViewPositionChangedSignal:fire()
    end

    return createElement(str1, tbl2, var4)
end

return ProfilePlatformPage
