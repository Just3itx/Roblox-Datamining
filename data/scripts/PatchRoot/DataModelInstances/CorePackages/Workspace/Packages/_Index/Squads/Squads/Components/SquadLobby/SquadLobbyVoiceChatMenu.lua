-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")

local SquadsParent = Squads.Parent
local CrossExperienceVoice = require(SquadsParent.CrossExperienceVoice)
local UIBlox = require(SquadsParent.UIBlox)
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId

local dependencies = require(Squads.dependencies)

local Foundation = dependencies.Foundation
local React = dependencies.React
local GameSettings = UserSettings().GameSettings
local engineFeature = game:GetEngineFeature("PartyVoiceVolume")
local Cryo = require(SquadsParent.Cryo)

local Flags = Squads.Flags
local SharedFlags = require(SquadsParent.SharedFlags)

local ContextualSlider = UIBlox.App.Slider.ContextualSlider
local CrossExperienceVoiceManager = CrossExperienceVoice.CrossExperienceVoiceManager
local PresenceType = dependencies.RoduxPresence.Enums.PresenceType
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local useEnableAudioFocusToggle = CrossExperienceVoice.Hooks.useEnableAudioFocusToggle
local useIsVoiceFocused = CrossExperienceVoice.Hooks.useIsVoiceFocused
local useSelector = dependencies.Hooks.useSelector
local useTokens = Foundation.Hooks.useTokens
local useLocalization = dependencies.Hooks.useLocalization

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local useCurrentSquadParentChannelId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadParentChannelId

local FFlagSquadVoiceMenuFoundationRefactor = require(Flags.FFlagSquadVoiceMenuFoundationRefactor)
local FFlagSquadsEnableFoundationTestIds = require(Flags.FFlagSquadsEnableFoundationTestIds)
local FFlagEnablePartyVoiceChangersInLua = SharedFlags.FFlagEnablePartyVoiceChangersInLua

local FFlagSquadsPresenceStoreMigration = require(SquadsParent.SquadsCore.Flags).FFlagSquadsPresenceStoreMigration
local useGetPresenceByUserId = if FFlagSquadsPresenceStoreMigration then require(SquadsParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local PresenceType2 = if FFlagSquadsPresenceStoreMigration then require(SquadsParent.DataHydration).Presence.PresenceEnums.PresenceType else nil
local component_assetsCircle_24_stroke_1 = Images["component_assets/circle_24_stroke_1"]
local component_assetsCircle_16 = Images["component_assets/circle_16"]

local tbl1 = {
    forceEnableAudioFocusToggle = false,
    forceShowVoiceChangerSection = false,
    openSquadVoiceChangers = function() end
}

local function func1(tbl2)
    local var1 = useTokens()

    local createElement = React.createElement
    local view = Foundation.View
    local var2 = FFlagSquadVoiceMenuFoundationRefactor
        and {
            tag = "size-full-0 auto-y padding-y-small col gap-small",
            LayoutOrder = tbl2.LayoutOrder,
            testId = tbl2.testId
        }
        or {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            padding = {
                top = UDim.new(0, var1.Padding.Small),
                bottom = UDim.new(0, var1.Padding.Small)
            },
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, var1.Gap.Small)
            },
            LayoutOrder = tbl2.LayoutOrder,
            testId = tbl2.testId
        }
    local tbl3 = { Label = 0, SliderWrapper = 0 }
    local createElement2 = React.createElement
    local foundationText = Foundation.Text
    local tbl4

    if FFlagSquadVoiceMenuFoundationRefactor then
        tbl4 = {
            tag = "auto-xy text-truncate-end text-no-wrap text-align-x-left text-label-medium content-emphasis",
            LayoutOrder = 1,
            Text = tbl2.labelText,
            testId = if FFlagSquadsEnableFoundationTestIds then `{tbl2.testId}--label` else nil
        }
    else
        tbl4 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            fontStyle = var1.Typography.LabelMedium,
            textStyle = var1.Color.Content.Emphasis,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 1,
            Text = tbl2.labelText,
            testId = if FFlagSquadsEnableFoundationTestIds then `{tbl2.testId}--label` else nil
        }
    end

    tbl3.Label = createElement2(foundationText, tbl4)

    tbl3.SliderWrapper = React.createElement(
        Foundation.View,
        FFlagSquadVoiceMenuFoundationRefactor and { tag = "size-full-0 auto-y", LayoutOrder = 2 }
            or {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2
            },
        {
            Slider = React.createElement(ContextualSlider, {
                width = UDim.new(1, 0),
                stepInterval = 0.1,
                min = 0,
                max = 1,
                value = tbl2.sliderValue,
                onValueChanged = tbl2.onValueChanged
            })
        }
    )
    return createElement(view, var2, tbl3)
end

local function func2(tbl2)
    local var1 = useTokens()

    local color3 = var1.Color.Content.Emphasis.Color3
    local emphasisTransparency = var1.Color.Content.Emphasis.Transparency

    local createElement = React.createElement
    local view = Foundation.View
    local var2 = FFlagSquadVoiceMenuFoundationRefactor
        and {
            tag = "size-full-0 auto-y padding-x-large padding-y-xsmall row align-x-left align-y-center gap-large",
            LayoutOrder = tbl2.LayoutOrder,
            onActivated = tbl2.onActivated,
            testId = tbl2.testId
        }
        or {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            padding = Vector2.new(var1.Padding.Large, var1.Padding.XSmall),
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, var1.Gap.Large)
            },
            LayoutOrder = tbl2.LayoutOrder,
            onActivated = tbl2.onActivated,
            testId = tbl2.testId
        }
    local tbl3 = {
        Icon = React.createElement(ImageSetLabel, {
            Size = UDim2.fromOffset(24, 24),
            BackgroundTransparency = 1,
            Image = tbl2.icon,
            ImageColor3 = color3,
            ImageTransparency = emphasisTransparency,
            LayoutOrder = 1
        }),
        Label = 0,
        RadioButtonContainer = 0
    }

    local createElement2 = React.createElement
    local foundationText = Foundation.Text
    local tbl4

    if FFlagSquadVoiceMenuFoundationRefactor then
        tbl4 = {
            tag = "auto-xy fill text-truncate-end text-no-wrap text-align-x-left text-label-medium content-emphasis",
            LayoutOrder = 2,
            Text = tbl2.labelText,
            testId = if FFlagSquadsEnableFoundationTestIds then `{tbl2.testId}--label` else nil
        }
    else
        tbl4 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            flexItem = {
                FlexMode = Enum.UIFlexMode.Fill
            },
            fontStyle = var1.Typography.LabelMedium,
            textStyle = var1.Color.Content.Emphasis,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2,
            Text = tbl2.labelText,
            testId = if FFlagSquadsEnableFoundationTestIds then `{tbl2.testId}--label` else nil
        }
    end

    tbl3.Label = createElement2(foundationText, tbl4)

    tbl3.RadioButtonContainer = React.createElement(
        Foundation.View,
        FFlagSquadVoiceMenuFoundationRefactor
            and {
                tag = "auto-x row align-x-right align-y-center",
                Size = UDim2.new(0, 0, 0, 40),
                LayoutOrder = 3
            }
            or {
                Size = UDim2.new(0, 0, 0, 40),
                AutomaticSize = Enum.AutomaticSize.X,
                layout = {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                },
                LayoutOrder = 3
            },
        {
            DefaultIcon = React.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Image = component_assetsCircle_24_stroke_1,
                Size = UDim2.new(0, 24, 0, 24),
                ImageColor3 = color3,
                ImageTransparency = emphasisTransparency,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }, {
                SelectedIcon = tbl2.isSelected
                    and React.createElement(ImageSetLabel, {
                        BackgroundTransparency = 1,
                        Image = component_assetsCircle_16,
                        Size = UDim2.new(0, 16, 0, 16),
                        ImageColor3 = color3,
                        ImageTransparency = emphasisTransparency,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    })
            })
        }
    )
    return createElement(view, var2, tbl3)
end

return function(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useTokens()
    local var3 = useLocalUserId()
    local isSelected = useIsVoiceFocused()
    local var5 = useEnableAudioFocusToggle()
    local var6 = React.useContext(SquadExternalContractContext)

    local var7 = React.useCallback(function(arg1)
        return arg1.Squad.Presence.byUserId[tostring(var3)]
    end, { var3 })

    local var8 = if FFlagSquadsPresenceStoreMigration then useGetPresenceByUserId(tostring(var3)) else useSelector(var7)

    local var9 = React.useMemo(function()
        return var8
            and var8.userPresenceType == (if FFlagSquadsPresenceStoreMigration then PresenceType2.InGame else PresenceType.InGame)
    end, { var8 })

    local labelText = React.useMemo(function()
        return if var8 and var9 then var8.lastLocation else nil
    end, { var8, var9 })

    local var11 = useCurrentSquadParentChannelId()

    local var4 = var6.useParentChannelTitleSelector(var11 or "")

    local var13 = React.useCallback(function()
        CrossExperienceVoiceManager.default:toggleAudioFocus()
    end, {})

    local bool1 = engineFeature
    local var14 = var9 or not bool1
    local var15 = bool1 and var14
    local var16 = var9 and (var5 or var1.forceEnableAudioFocusToggle)

    local sliderValue, var18 = React.useState(if engineFeature then GameSettings.PartyVoiceVolume else 0)
    local var10, var20 = React.useState(GameSettings.MasterVolume)

    local var21 = useLocalization({
        volumeLabelText = "Feature.Squads.Label.Volume",
        partyVolumeLabelText = "Feature.Squads.Label.PartyVolume",
        experienceLabelText = "Feature.Squads.Label.Experience",
        voiceChatsLabelText = "Feature.Squads.Label.VoiceChats",
        partyLabelText = "Feature.Squads.Label.Party"
    })
    local var12 = if var15 then var21.partyLabelText else var21.partyVolumeLabelText
    local var17 = if bool1 then var21.experienceLabelText else var21.volumeLabelText

    local onActivated = React.useCallback(function()
        if not isSelected then
            var13()
        end
    end, { isSelected, var13 })

    local var19 = React.useCallback(function()
        if isSelected then
            var13()
        end
    end, { isSelected, var13 })

    local var22 = React.useCallback(function()
        if var1.openSquadVoiceChangers then
            var1.openSquadVoiceChangers()
        end
    end, { var1.openSquadVoiceChangers })

    local createElement = React.createElement
    local view = Foundation.View
    local var27 = FFlagSquadVoiceMenuFoundationRefactor
        and {
            tag = "size-full-0 auto-y padding-y-small radius-medium bg-surface-300 col",
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu" else nil
        }
        or {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            padding = Vector2.new(0, var2.Padding.Small),
            cornerRadius = UDim.new(0, var2.Radius.Medium),
            backgroundStyle = var2.Color.Surface.Surface_300,
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            },
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu" else nil
        }
    local tbl3 = {
        VolumeSection = React.createElement(
            Foundation.View,
            FFlagSquadVoiceMenuFoundationRefactor and {
                tag = "size-full-0 auto-y padding-x-large col",
                LayoutOrder = 1
            }
                or {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    padding = Vector2.new(var2.Padding.Large, 0),
                    layout = {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    },
                    LayoutOrder = 1
                },
            {
                VolumeLabel = var15
                    and React.createElement(
                        Foundation.Text,
                        FFlagSquadVoiceMenuFoundationRefactor
                            and {
                                tag = "auto-xy text-truncate-end text-no-wrap text-align-x-left padding-y-xsmall text-title-small content-muted",
                                LayoutOrder = 1,
                                Text = var21.volumeLabelText,
                                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--volume-label" else nil
                            }
                            or {
                                AutomaticSize = Enum.AutomaticSize.XY,
                                fontStyle = var2.Typography.TitleSmall,
                                textStyle = var2.Color.Content.Muted,
                                TextTruncate = Enum.TextTruncate.AtEnd,
                                TextWrapped = false,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                LayoutOrder = 1,
                                padding = Vector2.new(0, var2.Padding.XSmall),
                                Text = var21.volumeLabelText,
                                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--volume-label" else nil
                            }
                    ),
                PartySliderGroup = bool1
                    and React.createElement(func1, {
                        LayoutOrder = 2,
                        labelText = var12,
                        sliderValue = sliderValue,
                        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--party-volume" else nil,
                        onValueChanged = function(partyVoiceVolume: number)
                            GameSettings.PartyVoiceVolume = partyVoiceVolume
                            var18(partyVoiceVolume)
                        end
                    }),
                ExperienceSliderGroup = var14
                    and React.createElement(func1, {
                        LayoutOrder = 3,
                        labelText = var17,
                        sliderValue = var10,
                        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--experience-volume" else nil,
                        onValueChanged = function(masterVolume: number)
                            GameSettings.MasterVolume = masterVolume
                            var20(masterVolume)
                        end
                    })
            }
        ),
        Divider = var16
            and React.createElement(
                Foundation.View,
                FFlagSquadVoiceMenuFoundationRefactor and {
                    tag = "size-full-0 auto-y padding-y-small",
                    LayoutOrder = 2
                }
                    or {
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 2,
                        padding = Vector2.new(0, var2.Padding.Small)
                    },
                {
                    Divider = React.createElement(Foundation.View, { Size = UDim2.new(1, 0, 0, 1), backgroundStyle = var2.Color.Stroke.Default })
                }
            ),
        VoiceChatSection = var16
            and React.createElement(
                Foundation.View,
                FFlagSquadVoiceMenuFoundationRefactor and {
                    tag = "size-full-0 auto-y col",
                    LayoutOrder = 3
                }
                    or {
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        layout = {
                            FillDirection = Enum.FillDirection.Vertical,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        },
                        LayoutOrder = 3
                    },
                {
                    VoiceChatLabel = React.createElement(
                        Foundation.Text,
                        FFlagSquadVoiceMenuFoundationRefactor
                            and {
                                tag = "auto-xy text-truncate-end text-no-wrap text-align-x-left padding-x-large padding-y-xsmall text-title-small content-muted",
                                LayoutOrder = 1,
                                Text = var21.voiceChatsLabelText,
                                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--voice-chats-label" else nil
                            }
                            or {
                                AutomaticSize = Enum.AutomaticSize.XY,
                                fontStyle = var2.Typography.TitleSmall,
                                textStyle = var2.Color.Content.Muted,
                                TextTruncate = Enum.TextTruncate.AtEnd,
                                TextWrapped = false,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                LayoutOrder = 1,
                                padding = Vector2.new(var2.Padding.Large, var2.Padding.XSmall),
                                Text = var21.voiceChatsLabelText,
                                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--voice-chats-label" else nil
                            }
                    ),
                    PartySelector = React.createElement(func2, {
                        icon = Images["icons/menu/platformChatOff"],
                        LayoutOrder = 2,
                        labelText = var4 or "",
                        isSelected = isSelected,
                        onActivated = onActivated,
                        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--party-voice-selector" else nil
                    }),
                    ExperienceSelector = React.createElement(func2, {
                        icon = Images["icons/menu/publicChatOff"],
                        LayoutOrder = 3,
                        labelText = labelText or "",
                        isSelected = not isSelected,
                        onActivated = var19,
                        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--experience-voice-selector" else nil
                    })
                }
            ),
        VoiceChangerSection = 0
    }

    local element

    if FFlagEnablePartyVoiceChangersInLua or var1.forceShowVoiceChangerSection then
        element = React.createElement(Foundation.View, {
            tag = "size-full-0 auto-y col",
            LayoutOrder = 4
        }, {
            VoiceChangerSectionLabel = React.createElement(Foundation.Text, {
                tag = "auto-xy text-truncate-end text-no-wrap text-align-x-left padding-x-large padding-y-xsmall text-title-small content-muted",
                LayoutOrder = 1,
                Text = "Voice changers",
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--voice-changers-label" else nil
            }),
            OpenVoiceChangerModal = React.createElement(Foundation.View, {
                tag = "size-full-0 auto-y row align-x-left align-y-center gap-large padding-x-large padding-y-xsmall",
                LayoutOrder = 2,
                onActivated = var22,
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--choose-voice-pack-button" else nil
            }, {
                ChooseVoicePackLabel = React.createElement(Foundation.Text, {
                    tag = "auto-xy text-truncate-end text-no-wrap text-align-x-left fill text-label-medium content-emphasis",
                    Size = UDim2.new(1, 0, 0, 40),
                    LayoutOrder = 1,
                    Text = "Choose voice pack",
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-chat-menu--choose-voice-pack-button--label" else nil
                }),
                OpenIcon = React.createElement(Foundation.Icon, { LayoutOrder = 2, name = "chevron-large-right" })
            })
        })
    else
        element = nil
    end

    tbl3.VoiceChangerSection = element
    return createElement(view, var27, tbl3)
end
