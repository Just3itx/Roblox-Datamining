-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)
local useNavigation = require(AmpV2WizardParent.Navigation).useNavigation
local useDispatch = require(AmpV2WizardParent.RoactUtils).Hooks.RoactRodux.useDispatch

local Foundation = require(AmpV2WizardParent.Foundation)
local Loading = Foundation.Loading
local IconSize = Foundation.Enums.IconSize

local _Types = require(AmpV2Wizard.Types)
local FFlagAmpV2WizardRetryAmp = require(AmpV2Wizard.Flags.FFlagAmpV2WizardRetryAmp)

local function createUpsellNode(callback: (...any) -> (...any))
    local function UpsellNode(arg1)
        local props = arg1.props
        local ctx = arg1.ctx
        local report = arg1.report
        local navigation = useNavigation()
        local dispatch = useDispatch()

        React.useEffect(function()
            callback({ navigation = navigation, dispatch = dispatch }, props, ctx, report)
        end, FFlagAmpV2WizardRetryAmp and { props } or {})

        return React.createElement(
            Loading,
            {
                size = IconSize.Medium,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            }
        )
    end
    return UpsellNode
end

return createUpsellNode
