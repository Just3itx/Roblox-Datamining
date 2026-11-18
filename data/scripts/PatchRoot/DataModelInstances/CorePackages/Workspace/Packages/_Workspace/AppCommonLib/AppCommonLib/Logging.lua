-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:06:01Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("LoggingRethrowUsingError", false)

local function GetFFlagLoggingRethrowUsingError(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetFastFlag("LoggingRethrowUsingError")
end

local bool1 = true
local tbl1 = ({})

local function createLogInfo()
    local tbl2 = {
        warnings = {}
    }

    setmetatable(tbl2, {
        __tostring = function(arg1): string
            return ("LogInfo\n\tWarnings (%d):\n\t\t%s"):format(#arg1.warnings, table.concat(arg1.warnings, "\n\t\t"))
        end
    })

    return tbl2
end

local module = {}

function module.capture(callback)
    local logInfo = createLogInfo()

    local bool2 = bool1
    bool1 = false
    tbl1[logInfo] = true

    local success, result = pcall(callback)

    tbl1[logInfo] = nil
    bool1 = bool2

    if GetFFlagLoggingRethrowUsingError() then
        if not success then
            error(result)
            return logInfo
        end
    else
        assert(success, result)
    end

    return logInfo
end

function module.warn(arg1)
    for k in pairs(tbl1) do
        table.insert(k.warnings, arg1)
    end

    if bool1 then
        warn(arg1)
    end
end

return module
