-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local GameInvite = script:FindFirstAncestor("GameInvite")
local Context = GameInvite.Context
local GameInviteParent = GameInvite.Parent

local SharedFlags = require(GameInviteParent.SharedFlags)
local React = require(GameInviteParent.React)
local _gameInviteModalType = require(GameInvite.gameInviteModalType)
local GameInviteModalLayoutContext = require(Context.GameInviteModalLayoutContext)

local GetFFlagLuaAppEnableTopBanner = SharedFlags.GetFFlagLuaAppEnableTopBanner
local isInExperienceUIVREnabled = require(GameInviteParent.SharedExperimentDefinition).isInExperienceUIVREnabled
local FFlagEnableInExperienceUIPCVRFix = SharedFlags.FFlagEnableInExperienceUIPCVRFix

local function func1(bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    local num1

    if GetFFlagLuaAppEnableTopBanner() and not bool1 then
        num1 = 0
    else
        if GuiService then
            return GuiService:GetGuiInset().Y
        end

        num1 = 50
    end

    return num1
end

local function func2(): Vector2 -- Luacid: Inlined by compiler; 3 call sites recovered
    return workspace.CurrentCamera.ViewportSize
end

local function func3(arg1): boolean -- Luacid: Inlined by compiler; 11 call sites recovered
    return arg1 < 800
end

local function func4(arg1): boolean -- Luacid: Inlined by compiler; 11 call sites recovered
    return arg1 < 624
end

local function func6(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (func3(arg1.X) or func4(arg1.Y)) and arg1.X or 800
end

local function func7(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return (func3(arg1.X) or func4(arg1.Y)) and arg1.Y - func1(arg2) or 624
end

local function func5(arg1, isCoreScript): UDim2
    local uDim = UDim.new(0, func6(arg1))
    local uDim2 = UDim.new(0, func7(arg1, isCoreScript))
    return UDim2.new(uDim, uDim2)
end

local function _(arg1): string -- Luacid: unused: defined but never referenced
    return if func3(arg1.X) or func4(arg1.Y) then "compact" else "default"
end

return function(tbl1)
    local isCoreScript = tbl1.isCoreScript
    local var1 = if isInExperienceUIVREnabled and FFlagEnableInExperienceUIPCVRFix and tbl1.screenSizeOverride then tbl1.screenSizeOverride else func2()
    local modalSize, var3 = React.useState(func5(var1, isCoreScript))
    local isFullHeight, var5 = React.useState(not not func4(var1.Y))
    local isFullWidth, var7 = React.useState(not not func3(var1.X))
    local modalMode, var9 = React.useState(if func3(var1.X) then "compact" elseif func4(var1.Y) then "compact" else "default")

    local var10 = not FFlagEnableInExperienceUIPCVRFix and function()
        local viewportSize = func2()

        local bool1 = not not func4(viewportSize.Y)
        local bool2 = not not func3(viewportSize.X)
        local uDim2 = func5(viewportSize, isCoreScript)

        var5(bool1)
        var7(bool2)
        var3(uDim2)
        var9(if func3(viewportSize.X) then "compact" elseif func4(viewportSize.Y) then "compact" else "default")
    end or React.useCallback(function()
        local viewportSize = func2()

        local bool1 = not not func4(viewportSize.Y)
        local bool2 = not not func3(viewportSize.X)
        local uDim2 = func5(viewportSize, isCoreScript)

        var5(bool1)
        var7(bool2)
        var3(uDim2)
        var9(if func3(viewportSize.X) then "compact" elseif func4(viewportSize.Y) then "compact" else "default")
    end, { isCoreScript })

    React.useEffect(function()
        if isInExperienceUIVREnabled and FFlagEnableInExperienceUIPCVRFix and tbl1.screenSizeOverride then
            return function() end
        end

        var10()
        local connection = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(var10)

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, not isInExperienceUIVREnabled and {} or FFlagEnableInExperienceUIPCVRFix and { tbl1.screenSizeOverride, var10 } or {})

    return React.createElement(
        GameInviteModalLayoutContext.Provider,
        {
            value = {
                isFullHeight = isFullHeight,
                isFullWidth = isFullWidth,
                modalSize = modalSize,
                modalMode = modalMode
            }
        },
        tbl1.children
    )
end
