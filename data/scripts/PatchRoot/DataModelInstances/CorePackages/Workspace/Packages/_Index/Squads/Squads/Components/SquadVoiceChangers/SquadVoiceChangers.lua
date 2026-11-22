-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local Foundation = require(SquadsParent.Foundation)

local CrossExperienceVoice = require(SquadsParent.CrossExperienceVoice)
local CrossExperienceVoiceManager = CrossExperienceVoice.CrossExperienceVoiceManager

local dependencies = require(Squads.dependencies)

local Cryo = dependencies.Cryo
local React = require(SquadsParent.React)
local useParticipant = CrossExperienceVoice.Hooks.useParticipant
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId
local useNavigation = dependencies.useNavigation
local BuilderIcons = require(SquadsParent.BuilderIcons)

local VoicePackButton = require(script.Parent.VoicePackButton)

local Enums = Foundation.Enums
local IconSize = Enums.IconSize
local InputSize = Enums.InputSize

local tbl1 = {
    enableTestingTheme = false,
    closeCentralOverlayThunk = function()
        return { type = "CloseCentralOverlay" }
    end
}

local function SquadVoiceChangers(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1)
    local var2 = useNavigation()
    local num1 = tonumber(useLocalUserId()) or -1
    local var3 = useParticipant(num1)
    local selectedVoicePack = if var3 then var3.selectedVoicePack else nil
    local isVoiceChangerActive = if var3 then var3.isVoiceChangerActive else nil
    local isVoiceChangerHearMyselfActive = if var3 then var3.isVoiceChangerHearMyselfActive else nil
    local screenProps = var2.getScreenProps("wideMode", false)
    local str1, str2

    if var1.enableTestingTheme then
        str1 = "bg-system-warning"
        str2 = "bg-system-alert"
    else
        str1 = "bg-surface-0"
        str2 = "bg-surface-0"
    end

    local tbl2 = {}

    local tbl3 = {
        { name = "None" },
        { name = "Basic" },
        { name = "Chipmunk" },
        { name = "Robot" },
        { name = "HighPitchRobot" },
        { name = "Monster" },
        { name = "Dreamy" },
        { name = "Powerful" },
        { name = "Ghost" }
    }

    local num2 = #tbl3 + (if var1.fillListWithExtraVoicePacks then 25 else 0)

    local function makeButton(num3: number, layoutOrder: number)
        local tbl4 = tbl3[num3] or {
            name = "Voicepack " .. num3
        }
        local voicePackName = if var1.fillListWithExtraVoicePacks then tbl4.name or "Voicepack " .. num3 else tbl4.name
        local createElement = React.createElement
        local var4 = VoicePackButton
        local tbl5 = {
            LayoutOrder = layoutOrder,
            voicePackName = voicePackName,
            isVoiceChangerActive = isVoiceChangerActive,
            isSelected = if selectedVoicePack then voicePackName == selectedVoicePack else false,
            onActivated = 0
        }

        function tbl5.onActivated()
            CrossExperienceVoiceManager.default:setVoicePack(voicePackName)
            if voicePackName == "None" and isVoiceChangerActive then
                CrossExperienceVoiceManager.default:disableVoiceChanger(num1)
            elseif voicePackName ~= "None" and not isVoiceChangerActive then
                CrossExperienceVoiceManager.default:enableVoiceChanger(num1)
            end
        end

        return createElement(var4, tbl5)
    end

    for i = 1, num2 do
        tbl2["VoicePackButton_" .. i] = makeButton(i, i)
    end

    local element

    if screenProps then
        element = React.createElement(Foundation.View, {
            tag = "size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Title = React.createElement(Foundation.Text, {
                tag = "position-center-center anchor-center-center text-align-x-center text-align-y-center size-full-0 auto-xy text-heading-small radius-medium " .. str1,
                Text = "Choose voice pack",
                LayoutOrder = 1,
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changers--title" else nil
            }),
            CloseButton = React.createElement(Foundation.View, {
                tag = "position-center-left anchor-center-left auto-xy radius-circle bg-action-subtle padding-xsmall",
                ZIndex = 2,
                onActivated = var1.closeSquadVoiceChangers,
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changers--close-button" else nil
            }, {
                Icon = React.createElement(Foundation.Icon, {
                    tag = "position-center-center anchor-center-center auto-xy",
                    name = BuilderIcons.Icon.ArrowLargeLeft,
                    size = IconSize.Large
                })
            }),
            DoneButton = React.createElement(Foundation.Text, {
                Text = "Done",
                tag = "position-center-right anchor-center-right text-align-x-center text-align-y-center size-2200-0 auto-y text-label-large radius-medium padding-small text-wrap bg-action-subtle",
                LayoutOrder = 2,
                onActivated = var1.closeSquadVoiceChangers,
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changers--done-button" else nil
            })
        })
    else
        element = React.createElement(Foundation.View, {
            tag = "size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Title = React.createElement(Foundation.Text, {
                tag = "position-center-left anchor-center-left text-align-x-left text-align-y-center size-full-0 auto-xy text-heading-small radius-medium " .. str1,
                Text = "Choose voice pack",
                LayoutOrder = 1,
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changers--title" else nil
            }),
            CloseButton = React.createElement(Foundation.View, {
                tag = "position-center-right anchor-center-right auto-xy radius-circle bg-action-subtle padding-xsmall",
                LayoutOrder = 2,
                ZIndex = 2,
                onActivated = var1.closeSquadVoiceChangers,
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changers--close-button" else nil
            }, {
                Icon = React.createElement(
                    Foundation.Icon,
                    {
                        tag = "position-center-center anchor-center-center auto-xy",
                        name = BuilderIcons.Icon.X,
                        size = IconSize.Large
                    }
                )
            })
        })
    end
    return React.createElement(Foundation.View, {
        tag = "size-full-full col align-x-center align-y-top gap-large padding-large radius-medium stroke-emphasis " .. str2,
        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changers" else nil
    }, {
        TopBar = element,
        Divider = React.createElement(Foundation.Divider, { variant = Enums.DividerVariant.Default, LayoutOrder = 2 }),
        HearMyselfBar = React.createElement(Foundation.View, {
            tag = {
                ["size-full-0 auto-y row align-x-left align-y-center padding-left-xxlarge padding-right-xxlarge"] = true,
                ["bg-system-warning"] = var1.enableTestingTheme
            },
            LayoutOrder = 3
        }, {
            HearMyselfLabel = React.createElement(Foundation.Text, {
                Text = "Hear myself",
                tag = "text-align-x-left text-align-y-center size-0-0 auto-xy fill text-label-medium padding-left-large radius-medium text-wrap bg-action-subtle",
                LayoutOrder = 1,
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changers--hear-myself-label" else nil
            }),
            HearMyselfToggleHolder = React.createElement(
                Foundation.View,
                {
                    tag = "row align-x-center align-y-center size-0-0 auto-xy padding-right-large",
                    LayoutOrder = 2
                },
                {
                    HearMyselfToggle = React.createElement(Foundation.Toggle, {
                        size = InputSize.Medium,
                        label = "",
                        onActivated = function(_: boolean)
                            if isVoiceChangerHearMyselfActive then
                                CrossExperienceVoiceManager.default:disableHearMyself(num1)
                                return
                            end
                            CrossExperienceVoiceManager.default:enableHearMyself(num1)
                        end,
                        isChecked = isVoiceChangerHearMyselfActive,
                        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changers--hear-myself-toggle" else nil
                    })
                }
            )
        }),
        ButtonsView = React.createElement(Foundation.View, {
            tag = "fill padding-left-medium padding-right-medium padding-bottom-medium radius-medium size-full-full auto-y col align-x-center align-y-top " .. str1,
            LayoutOrder = 4
        }, {
            ButtonsScroller = React.createElement(Foundation.ScrollView, {
                tag = "size-full-0 fill bg-action-subtle",
                scroll = {
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.new()
                },
                BorderSizePixel = 0
            }, {
                Buttons = React.createElement(
                    Foundation.View,
                    {
                        tag = "size-full-0 auto-y col align-x-center align-y-top padding-medium fill"
                    },
                    tbl2
                )
            })
        }),
        BottomDoneButton = if screenProps then nil else React.createElement(Foundation.Text, {
            Text = "Done",
            tag = "position-center-center anchor-center-center text-align-x-center text-align-y-center size-full-0 auto-y text-label-large radius-medium padding-small text-wrap bg-action-subtle",
            LayoutOrder = 5,
            onActivated = var1.closeSquadVoiceChangers,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changers--done-button" else nil
        })
    })
end

return SquadVoiceChangers
