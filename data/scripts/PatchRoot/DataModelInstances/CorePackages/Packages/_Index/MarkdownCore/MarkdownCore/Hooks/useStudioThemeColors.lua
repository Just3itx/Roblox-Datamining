-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HooksParent = script:FindFirstAncestor("Hooks").Parent

local React = require(HooksParent.Parent.React)
local Theme = require(HooksParent.Utils.Highlighter.Theme)
local _Types = require(HooksParent.Types)
local isCli = require(HooksParent.Utils.isCli)

local function useStudioThemeColors()
    local var1, var2 = React.useState(Theme.defaultColors)

    React.useEffect(function()
        local function getTokens()
            if isCli() then
                return Theme.defaultColors
            end

            local success, result = pcall(function()
                return settings().Studio.Theme
            end)

            if not success then
                return {}
            end

            return {
                background = result:GetColor(Enum.StudioStyleGuideColor.ScriptBackground),
                iden = result:GetColor(Enum.StudioStyleGuideColor.ScriptText),
                keyword = result:GetColor(Enum.StudioStyleGuideColor.ScriptKeyword),
                builtin = result:GetColor(Enum.StudioStyleGuideColor.ScriptBuiltInFunction),
                string = result:GetColor(Enum.StudioStyleGuideColor.ScriptString),
                number = result:GetColor(Enum.StudioStyleGuideColor.ScriptNumber),
                comment = result:GetColor(Enum.StudioStyleGuideColor.ScriptComment),
                operator = result:GetColor(Enum.StudioStyleGuideColor.ScriptOperator),
                custom = result:GetColor(Enum.StudioStyleGuideColor.ScriptBool)
            }
        end

        var2((getTokens()))

        local success, result = pcall(function()
            return settings().Studio.ThemeChanged:Connect(function()
                var2((getTokens()))
            end)
        end)

        return function()
            if success and result then
                result:Disconnect()
            end
        end
    end, {})

    return var1
end

return useStudioThemeColors
