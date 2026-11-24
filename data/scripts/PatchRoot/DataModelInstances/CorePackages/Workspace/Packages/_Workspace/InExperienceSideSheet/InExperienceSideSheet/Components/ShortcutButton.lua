-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local React = require(InExperienceSideSheetParent.React)
local Signals = require(InExperienceSideSheetParent.Signals)
local SignalsReact = require(InExperienceSideSheetParent.SignalsReact)

local useLocalization = require(InExperienceSideSheetParent.Localization).Hooks.useLocalization

local Foundation = require(InExperienceSideSheetParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local isBuilderIcon = Foundation.Utility.isBuilderIcon
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local FoundationText = Foundation.Text
local View = Foundation.View

local Enums = require(InExperienceSideSheet.Common.Enums)
local FFlagSideSheetEmphasizeLeave = require(InExperienceSideSheet.Flags).FFlagSideSheetEmphasizeLeave

local ButtonWidth = Enums.ButtonWidth

local signal = Signals.createSignal(nil)

local function func1(transparency: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return transparency + (1 - transparency) * 0.5
end

return React.memo(function(tbl1) -- name: ShortcutButton
    local var1 = useTokens()

    local label = useLocalization({ label = tbl1.label }).label

    local var2 = SignalsReact.useSignalState(tbl1.getIsEnabled)

    local name = SignalsReact.useSignalState(tbl1.getShortcutIcon or signal)

    local onActivated = React.useCallback(function()
        tbl1.getOnActivated()()
    end, { tbl1.getOnActivated })

    local medium = IconSize.Medium
    local xSmall = var1.Gap.XSmall
    if isBuilderIcon(name) then
        medium = IconSize.XLarge
        xSmall = var1.Gap.Small
    end

    local var5 = FFlagSideSheetEmphasizeLeave and tbl1.isEmphasized == true
    local background = if var5 then var1.Color.ActionSoftEmphasis.Background else var1.Color.ActionStandard.Background
    local foreground = if var5 then var1.Color.ActionSoftEmphasis.Foreground else var1.Color.ActionStandard.Foreground
    local bool1 = (tbl1.width or ButtonWidth.Full) == ButtonWidth.Full

    return React.createElement(View, {
        tag = {
            ["row align-x-center align-y-center gap-small radius-medium"] = true,
            ["bg-action-standard"] = not var5,
            ["size-full-1000"] = bool1,
            ["fill size-0-1000"] = not bool1
        },
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, xSmall)
        },
        isDisabled = not var2,
        backgroundStyle = not var2 and {
            Color3 = background.Color3,
            Transparency = func1(background.Transparency)
        } or background,
        onActivated = onActivated,
        testId = if FFlagSideSheetEmphasizeLeave then tbl1.testId else nil,
        LayoutOrder = tbl1.layoutOrder
    }, {
        ShortcutIcon = if name then React.createElement(Icon, { name = name, size = medium, LayoutOrder = 1 }) else nil,
        Text = React.createElement(FoundationText, {
            tag = {
                ["auto-x text-label-medium"] = true,
                ["content-action-standard"] = not var5
            },
            Text = label,
            textStyle = not var2 and {
                Color3 = foreground.Color3,
                Transparency = 0.5
            } or foreground,
            LayoutOrder = 2
        })
    })
end)
