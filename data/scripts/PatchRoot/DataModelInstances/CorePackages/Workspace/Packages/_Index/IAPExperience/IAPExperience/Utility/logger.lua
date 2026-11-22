-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Logger = require(scriptParentParentParent.Loggers).Logger
local HttpService = game:GetService("HttpService")

local function attachPackageName(tbl1) -- Luacid: Inlined by compiler; 4 call sites recovered
    tbl1 = tbl1 or {}

    tbl1.packageName = "IAPExperience"
    return tbl1
end

return {
    debug = function(tbl1)
        Logger:debug(HttpService:JSONEncode((attachPackageName(tbl1))))
    end,
    info = function(tbl1)
        Logger:info(HttpService:JSONEncode((attachPackageName(tbl1))))
    end,
    warn = function(tbl1)
        Logger:warn(HttpService:JSONEncode((attachPackageName(tbl1))))
    end,
    error = function(tbl1)
        Logger:error(HttpService:JSONEncode((attachPackageName(tbl1))))
    end
}
