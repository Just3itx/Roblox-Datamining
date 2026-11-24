-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local SignalsReact = require(ExpChatParent.SignalsReact)

local Config = require(ExpChat.Config)
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)

local function getTopbarInsetTop(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return GuiService.TopbarInset.Height
end

local function computeHeight(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.clamp(
        num1 - num2 - num3 - Config.PresetTray.ChatWindowPadding,
        Config.PresetTray.MinHeight,
        Config.PresetTray.MaxHeight
    )
end

local function useAutoTrayHeight()
    local presetChatStore = GetPresetChatStore(false)
    local var1 = SignalsReact.useSignalState(presetChatStore.getChatWindowBottomY)

    local var2, var3 = React.useState(0)
    local var4, var5 = React.useState(getTopbarInsetTop)

    React.useEffect(function()
        local connection = GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function()
            var5((getTopbarInsetTop()))
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    local var6 = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize.Y)
    end, {})

    return computeHeight(var2, var4, var1), var6
end

return useAutoTrayHeight
