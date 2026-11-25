-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommon = script:FindFirstAncestor("SocialCommon")
local SocialCommonParent = SocialCommon.Parent

local React = require(SocialCommonParent.React)
local UIBlox = require(SocialCommonParent.UIBlox)
local RoactUtils = require(SocialCommonParent.RoactUtils)
local Localization = require(SocialCommonParent.Localization)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useLocalization = Localization.Hooks.useLocalization
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local getPageMargin = UIBlox.App.Container.getPageMargin
local useIsWideMode = require(SocialCommon.Hooks.useIsWideMode)
local UserSearchBar = require(SocialCommon.Components.UserSearchBar.UserSearchBar)

local FFlagCreateConnectionsHub = require(SocialCommonParent.SharedFlags).FFlagCreateConnectionsHub

return function(arg1)
    local var1 = useIsWideMode()
    local var2 = useSelector(function(arg2)
        return arg2.ScreenSize
    end)
    local pageMargin = getPageMargin(var2.X)
    local var3 = useLocalization(
        {
            searchPlaceholderText = "Feature.AddFriends.Label.InputPlaceholder.SearchForPeopleAltCapitalization"
        }
    )

    return React.createElement(ImageSetButton, {
        BackgroundTransparency = 1,
        Size = if var1 then UDim2.fromOffset(400, 48) else UDim2.new(1, if FFlagCreateConnectionsHub then 0 else -2 * pageMargin, 0, 48),
        Position = UDim2.new(0, if FFlagCreateConnectionsHub then 0 else pageMargin, 0, 0),
        [React.Event.Activated] = arg1.onActivated
    }, {
        SearchBar = React.createElement(UserSearchBar, { isDisabled = true, searchPlaceholderText = var3.searchPlaceholderText })
    })
end
