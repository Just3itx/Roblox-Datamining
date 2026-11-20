-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local Signals = require(CorePackages.Packages.Signals)
local Otter = require(CorePackages.Packages.Otter)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local CachedPolicyService = require(CorePackages.Workspace.Packages.CachedPolicyService)

local _Common = RobloxGui:FindFirstChild("Modules"):FindFirstChild("Common")

local scriptParentParentParent = script.Parent.Parent.Parent
local Constants = require(scriptParentParentParent.Constants)

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagTopBarSignalizeHealthBar = CoreGuiCommon.Flags.FFlagTopBarSignalizeHealthBar
local FFlagUseNewHurtOverlayImage = CoreGuiCommon.Flags.FFlagUseNewHurtOverlayImage
local FFlagUseNewHurtOverlayAnimation = CoreGuiCommon.Flags.FFlagUseNewHurtOverlayAnimation

local tbl1 = { frequency = 0.75, dampingRatio = 1 }

local crimson = Color3.fromRGB(187, 0, 4)
local white = Color3.new(1, 1, 1)

local var1 = Roact.PureComponent:extend("HurtOverlay")

var1.validateProps = t.strictInterface(
    FFlagTopBarSignalizeHealthBar and {}
        or {
            healthEnabled = t.boolean,
            health = t.number,
            maxHealth = t.number,
            isDead = t.boolean
        }
)
function var1.init(arg1)
    local animationBinding, animationBindingUpdate = Roact.createBinding(0)
    arg1.animationBinding = animationBinding
    arg1.animationBindingUpdate = animationBindingUpdate

    if not FFlagUseNewHurtOverlayAnimation then
        arg1.positionBinding = arg1.animationBinding:map(function(arg2): UDim2
            return UDim2.new(-10 * arg2, 0, -10 * arg2, 0)
        end)
        arg1.sizeBinding = arg1.animationBinding:map(function(arg2): UDim2
            return UDim2.new(1 + 19 * arg2, 0, 1 + 19 * arg2, 0)
        end)
    end

    if FFlagTopBarSignalizeHealthBar then
        local isAnimating, setIsAnimating = Roact.createBinding(false)
        arg1.isAnimating = isAnimating
        arg1.setIsAnimating = setIsAnimating
        local health, setHealth = Roact.createBinding(Constants.InitialHealth)
        arg1.health = health
        arg1.setHealth = setHealth
        local maxHealth, setMaxHealth = Roact.createBinding(Constants.InitialHealth)
        arg1.maxHealth = maxHealth
        arg1.setMaxHealth = setMaxHealth
        local isDead, setIsDead = Roact.createBinding(false)
        arg1.isDead = isDead
        arg1.setIsDead = setIsDead
        arg1.prevHealth = arg1.health:getValue()
        arg1.prevIsDead = arg1.isDead:getValue()

        arg1.showHurtOverlay = Roact.joinBindings({ arg1.isAnimating, arg1.health, arg1.maxHealth, arg1.isDead }):map(function(arg2)
            local var12 = arg2[1]
            local var2 = arg2[2]
            local var14 = arg2[3]
            local var3 = arg2[4]
            local prevHealth = arg1.prevHealth
            local prevIsDead = arg1.prevIsDead

            arg1.prevHealth = var2
            arg1.prevIsDead = var3

            if not (var2 < prevHealth)
                or var3 and prevIsDead
                or not ((prevHealth - var2) / var14 >= Constants.HealthPercentForOverlay)
            then
                return var12
            end

            if FFlagUseNewHurtOverlayAnimation then
                arg1.setIsAnimating(true)
                arg1.motor:setGoal(Otter.ease(0, { duration = 0.1 }))
                arg1.motor:start()
            else
                arg1.motor:setGoal(Otter.instant(0))
                arg1.motor:step(0)
                arg1.motor:setGoal(Otter.spring(1, tbl1))
                arg1.motor:start()
                arg1.setIsAnimating(true)
            end
            return true
        end)

        if CoreGuiCommon.Stores.GetLocalHumanoidStore then
            arg1.localHumanoidStore = CoreGuiCommon.Stores.GetLocalHumanoidStore(false)
            arg1.disposeHealthConnection = Signals.createEffect(function(arg2)
                local healthValue = arg1.localHumanoidStore.getHealthValue(arg2)

                arg1.setHealth(healthValue.health or Constants.InitialHealth)
                arg1.setMaxHealth(healthValue.maxHealth or Constants.InitialHealth)
                arg1.setIsDead(healthValue.isDead)
            end)
        end
    else
        arg1.state = { isAnimating = false }
    end

    arg1.motor = Otter.createSingleMotor(if FFlagUseNewHurtOverlayAnimation then 1 else 0)
    arg1.motor:onStep(function(arg2)
        arg1.animationBindingUpdate(arg2)
    end)
    arg1.motor:onComplete(FFlagUseNewHurtOverlayAnimation and function(arg2)
        if arg2 == 0 then
            arg1.motor:setGoal(Otter.ease(1, { duration = 0.5 }))
            arg1.motor:start()
            return
        end

        if arg2 ~= 1 then
            return
        end

        if FFlagTopBarSignalizeHealthBar then
            arg1.setIsAnimating(false)
            return
        end
        arg1:setState({ isAnimating = false })
    end or function()
        if FFlagTopBarSignalizeHealthBar then
            arg1.setIsAnimating(false)
            return
        end
        arg1:setState({ isAnimating = false })
    end)

    if not FFlagTopBarSignalizeHealthBar then
        return
    end

    local function getHealthEnabled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Health)
    end

    arg1.coreGuiChangedSignalConn = StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
        if coreGuiType == Enum.CoreGuiType.Health or coreGuiType == Enum.CoreGuiType.All then
            arg1:setState({ mountHurtOverlay = enabled })
        end
    end)

    arg1:setState({ mountHurtOverlay = getHealthEnabled() })
end

function var1.renderOverlay(arg1)
    local isAnimating = if FFlagTopBarSignalizeHealthBar then nil else arg1.props.healthEnabled and arg1.state.isAnimating
    local image = if FFlagUseNewHurtOverlayImage then "rbxasset://textures/ui/TopBar/HurtOverlayAsset.png" else "rbxasset://textures/ui/TopBar/WhiteOverlayAsset.png"

    local color3 = crimson
    if CachedPolicyService:IsSubjectToChinaPolicies() then
        color3 = white
    end

    local createElement = Roact.createElement
    local str2 = "ImageLabel"
    local tbl2 = {
        Visible = 0,
        BackgroundTransparency = 1,
        Image = 0,
        ImageColor3 = 0,
        ImageTransparency = 0,
        Size = 0,
        AnchorPoint = 0,
        Position = 0
    }

    if FFlagTopBarSignalizeHealthBar then
        isAnimating = arg1.showHurtOverlay
    end

    tbl2.Visible = isAnimating

    tbl2.Image = image
    tbl2.ImageColor3 = color3
    tbl2.ImageTransparency = if FFlagUseNewHurtOverlayAnimation then arg1.animationBinding else nil
    tbl2.Size = if FFlagUseNewHurtOverlayAnimation then UDim2.fromScale(1, 1) else arg1.sizeBinding
    tbl2.AnchorPoint = if FFlagUseNewHurtOverlayAnimation then Vector2.new(0.5, 0.5) else nil
    tbl2.Position = if FFlagUseNewHurtOverlayAnimation then UDim2.fromScale(0.5, 0.5) else arg1.positionBinding
    return createElement(str2, tbl2)
end

function var1.render(arg1)
    if FFlagTopBarSignalizeHealthBar then
        if arg1.state.mountHurtOverlay then
            return (arg1:renderOverlay())
        end

        return nil
    end
    return arg1:renderOverlay()
end

function var1.didUpdate(arg1, arg2, _)
    if FFlagTopBarSignalizeHealthBar then
        return
    end

    if not (arg1.props.health < arg2.health)
        or arg1.props.isDead and arg2.isDead
        or not ((arg2.health - arg1.props.health) / arg1.props.maxHealth >= Constants.HealthPercentForOverlay)
    then
        return
    end

    arg1.motor:setGoal(Otter.instant(0))
    arg1.motor:step(0)
    arg1.motor:setGoal(Otter.spring(1, tbl1))
    arg1.motor:start()
    arg1:setState({ isAnimating = true })
end

if FFlagTopBarSignalizeHealthBar then
    function var1.onUnmount(arg1)
        arg1.coreGuiChangedSignalConn:Disconnect()
        arg1.disposeHealthConnection()
    end
end

local function mapStateToProps(arg1)
    return {
        health = arg1.health.currentHealth,
        maxHealth = arg1.health.maxHealth,
        isDead = arg1.health.isDead,
        healthEnabled = arg1.coreGuiEnabled[Enum.CoreGuiType.Health]
    }
end

if FFlagTopBarSignalizeHealthBar then
    return var1
end
return RoactRodux.UNSTABLE_connect2(mapStateToProps, nil)(var1)
