-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local Localization = require(MomentsCreationParent.Localization)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local Icon = Foundation.Icon
local Menu = Foundation.Menu
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens
local useLocalization = Localization.Hooks.useLocalization
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useToggleState = MomentsCommon.Hooks.useToggleState

local useCreationController = require(MomentsCreation.CreationController).useCreationController
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)

local EventNames = MomentsCommon.Analytics.EventNames

local function VoiceBackControls()
    local var1 = useCreationController()
    local var2 = useTokens()
    local var3 = useDeviceInsets()
    local var4 = useToggleState(false)

    local var5 = useLocalization({ discard = "Feature.Moments.Action.DiscardChange", keep = "Feature.Moments.Action.KeepEditing" })

    local items = {
        {
            id = "discard",
            text = var5.discard
        },
        {
            id = "keep",
            text = var5.keep
        }
    }

    local function fireContinueEditing() -- Luacid: Inlined by compiler; 2 call sites recovered
        fireAnalyticsEvent(EventNames.EditingFlowVoiceContinueEditingPressed, makeCreationEventFields.makeVoiceEventFields())
    end

    return React.createElement(View, {
        padding = {
            top = UDim.new(0, var3.top + var2.Padding.Medium),
            left = UDim.new(0, var3.left + var2.Padding.Medium)
        },
        tag = "position-top-left anchor-top-left auto-xy",
        ZIndex = 10
    }, {
        DiscardMenu = React.createElement(Menu, {
            isOpen = var4.enabled,
            side = Foundation.Enums.PopoverSide.Bottom,
            align = Foundation.Enums.PopoverAlign.Start,
            onPressedOutside = function()
                if not var4.enabled then
                    return
                end
                var4.disable()
                fireContinueEditing()
            end,
            onActivated = function(arg1)
                var4.disable()
                if arg1 == "discard" then
                    var1.discardActiveTool()
                elseif arg1 == "keep" then
                    fireContinueEditing()
                end
            end,
            items = items
        }, {
            BackButton = React.createElement(View, {
                onActivated = function()
                    fireAnalyticsEvent(EventNames.EditingFlowVoiceBackButtonPressed, makeCreationEventFields.makeVoiceEventFields())

                    local activeSession = var1.getActiveSession(false)

                    if activeSession ~= nil and activeSession.getIsDirty(false) then
                        var4.toggle()
                        return
                    end
                    var1.commitActiveTool()
                end,
                stateLayer = {
                    affordance = Foundation.Enums.StateLayerAffordance.Background
                },
                tag = "auto-xy padding-small radius-circle"
            }, {
                BackIcon = React.createElement(Icon, {
                    name = BuilderIcons.Icon.ChevronLargeLeft,
                    size = Foundation.Enums.IconSize.Large,
                    style = var2.Color.Content.Emphasis
                })
            })
        })
    })
end

return VoiceBackControls
