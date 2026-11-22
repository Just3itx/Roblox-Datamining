-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Dash = require(MomentsCreationParent.Dash)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local View = Foundation.View

local useMemo = React.useMemo
local useSignalState = SignalsReact.useSignalState
local useTokens = Foundation.Hooks.useTokens
local useFormFactor = MomentsCommon.Hooks.useFormFactor

local FormFactor = MomentsCommon.Enums.FormFactor
local EventNames = MomentsCommon.Analytics.EventNames
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local FFlagMomentsTextOverlayV2Redesign = MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign

local Constants = require(MomentsCreation.Constants)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local tbl1 = {
    Color3.fromHex("000000"),
    Color3.fromHex("E75750"),
    Color3.fromHex("F57630"),
    Color3.fromHex("DBA61F"),
    Color3.fromHex("0C9B5A"),
    Color3.fromHex("16A9C7"),
    Color3.fromHex("528BFF"),
    Color3.fromHex("A766F5"),
    Color3.fromHex("D540F5"),
    Color3.fromHex("E74E90")
}

local function TextColorSwatchRow(tbl2)
    local controller = tbl2.controller
    local var1 = useTokens()
    local bool1 = useFormFactor() == FormFactor.Wide

    local var2 = useMemo(function()
        return Signals.createComputed(function(arg1)
            local activeSession = controller.getActiveSession(arg1)
            local draft = if activeSession == nil then nil else activeSession.getDraft(arg1)
            local var2 = draft and draft[1]
            if var2 ~= nil then
                return var2.textOverlayStyle.fontColor
            end

            return Color3.new(0, 0, 0)
        end)
    end, { controller })
    local var3 = useSignalState(var2)

    local function onSwatchActivated(color3: Color3, num1: number)
        local activeSession = controller.getActiveSession(false)
        if activeSession == nil then
            return
        end
        local draft = activeSession.getDraft(false)
        local var4 = draft and draft[1]
        if var4 == nil then
            return
        end
        activeSession.update({ Dash.joinDeep(var4, { textOverlayStyle = { fontColor = color3 } }) })

        if FFlagMomentsTextOverlayV2Redesign then
            fireAnalyticsEvent(
                EventNames.EditingFlowTextOverlayColorSelected,
                makeCreationEventFields.makeTextOverlayEventFields({ buttonIndex = tostring(num1), color = "#" .. color3:ToHex() })
            )
        end
    end

    local tbl3 = ({})
    for layoutOrder, color3 in tbl1 do
        local bool2 = var3 == color3
        local var4 = "Swatch" .. layoutOrder
        local createElement = React.createElement
        local var5 = View
        local tbl4 = {
            LayoutOrder = layoutOrder,
            tag = "radius-circle",
            Size = UDim2.fromOffset(32, 32),
            backgroundStyle = { Color3 = color3 },
            onActivated = 0,
            stroke = 0
        }

        function tbl4.onActivated()
            onSwatchActivated(color3, layoutOrder)
        end

        tbl4.stroke = {
            Color = var1.Color.System.Contrast.Color3,
            Thickness = 3,
            Transparency = if bool2 then 0 else 0.8
        }
        tbl3[var4] = createElement(var5, tbl4)
    end

    return React.createElement(Foundation.ScrollView, {
        LayoutOrder = tbl2.LayoutOrder,
        Size = UDim2.new(1, 0, 0, Constants.TextOverlay.PickerRowHeight),
        scroll = {
            scrollBarVisibility = Foundation.Enums.Visibility.None,
            ScrollingDirection = Enum.ScrollingDirection.X,
            AutomaticCanvasSize = Enum.AutomaticSize.X
        }
    }, {
        Row = React.createElement(View, {
            tag = {
                ["row align-y-center gap-medium size-0-full auto-x padding-x-large"] = true,
                ["position-top-center anchor-top-center"] = bool1
            }
        }, tbl3)
    })
end

return TextColorSwatchRow
