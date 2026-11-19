-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {
    Levels = {
        Error = "MockError",
        Warning = "MockWarning",
        Info = "MockInfo",
        Debug = "MockDebug",
        Trace = "MockTrace",
        fromString = function(): string
            return "MockInfo"
        end
    }
}
module.__index = module

function module.new()
    return (setmetatable({}, module))
end

function module.setParent() end

function module.setContext() end

function module.addSink() end

function module.error() end

function module.warning() end

function module.info() end

function module.debug() end

function module.trace() end

return module
