-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return {
        getStatus = require(script.getStatus)(arg1),
        setStatus = require(script.setStatus)(arg1),
        installReducer = require(script.installReducer)(arg1),
        Enum = {
            Status = require(script.EnumNetworkStatus)
        }
    }
end
