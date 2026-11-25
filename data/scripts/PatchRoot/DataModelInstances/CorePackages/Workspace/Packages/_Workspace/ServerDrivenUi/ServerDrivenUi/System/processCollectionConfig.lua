-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiErrors = SduiCoreSystem.SduiErrors

local tbl1 = ({})

for value in game:DefineFastString("SduiEagerProcessCollectionIds", "400000000"):gmatch("(%w+)") do
    tbl1[value] = true
end

local function processCollectionConfig(arg1, str1: string, arg2)
    if not (str1 and tbl1[tostring(str1)]) then
        return arg1
    end
    local name = `{arg2.appPage}-{str1}`
    local success, result = pcall(function()
        local var1, var2 = SduiBuilder.tryCreateEagerProcessedComponentConfig(arg1, arg2, name, {}, true)
        if var1 then
            return var2
        end
        error(var2)
    end)

    if success and result then
        return result
    end

    local var1 = if typeof(result) ~= "string" then "" else result
    arg2.dependencies.logger.reportError(
        SduiErrors.SduiErrorType.FailedToEagerlyProcess,
        {
            name = name,
            message = `Failed to process collection config {var1}`
        },
        arg2.appPage
    )
    return arg1
end

return processCollectionConfig
