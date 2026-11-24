-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Foundation = require(ExpChatParent.Foundation)
local UIBlox = require(ExpChatParent.UIBlox)

local Config = require(ExpChat.Config)
local FStringExpChatSummaryPrefixText = require(ExpChat.Flags.FStringExpChatSummaryPrefixText)
local FFlagExpChatPolishSummaryMessageUI = require(ExpChat.Flags.FFlagExpChatPolishSummaryMessageUI)

local function ceilToEven(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num2 = math.ceil(num1)
    if num2 % 2 == 1 then
        num2 += 1
    end
    return math.max(0, num2)
end

local function calculateSummaryTextSize(num1: number): number -- Luacid: Inlined by compiler; 8 call sites recovered
    return math.max(0, num1 - 2)
end

local function getSummaryTextSizeFromConfiguration() -- Luacid: Inlined by compiler; 2 call sites recovered
    local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
    if chatWindowConfiguration then
        return calculateSummaryTextSize(chatWindowConfiguration.TextSize)
    end
    return calculateSummaryTextSize(Config.ChatWindowTextSize)
end

return {
    getSummaryIconPrefix = function(num1: number?): string
        if not FFlagExpChatPolishSummaryMessageUI then
            return `<font weight='600' family='rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json'>{Foundation.Enums.IconName.Nebula}</font>{FStringExpChatSummaryPrefixText}`
        end

        local var1 = if num1 then calculateSummaryTextSize(num1) else getSummaryTextSizeFromConfiguration()
        return `<font weight='600' size="{ceilToEven(var1 * 3 / 4)}" family='rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json'>{Foundation.Enums.IconName.Nebula}</font>{FStringExpChatSummaryPrefixText}`
    end,
    wrapInSummaryMutedStyle = function(str1: string, str2: string?, num1: number?): string
        if not FFlagExpChatPolishSummaryMessageUI then
            return `<font color='#{str2 or "BCBEC8"}' size="{Config.ChatWindowTextSize - 2}">{str1}</font>`
        end

        local var1 = UIBlox.App.Style.Colors.LightGrey:ToHex()
        local var2 = if num1 then calculateSummaryTextSize(num1) else getSummaryTextSizeFromConfiguration()
        return `<font color='#{var1}' weight='600' size="{var2}">{str1}</font>`
    end
}
