-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local AnimatedChipGroupContainer = require(script.Parent.AnimatedChipGroup.AnimatedChipGroupContainer)
local _chatTypes = require(BuildExperience.Chat.chatTypes)

local FFlagBuildExperienceFTUXChipExhaustedTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceFTUXChipExhaustedTelemetry)

local FIntBuildExperienceFTUXChipExhaustedThresholdPx = require(BuildExperience.Flags.FIntBuildExperienceFTUXChipExhaustedThresholdPx)

local FFlagBuildExperienceFTUXChipLoadInAnimation = require(BuildExperience.Flags.FFlagBuildExperienceFTUXChipLoadInAnimation)

local ChipGroup = Foundation.ChipGroup
local ChipGroupVariant = Foundation.Enums.ChipGroupVariant
local ChipSize = Foundation.Enums.ChipSize
local IconName = Foundation.Enums.IconName
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function getIconName(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.value == "2D" then
        return IconName.SquareCheck
    elseif arg1.value == "3D" then
        return IconName.CubeVertexes
    end

    return IconName.PlusLarge
end

local function useChipExhaustionListener(tbl1)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(false)

    React.useEffect(function()
        var2.current = false
    end, { tbl1.promptChips })

    React.useEffect(function()
        if tbl1.onExhausted == nil then
            return
        end

        local current = var1.current
        if current == nil then
            return
        end

        local var3 = current:FindFirstChildWhichIsA("ScrollingFrame", true)
        if var3 == nil then
            return
        end

        local connection = var3:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            local var4 = var3.AbsoluteCanvasSize.X - var3.AbsoluteWindowSize.X

            if var4 > 0 and var3.CanvasPosition.X >= var4 - FIntBuildExperienceFTUXChipExhaustedThresholdPx and not var2.current then
                var2.current = true
                tbl1.onExhausted()
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { tbl1.onExhausted, tbl1.promptChips, tbl1.isLoading })

    return var1
end

local function PromptChipGroup(tbl1)
    local var1 = useTokens()
    local var2 = if FFlagBuildExperienceFTUXChipExhaustedTelemetry then useChipExhaustionListener(tbl1) else nil
    local chips = ({})
    for k, promptChip in tbl1.promptChips do
        local onActivated = tbl1.onActivated
        local tbl3 = {
            text = promptChip.value,
            leading = getIconName(promptChip),
            onActivated = onActivated ~= nil and function()
                onActivated(promptChip)
            end or nil
        }

        chips[k] = tbl3
    end

    local tbl3 = ({})
    for layoutOrder = 1, 3 do
        local str1 = `Skeleton{layoutOrder}`
        tbl3[str1] = React.createElement(Skeleton, {
            LayoutOrder = layoutOrder,
            radius = Radius.Circle,
            Size = UDim2.fromOffset(var1.Size.Size_2800, var1.Size.Size_800),
            testId = `PromptChipGroup.Skeleton{layoutOrder}`
        })
    end

    local createElement = React.createElement
    local var3 = View
    local tbl4 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col size-full-0 auto-y padding-bottom-large padding-top-small clip",
        testId = "PromptChipGroup"
    }

    local tbl5 = { Content = 0 }
    local element

    if tbl1.isLoading then
        element = React.createElement(View, { tag = "row gap-small size-full-0 auto-y", testId = "PromptChipGroup.Skeletons" }, tbl3)
    elseif FFlagBuildExperienceFTUXChipLoadInAnimation and #chips > 0 then
        element = React.createElement(AnimatedChipGroupContainer, { chips = chips, chipGroupRef = var2 })
    else
        local createElement2 = React.createElement
        local var4 = ChipGroup
        local tbl6 = {
            chips = chips,
            size = ChipSize.Medium,
            variant = ChipGroupVariant.Row,
            ref = 0,
            testId = "PromptChipGroup.Chips"
        }

        if not FFlagBuildExperienceFTUXChipExhaustedTelemetry then
            var2 = nil
        end

        tbl6.ref = var2
        element = createElement2(var4, tbl6)
    end

    tbl5.Content = element
    return createElement(var3, tbl4, tbl5)
end

return PromptChipGroup
