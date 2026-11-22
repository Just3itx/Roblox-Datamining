-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local Foundation = require(SquadsParent.Foundation)

local dependencies = require(Squads.dependencies)

local React = dependencies.React
local Cryo = dependencies.Cryo

local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    voicePackName = "",
    LayoutOrder = 1,
    isSelected = false,
    onActivated = function() end,
    isVoiceChangerActive = false
}

local function getVoicePackSlug(voicePackName: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.lower((string.gsub(voicePackName, "%s+", "-")))
end

local function VoicePackButton(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1)
    local testId = if FFlagSquadsEnableFoundationTestIds then var1.testId or `--social-squad-voice-changers--voice-pack-{getVoicePackSlug(var1.voicePackName)}` else nil
    local size = useTokens().Size
    local size1000 = size.Size_1000
    local size600 = size.Size_600
    local size400 = size.Size_400

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full-0 auto-y radius-medium row align-x-left align-y-center gap-large padding-x-large padding-y-xsmall",
        LayoutOrder = var1.LayoutOrder,
        onActivated = var1.onActivated,
        testId = testId
    }
    local tbl3 = {
        Label = React.createElement(Foundation.Text, {
            tag = "auto-xy fill text-align-x-left text-label-medium content-emphasis text-truncate-end text-no-wrap",
            LayoutOrder = 1,
            Text = var1.voicePackName,
            testId = if testId then `{testId}--label` else nil
        }),
        RadioButtonContainer = 0
    }

    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        Size = UDim2.new(0, 0, 0, size1000),
        tag = "auto-x row align-x-right align-y-center",
        LayoutOrder = 2
    }

    local tbl5 = { DefaultIcon = 0 }
    local createElement3 = React.createElement
    local image = Foundation.Image
    local tbl6 = {
        tag = "bg-action-subtle content-emphasis anchor-center-center position-center-center",
        Image = "component_assets/circle_24_stroke_1",
        Size = UDim2.new(0, size600, 0, size600),
        testId = if testId then `{testId}--radio` else nil
    }
    local tbl7 = {
        SelectedIcon = var1.isSelected
            and React.createElement(Foundation.Image, {
                tag = "bg-action-subtle content-emphasis anchor-center-center position-center-center",
                Image = "component_assets/circle_16",
                Size = UDim2.new(0, size400, 0, size400),
                testId = if testId then `{testId}--radio-selected` else nil
            })
    }
    tbl5.DefaultIcon = createElement3(image, tbl6, tbl7)
    tbl3.RadioButtonContainer = createElement2(view2, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end

return VoicePackButton
