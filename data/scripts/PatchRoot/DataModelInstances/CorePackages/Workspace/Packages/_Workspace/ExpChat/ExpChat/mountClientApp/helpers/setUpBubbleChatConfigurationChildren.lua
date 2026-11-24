-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")
local ExpChat = script:FindFirstAncestor("ExpChat")

local Actions = ExpChat.Actions
local BubbleChatSettingsChanged = require(Actions.BubbleChatSettingsChanged)
local BubbleChatChildSettingChanged = require(Actions.BubbleChatChildSettingChanged)
local BubbleChatChildRemoved = require(Actions.BubbleChatChildRemoved)

local Config = require(ExpChat.Config)

local Flags = ExpChat.Flags
local getSetUpBubbleChatConfigurationChildProperties = require(Flags.getSetUpBubbleChatConfigurationChildProperties)

local DefaultBubbleChatChildrenCustomizationProperties = Config.DefaultBubbleChatChildrenCustomizationProperties
local tbl1 = {
    "ImageLabel",
    "UIGradient",
    "UICorner",
    "UIPadding"
}
local function getSettingsFromInstance(arg1)
    local var1 = DefaultBubbleChatChildrenCustomizationProperties[arg1.ClassName]
    local settingsFromInstance = ({})

    for k, _ in pairs(var1) do
        if arg1[k] ~= nil then
            settingsFromInstance[k] = arg1[k]
        end
    end

    return settingsFromInstance
end

local function connectPropertyChangedSignalsToInstance(arg1, arg2)
    local var1 = DefaultBubbleChatChildrenCustomizationProperties[arg2.ClassName]
    local result = {}

    for k, _ in pairs(var1) do
        if arg2[k] ~= nil then
            table.insert(result, (arg2:GetPropertyChangedSignal(k):Connect(function()
                arg1:dispatch(BubbleChatChildSettingChanged(arg2.ClassName, k, arg2[k]))
            end)))
        end
    end
    return result
end

local function disconnectPropertyChangedSignalsToInstance(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not arg1 then
        return
    end

    for _, value in ipairs(arg1) do
        value:Disconnect()
    end
end

local function isValidBubbleChatChild(arg1: Instance) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, value in ipairs(tbl1) do
        if value == arg1.ClassName then
            return true
        end
    end

    return false
end

return function(arg1)
    local bubbleChatConfiguration = TextChatService:FindFirstChildOfClass("BubbleChatConfiguration")
    if bubbleChatConfiguration == nil or getSetUpBubbleChatConfigurationChildProperties() == false then
        return DefaultBubbleChatChildrenCustomizationProperties
    end

    local result = {}
    local tbl2 = {}

    assert(bubbleChatConfiguration ~= nil, "BubbleChatConfiguration cannot be nil.")
    local imageLabel = bubbleChatConfiguration:FindFirstChildOfClass("ImageLabel")
    local uiGradient = bubbleChatConfiguration:FindFirstChildOfClass("UIGradient")
    local uiCorner = bubbleChatConfiguration:FindFirstChildOfClass("UICorner")
    local uiPadding = bubbleChatConfiguration:FindFirstChildOfClass("UIPadding")

    for _, value in ipairs({ imageLabel, uiGradient, uiCorner, uiPadding }) do
        if value then
            local settingsFromInstance = getSettingsFromInstance(value)
            result[value.ClassName] = settingsFromInstance

            local tbl3 = connectPropertyChangedSignalsToInstance(arg1, value)
            tbl2[value.ClassName] = tbl3
        end
    end

    bubbleChatConfiguration.ChildRemoved:Connect(function(child: Instance)
        if not isValidBubbleChatChild(child) then
            return
        end

        disconnectPropertyChangedSignalsToInstance(tbl2[child.ClassName])
        tbl2[child.ClassName] = nil
        arg1:dispatch(BubbleChatChildRemoved(child.ClassName))

        local var1 = bubbleChatConfiguration:FindFirstChildOfClass(child.ClassName)
        if var1 then
            local settingsFromInstance = getSettingsFromInstance(var1)
            arg1:dispatch(BubbleChatSettingsChanged(child.ClassName, settingsFromInstance))

            local tbl3 = connectPropertyChangedSignalsToInstance(arg1, var1)
            tbl2[var1.ClassName] = tbl3
        end
    end)

    bubbleChatConfiguration.ChildAdded:Connect(function(child: Instance)
        if isValidBubbleChatChild(child) and arg1:getState().BubbleChatSettings[child.ClassName] == nil then
            local settingsFromInstance = getSettingsFromInstance(child)
            arg1:dispatch(BubbleChatSettingsChanged(child.ClassName, settingsFromInstance))

            local tbl3 = connectPropertyChangedSignalsToInstance(arg1, child)
            tbl2[child.ClassName] = tbl3
        end
    end)

    return result
end
