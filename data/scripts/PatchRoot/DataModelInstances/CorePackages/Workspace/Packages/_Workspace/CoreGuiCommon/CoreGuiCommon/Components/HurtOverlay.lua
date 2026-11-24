-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")

local CoreGuiCommon = script:FindFirstAncestor("CoreGuiCommon")
local CoreGuiCommonParent = CoreGuiCommon.Parent
local Constants = require(CoreGuiCommon.Constants)

local CachedPolicyService = require(CoreGuiCommonParent.CachedPolicyService)
local Foundation = require(CoreGuiCommonParent.Foundation)
local Motion = require(CoreGuiCommonParent.Motion)
local React = require(CoreGuiCommonParent.React)
local Signals = require(CoreGuiCommonParent.Signals)
local SignalsReact = require(CoreGuiCommonParent.SignalsReact)

local FFlagUseNewHurtOverlayImage = require(CoreGuiCommon.Flags).FFlagUseNewHurtOverlayImage
local FFlagUseNewHurtOverlayAnimation = require(CoreGuiCommon.Flags).FFlagUseNewHurtOverlayAnimation

local GetLocalHumanoidStore = require(CoreGuiCommon.Stores).GetLocalHumanoidStore
local Image = Foundation.Image

local crimson = Color3.fromRGB(187, 0, 4)
local white = Color3.new(1, 1, 1)

local tbl1 = { showOverlay = 0, hideOverlay = 0 }
local createState = Motion.createState
local tbl2 = {
    size = if FFlagUseNewHurtOverlayAnimation then nil else UDim2.fromScale(1.5, 1.5),
    transparency = 0
}
tbl1.showOverlay = createState(tbl2, {
    default = Motion.transition(Motion.TransitionPreset.Default, { duration = if FFlagUseNewHurtOverlayAnimation then 0.1 else 0 })
})

local createState2 = Motion.createState
local tbl3 = {
    size = if FFlagUseNewHurtOverlayAnimation then nil else UDim2.fromScale(3, 3),
    transparency = 1
}
tbl1.hideOverlay = createState2(tbl3, {
    default = Motion.transition(Motion.TransitionPreset.Default, { duration = if FFlagUseNewHurtOverlayAnimation then 0.5 else 0.3 })
})

function HurtOverlay(tbl4)
    local var1 = tbl4.mockStarterGui or StarterGui
    local var2, var3 = Motion.useMotion(tbl1.hideOverlay)

    local var4, var5 = React.useState(var1:GetCoreGuiEnabled(Enum.CoreGuiType.Health))

    local var6 = SignalsReact.useSignalState(GetLocalHumanoidStore)
    local var7 = React.useRef(var6.getHealthValue(false))

    React.useEffect(function()
        local effect = Signals.createEffect(function(arg1)
            local healthValue = var6.getHealthValue(arg1)
            local current = var7.current
            var7.current = healthValue

            if not healthValue.health
                or not healthValue.maxHealth
                or not current.health
                or healthValue.isDead and current.isDead
                or (current.health - healthValue.health) / healthValue.maxHealth < Constants.HealthPercentForOverlay
            then
                return
            end

            var3(tbl1.showOverlay, {
                onAnimationComplete = function(arg2)
                    if arg2 == true then
                        var3(tbl1.hideOverlay)
                    end
                end
            })
        end)

        local connection = var1.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
            if coreGuiType == Enum.CoreGuiType.Health or coreGuiType == Enum.CoreGuiType.All then
                var5(enabled)
            end
        end)

        return function()
            effect()
            connection:Disconnect()
        end
    end, { var6 })

    local image = if FFlagUseNewHurtOverlayImage then "rbxasset://textures/ui/TopBar/HurtOverlayAsset.png" else "rbxasset://textures/ui/TopBar/WhiteOverlayAsset.png"

    local color3 = crimson
    if CachedPolicyService:IsSubjectToChinaPolicies() then
        color3 = white
    end

    local var8

    if var4 then
        local createElement = React.createElement
        local var9 = Image

        local tbl5 = {
            tag = "anchor-center-center position-center-center",
            testId = "hurt-overlay",
            Image = image,
            imageStyle = var2.transparency:map(function(transparency)
                return { Color3 = color3, Transparency = transparency }
            end),
            ScaleType = Enum.ScaleType.Crop,
            Size = if FFlagUseNewHurtOverlayAnimation then UDim2.fromScale(1, 1) else var2.size
        }

        var8 = createElement(var9, tbl5)
    else
        var8 = nil
    end
    return var8
end

return React.memo(HurtOverlay)
