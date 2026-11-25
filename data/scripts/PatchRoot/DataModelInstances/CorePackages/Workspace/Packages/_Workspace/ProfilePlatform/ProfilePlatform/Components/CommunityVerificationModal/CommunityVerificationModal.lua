-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local Enums = require(ProfilePlatform.Common.Enums)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local UIBlox = require(ProfilePlatformParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useStyle = UIBlox.Core.Style.useStyle
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local RobloxAppNavigation = require(ProfilePlatformParent.RobloxAppNavigation)
local useNavigationProps = RobloxAppNavigation.useNavigationProps
local useScreenSize = require(ProfilePlatformParent.RobloxAppHooks).useScreenSize
local UrlBuilder = require(ProfilePlatformParent.UrlBuilder).UrlBuilder
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local useDispatch = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NavigateDown = require(ProfilePlatformParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(ProfilePlatformParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then RobloxAppNavigation.NavigationCommands else nil
local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation
local getProfilePlatform = require(ProfilePlatform.Networking.getProfilePlatform)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local getAvailableCommunityComponents = require(ProfilePlatform.Hooks.getAvailableCommunityComponents)

return function()
    local var1 = useStyle()
    local var2 = useDispatch()
    local var3 = useNavigation()
    local var4 = useProfileWrapperContext()
    local screenSize = useScreenSize()

    local profileType = var4.profileType
    local profileId = var4.profileId

    local var6 = useLocalization({
        continue = TextKeys.Continue,
        cancel = TextKeys.Cancel,
        verificationRequired = TextKeys.VerificationRequired,
        contentTextHigh = TextKeys.ContentTextHigh,
        contentTextMedium = TextKeys.ContentTextMedium,
        contentTextLow = TextKeys.ContentTextLow
    })

    local var7 = useNavigationProps(function(_, arg1)
        return {
            disabledReason = arg1.disabledReason
        }
    end)

    local onActivated = React.useCallback(function()
        local tbl1 = {
            name = AppPage.GenericWebPage,
            detail = UrlBuilder.static.settings.account(),
            extraProps = {
                title = var6.verificationRequired,
                onClose = function()
                    var3.goBack()
                    var2(
                        getProfilePlatform.API({
                            profileType = profileType,
                            profileId = profileId,
                            components = getAvailableCommunityComponents(),
                            includeComponentOrdering = true
                        })
                    )
                end
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        var2(NavigateDown(tbl1))
    end, { var2, var6, var3 })

    local var5 = React.useCallback(function()
        var3.goBack()
    end, { var3 })

    local tbl1 = {
        [Enums.DisabledReasons.InsufficientVerificationLevelHigh] = var6.contentTextHigh,
        [Enums.DisabledReasons.InsufficientVerificationLevelMedium] = var6.contentTextMedium,
        [Enums.DisabledReasons.InsufficientVerificationLevelLow] = var6.contentTextLow
    }

    return React.createElement(InteractiveAlert, {
        title = var6.verificationRequired,
        screenSize = screenSize,
        middleContent = function()
            return React.createElement("Frame", {
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.XY
            }, {
                Content = React.createElement(StyledTextLabel, {
                    layoutOrder = 1,
                    text = tbl1[var7.disabledReason],
                    fontStyle = var1.Font.Body,
                    colorStyle = var1.Theme.TextDefault,
                    size = UDim2.fromScale(1, 0),
                    automaticSize = Enum.AutomaticSize.Y,
                    fluidSizing = false
                })
            })
        end,
        buttonStackInfo = {
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = var5,
                        text = var6.cancel
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onActivated,
                        text = var6.continue
                    }
                }
            },
            forcedFillDirection = Enum.FillDirection.Horizontal
        }
    })
end
