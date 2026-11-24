-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _acpSession = require(script.Parent.Types.acpSession)
local _model = require(script.Parent.Types.model)
local FFlagBuildExperienceAdvancedPreviewSpecs = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceAdvancedPreviewSpecs

return {
    capture = function(tier, arg1)
        assert(tier == "default" or tier == "advanced", "invalid model tier")
        local experiment = if arg1 == nil then nil else table.clone(arg1)

        if experiment ~= nil then
            if experiment.clientToolConfig ~= nil then
                local var2 = table.clone(experiment.clientToolConfig)
                var2.tools = table.freeze(table.clone(var2.tools))
                experiment.clientToolConfig = table.freeze(var2)
            end
            table.freeze(experiment)
        end
        return table.freeze({ tier = tier, experiment = experiment })
    end,
    sameExperiment = function(arg1, arg2)
        if arg1 == nil or arg2 == nil then
            return arg1 == arg2
        end
        if arg1.specVersion ~= arg2.specVersion or arg1.runId ~= arg2.runId then
            return false
        end
        if FFlagBuildExperienceAdvancedPreviewSpecs and arg1.specName ~= arg2.specName then
            return false
        end
        local clientToolConfig = arg1.clientToolConfig
        local clientToolConfig2 = arg2.clientToolConfig
        if clientToolConfig == nil or clientToolConfig2 == nil then
            return clientToolConfig == clientToolConfig2
        end
        if clientToolConfig.mode ~= clientToolConfig2.mode or #clientToolConfig.tools ~= #clientToolConfig2.tools then
            return false
        end
        for k, tool in clientToolConfig.tools do
            if tool ~= clientToolConfig2.tools[k] then
                return false
            end
        end
        return true
    end
}
