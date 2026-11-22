-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local PlayWithRewardStateParent = script:FindFirstAncestor("PlayWithRewardState").Parent
local mutedError = require(PlayWithRewardStateParent.Loggers).mutedError
local t = require(PlayWithRewardStateParent.t)

local FFlagLuaAppEnableContainedRewardUi = require(script.Parent.FFlagLuaAppEnableContainedRewardUi)

local var1 = t.interface({
    titleText = t.string,
    subtitleText = t.string,
    buttonText = t.string,
    coachmarkTitleText = t.string,
    coachmarkSubtitleText = t.string,
    showButton = t.boolean,
    variantId = t.string,
    keepRewardContained = if FFlagLuaAppEnableContainedRewardUi then t.optional(t.boolean) else nil
})

local module = {}

local tbl1 = {
    titleText = "",
    subtitleText = "",
    buttonText = "",
    coachmarkTitleText = "",
    coachmarkSubtitleText = "",
    showButton = false,
    variantId = "",
    keepRewardContained = not FFlagLuaAppEnableContainedRewardUi and nil
}

function module.fromJsonData(input: string)
    local var2 = table.clone(tbl1)

    local success, result = pcall(function()
        return HttpService:JSONDecode(input)
    end)

    if success then
        local var3, var4 = var1(result)
        if not var3 then
            mutedError(`PlayWithRewardExperimentData invalid: {tostring(var4)}`)
            return var2
        end

        var2.titleText = result.titleText
        var2.subtitleText = result.subtitleText
        var2.buttonText = result.buttonText
        var2.coachmarkTitleText = result.coachmarkTitleText
        var2.coachmarkSubtitleText = result.coachmarkSubtitleText
        var2.showButton = result.showButton
        var2.variantId = result.variantId
        if FFlagLuaAppEnableContainedRewardUi then
            var2.keepRewardContained = result.keepRewardContained or false
        end
    end

    return var2
end

return module
