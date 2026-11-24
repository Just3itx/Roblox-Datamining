-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local Config = require(ExpChat.Config)

return function(arg1)
    local result = {}
    for k, _ in pairs(Config.DefaultBubbleChatMessagePropertiesInstanceSettings) do
        result[k] = arg1[k]
    end

    local imageLabel = arg1:FindFirstChildOfClass("ImageLabel")
    if imageLabel then
        local tbl1 = ({})
        for k, _ in pairs(Config.DefaultBubbleChatChildrenCustomizationProperties.ImageLabel) do
            tbl1[k] = imageLabel[k]
        end
        result.ImageLabel = tbl1
    end

    local uiGradient = arg1:FindFirstChildOfClass("UIGradient")
    if uiGradient then
        local tbl1 = ({})
        for k, _ in pairs(Config.DefaultBubbleChatChildrenCustomizationProperties.UIGradient) do
            tbl1[k] = uiGradient[k]
        end
        result.UIGradient = tbl1
    end

    local uiCorner = arg1:FindFirstChildOfClass("UICorner")
    if uiCorner then
        local tbl1 = ({})
        for k, _ in pairs(Config.DefaultBubbleChatChildrenCustomizationProperties.UICorner) do
            tbl1[k] = uiCorner[k]
        end
        result.UICorner = tbl1
    end
    local uiPadding = arg1:FindFirstChildOfClass("UIPadding")
    if uiPadding then
        local tbl1 = ({})
        for k, _ in pairs(Config.DefaultBubbleChatChildrenCustomizationProperties.UIPadding) do
            tbl1[k] = uiPadding[k]
        end
        result.UIPadding = tbl1
    end

    return result
end
