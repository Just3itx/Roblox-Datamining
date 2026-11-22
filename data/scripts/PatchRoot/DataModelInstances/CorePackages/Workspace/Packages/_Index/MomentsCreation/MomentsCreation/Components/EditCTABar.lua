-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local Localization = require(MomentsCreationParent.Localization)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local EventNames = MomentsCommon.Analytics.EventNames

local function fireVoiceCoachmarkFtuxEvent(str1: string)
    fireAnalyticsEvent(str1, {
        userId = tostring(if Players.LocalPlayer then Players.LocalPlayer.UserId else 0),
        timestamp = tostring(os.time()),
        identifier = "moments_tts_voice"
    })
end

local EducationalTooltip = Foundation.EducationalTooltip
local Icon = Foundation.Icon
local Loading = Foundation.Loading
local FoundationText = Foundation.Text
local View = Foundation.View

local GradientBackdrop = MomentsCommon.Components.GradientBackdrop
local GetFFlagEnableMomentTextGeneration = MomentsCommon.Flags.GetFFlagEnableMomentTextGeneration
local GetFFlagMomentsCoachmarkPersistence = MomentsCommon.Flags.GetFFlagMomentsCoachmarkPersistence
local GetFIntMomentsCoachmarkMaxImpressions = MomentsCommon.Flags.GetFIntMomentsCoachmarkMaxImpressions
local GetFIntMomentsCoachmarkAutoDismissSeconds = MomentsCommon.Flags.GetFIntMomentsCoachmarkAutoDismissSeconds

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens

local useCreationController = require(MomentsCreation.CreationController).useCreationController

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function VoiceCoachmark(tbl1)
    local var1 = useCreationController()
    local var2 = useLocalization({ title = tbl1.titleKey, text = tbl1.textKey })

    local var3, var4 = React.useState(function(): boolean
        return not var1.getVoiceCoachmarkDismissed(false)
    end)

    local var5 = React.useRef(false)
    React.useEffect(function()
        if var3 and not var5.current then
            var5.current = true
            fireVoiceCoachmarkFtuxEvent(EventNames.FTUXTooltipImpression)
        end
    end, { var3 })

    if not var3 then
        return tbl1.children
    end

    return React.createElement(EducationalTooltip, {
        LayoutOrder = tbl1.layoutOrder,
        isOpen = not tbl1.hidden,
        onClose = function()
            fireVoiceCoachmarkFtuxEvent(EventNames.FTUXTooltipDismissed)
            var1.dismissVoiceCoachmark()
            var4(false)
        end,
        side = Foundation.Enums.PopoverSide.Bottom,
        align = Foundation.Enums.PopoverAlign.End,
        title = var2.title,
        text = var2.text
    }, tbl1.children)
end

local function PersistentToolCoachmark(tbl1)
    local var1 = useCreationController()
    local var2 = useLocalization({ title = tbl1.titleKey, text = tbl1.textKey })

    local persistentCoachmark = require(MomentsCreationParent.MomentsCommon.PersistentCoachmark)

    return React.createElement(persistentCoachmark, {
        layoutOrder = tbl1.layoutOrder,
        title = var2.title,
        text = var2.text,
        impressionCache = tbl1.impressionCache,
        maxImpressions = tbl1.maxImpressions,
        autoDismissSeconds = tbl1.autoDismissSeconds,
        isSessionHandled = var1.getVoiceCoachmarkDismissed(false),
        onSessionHandled = var1.dismissVoiceCoachmark,
        onImpression = function()
            fireVoiceCoachmarkFtuxEvent(EventNames.FTUXTooltipImpression)
        end,
        onDismissed = function()
            fireVoiceCoachmarkFtuxEvent(EventNames.FTUXTooltipDismissed)
        end,
        side = Foundation.Enums.PopoverSide.Bottom,
        align = Foundation.Enums.PopoverAlign.End,
        hidden = tbl1.hidden
    }, tbl1.children)
end

return function(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()

    local isLoadingMap = tbl1.isLoadingMap
    local isDisabledMap = tbl1.isDisabledMap

    local scale = var2.Size.Size_600 / var2.Size.Size_1200

    local tbl2 = {}
    for _, tool in tbl1.tools do
        tbl2[tool.cta.localizationKey] = tool.cta.localizationKey
    end
    local var4 = useLocalization(tbl2)

    local size, var6 = React.useBinding(UDim2.fromScale(1, 0))

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var6(UDim2.new(0, 1.5 * arg1.AbsoluteSize.X, 1, 0))
    end, {})

    local tbl3 = ({})

    local coachmark = tbl1.coachmark

    for k, tool in tbl1.tools do
        local kind = tool.kind
        local bool1 = not (isLoadingMap == nil) and isLoadingMap[kind] == true
        local bool2 = not (isDisabledMap == nil) and isDisabledMap[kind] == true
        local createElement = React.createElement
        local var8 = View

        local tbl4 = {
            LayoutOrder = tool.cta.order or k,
            onActivated = if bool1 then nil else not bool2 and function()
                tbl1.onToolSelected(kind)
            end or tbl1.onDisabledToolActivated ~= nil and function()
                tbl1.onDisabledToolActivated(kind)
            end or nil,
            tag = "row align-x-right align-y-center gap-medium auto-xy padding-xsmall radius-medium"
        }

        local tbl5 = { Icon = 0, Text = 0 }
        local element

        if bool1 then
            if GetFFlagEnableMomentTextGeneration() then
                local createElement2 = React.createElement
                local var9 = View

                local tbl6 = {
                    Loading = React.createElement(Loading, { size = Foundation.Enums.IconSize.Large })
                }
                element = createElement2(var9, { LayoutOrder = 2, tag = "auto-xy", scale = scale }, tbl6)
            else
                element = React.createElement(Loading, { LayoutOrder = 2, size = Foundation.Enums.IconSize.Small })
            end
        else
            element = React.createElement(Icon, { name = tool.cta.icon, LayoutOrder = 2, size = Foundation.Enums.IconSize.Large })
        end

        tbl5.Icon = element
        local element2 = if tbl1.showText then React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                tag = "auto-xy text-label-medium content-emphasis",
                Text = var4[tool.cta.localizationKey]
            }
        ) else nil
        tbl5.Text = element2
        local element3 = createElement(var8, tbl4, tbl5)

        if coachmark == nil or coachmark.kind ~= kind then
            tbl3["Tool_" .. kind] = element3
        elseif GetFFlagMomentsCoachmarkPersistence() and coachmark.impressionCache ~= nil then
            local var9 = "Tool_" .. kind
            tbl3[var9] = React.createElement(PersistentToolCoachmark, {
                layoutOrder = tool.cta.order or k,
                titleKey = coachmark.titleKey,
                textKey = coachmark.textKey,
                impressionCache = coachmark.impressionCache,
                maxImpressions = coachmark.maxImpressions or GetFIntMomentsCoachmarkMaxImpressions(),
                autoDismissSeconds = coachmark.autoDismissSeconds or GetFIntMomentsCoachmarkAutoDismissSeconds(),
                hidden = tbl1.hidden
            }, element3)
        else
            local var9 = "Tool_" .. kind
            tbl3[var9] = React.createElement(
                VoiceCoachmark,
                {
                    layoutOrder = tool.cta.order or k,
                    titleKey = coachmark.titleKey,
                    textKey = coachmark.textKey,
                    hidden = tbl1.hidden
                },
                element3
            )
        end
    end
    return React.createElement(View, {
        tag = "position-center-right anchor-center-right size-0-full auto-x",
        Visible = not tbl1.hidden,
        ZIndex = tbl1.zIndex
    }, {
        GradientBackdrop = React.createElement(GradientBackdrop, { color3 = var2.Color.Common.Scrim.Color3, rotation = 180, size = size }),
        EditCTABar = React.createElement(View, {
            tag = "col align-x-right align-y-center gap-small position-center-right anchor-center-right size-0-full auto-x",
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            padding = {
                left = UDim.new(0, var2.Padding.Large),
                right = UDim.new(0, var1.right + var2.Padding.Large)
            }
        }, tbl3)
    })
end
