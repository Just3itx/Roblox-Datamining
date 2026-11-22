-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local dependencies = require(Squads.dependencies)

local React = require(SquadsParent.React)
local Foundation = require(SquadsParent.Foundation)
local Cryo = require(SquadsParent.Cryo)

local useNavigation = dependencies.useNavigation

local SquadVoiceChangers = require(script.Parent.SquadVoiceChangers)

local tbl1 = { fillListWithExtraVoicePacks = false, enableTestingTheme = false }

function SquadVoiceChangerOverlay(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = useNavigation()
    local var3 = React.useCallback(function()
        if var2 and var2.pop then
            var2.pop()
        end
    end, { var2 })

    local screenProps = var2.getScreenProps("wideMode", false)

    local createElement = React.createElement
    local fragment = React.Fragment
    local var4 = nil
    local tbl3 = {
        AbsorbInput = React.createElement(Foundation.View, {
            tag = {
                ["size-full anchor-center-center position-center-center"] = true,
                ["bg-action-subtle"] = not var1.enableTestingTheme,
                ["bg-action-soft-emphasis"] = var1.enableTestingTheme
            },
            AutoButtonColor = false,
            BorderSizePixel = 0,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            onActivated = var3,
            ZIndex = 1,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changer-overlay--backdrop" else nil
        }),
        OverlayContainer = 0
    }

    local createElement2 = React.createElement
    local view = Foundation.View
    local tbl4 = {
        tag = {
            ["bg-action-subtle no-clip"] = true,
            ["anchor-center-center position-center-center"] = screenProps,
            ["anchor-bottom-center position-bottom-center"] = not screenProps
        },
        Size = if screenProps then UDim2.new(0.75, 0, 0.9, 0) else UDim2.new(1, 0, 0.9, 0),
        BorderSizePixel = 0,
        Selectable = true,
        onActivated = 0,
        ZIndex = 2,
        testId = 0
    }

    function tbl4.onActivated() end

    tbl4.testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-changer-overlay" else nil
    tbl3.OverlayContainer = createElement2(view, tbl4, {
        SquadVoiceChangers = React.createElement(SquadVoiceChangers, {
            closeSquadVoiceChangers = var3,
            fillListWithExtraVoicePacks = var1.fillListWithExtraVoicePacks,
            enableTestingTheme = var1.enableTestingTheme
        })
    })
    return createElement(fragment, var4, tbl3)
end

return SquadVoiceChangerOverlay
