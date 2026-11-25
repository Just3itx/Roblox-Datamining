-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local Foundation = require(ProfilePlatformParent.Foundation)
local Toggle = Foundation.Toggle
local ToggleSize = Foundation.Enums.ToggleSize

local UIBlox = require(ProfilePlatformParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local HorizontalPageMargin = UIBlox.App.Container.HorizontalPageMargin
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel

local useDispatch = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useDispatch

local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local UserProfileSettingsNetworking = require(ProfilePlatform.Networking.UserProfileSettingsNetworking)

local refreshProfilePlatformUserProfileHeader = require(ProfilePlatform.Networking.refreshProfilePlatformUserProfileHeader)

local function UserProfileSettingsToggle(tbl1)
    local var1 = useProfileWrapperContext()
    local var2 = useStyle()
    local var3 = useDispatch()

    local onActivated = React.useCallback(function(isInExperienceNameEnabled: boolean)
        var3(
            UserProfileSettingsNetworking.SetUserProfileSettings.API({ isInExperienceNameEnabled = isInExperienceNameEnabled })
        ):andThen(
            function(arg1)
                if arg1.responseBody.successfullyUpdated then
                    var3(refreshProfilePlatformUserProfileHeader(var1.profileId))
                end
            end
        )
    end)
    return React.createElement(
        HorizontalPageMargin,
        {
            size = tbl1.size,
            layoutOrder = tbl1.layoutOrder,
            backgroundTransparency = 1
        },
        {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 8)
            }),
            Label = React.createElement(StyledTextLabel, {
                text = "In-experience name:",
                fontStyle = var2.Font.CaptionHeader,
                colorStyle = var2.Theme.TextEmphasis,
                automaticSize = Enum.AutomaticSize.XY
            }),
            Toggle = React.createElement(
                Toggle,
                {
                    label = "",
                    size = ToggleSize.Medium,
                    isChecked = tbl1.isInExperienceNameEnabled,
                    onActivated = onActivated
                }
            )
        }
    )
end

return UserProfileSettingsToggle
