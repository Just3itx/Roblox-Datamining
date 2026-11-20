-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)

local useVoiceState = require(RobloxGui.Modules.VoiceChat.Hooks.useVoiceState)
local Constants = require(RobloxGui.Modules.VoiceChat.Constants)
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local uDim2 = UDim2.fromOffset(36, 36)

local function useJoinBinding(tbl1: {any}) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.useMemo(function()
        return Roact.joinBindings(tbl1)
    end, {})
end

local function mapLevelToIcon(iconStyle) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1)
        local var1 = arg1[1]
        local var2 = arg1[2]
        if var1 == Constants.VOICE_STATE.MUTED or var1 == Constants.VOICE_STATE.LOCAL_MUTED then
            return default:GetIcon("Muted", iconStyle)
        end

        if var1 == Constants.VOICE_STATE.CONNECTING then
            return default:GetIcon("Connecting", iconStyle)
        end

        if var1 == Constants.VOICE_STATE.INACTIVE then
            return default:GetIcon("Unmuted0", iconStyle)
        end

        if var1 ~= Constants.VOICE_STATE.TALKING then
            return default:GetIcon("Error", iconStyle)
        end

        local num1 = math.floor(0.5 + 5 * var2) * 20
        return default:GetIcon("Unmuted" .. tostring(num1), iconStyle)
    end
end

local function GenerateGUID(): string
    return HttpService:GenerateGUID()
end

local function VRBarVoiceIcon(tbl1)
    local var1 = useVoiceState(tbl1.userId, tbl1.disable or false)
    local var2, var3 = React.useBinding(0)
    local var4, var5 = React.useBinding(var1)
    local var6 = useJoinBinding({ var4, var2 })
    local current = React.useRef(GenerateGUID()).current or ""
    var5(var1)

    local bool1 = var1 == Constants.VOICE_STATE.TALKING

    React.useEffect(function()
        if bool1 then
            RunService:BindToRenderStep(current, 1, function()
                var3(math.random())
            end)
        end
        return function()
            if bool1 then
                RunService:UnbindFromRenderStep(current)
            end
        end
    end, { bool1 })

    local image = React.useMemo(function()
        return var6:map((mapLevelToIcon(tbl1.iconStyle)))
    end, { tbl1.iconStyle })

    return Roact.createElement("ImageLabel", {
        BackgroundTransparency = tbl1.BackgroundTransparency or 1,
        Image = image,
        ImageColor3 = tbl1.ImageColor3,
        ImageTransparency = tbl1.ImageTransparency,
        Position = tbl1.Position,
        Size = tbl1.Size or uDim2,
        [Roact.Children] = tbl1[Roact.Children]
    })
end

return VRBarVoiceIcon
