-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableHasVerifiedBadgeUserModelValidation", false)

local MockId = require(script.Parent.MockId)

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    arg1 = arg1 or {}

    local new = module.new
    local tbl1 = {
        id = arg1.id or MockId(),
        username = arg1.username or "UN_" .. tostring(math.random(100000, 99999999)),
        displayName = arg1.displayName or "DN_" .. tostring(math.random(100000, 99999999)),
        hasVerifiedBadge = arg1.hasVerifiedBadge or false,
        created = arg1.created or ""
    }
    return (new(tbl1))
end

function module.isValid(arg1): (boolean, string)
    if not arg1 then
        return false, "Expected user information to be given"
    elseif not arg1.id then
        return false, "Expected user's id to be given"
    elseif arg1.id ~= "0" and not arg1.username then
        return false, "Expected user's username to be given"
    elseif not arg1.displayName then
        return false, "Expected user's displayName to be given"
    elseif game:GetFastFlag("EnableHasVerifiedBadgeUserModelValidation") and arg1.hasVerifiedBadge == nil then
        return false, "Expected user's hasVerifiedBadge to be given"
    end

    return true, "Valid UserModel"
end

function module.isEqual(arg1, arg2): boolean
    if game:GetFastFlag("EnableHasVerifiedBadgeUserModelValidation") then
        return arg1.id == arg2.id
            and arg1.username == arg2.username
            and arg1.displayName == arg2.displayName
            and arg1.hasVerifiedBadge == arg2.hasVerifiedBadge
    end
    return arg1.id == arg2.id and arg1.username == arg2.username and arg1.displayName == arg2.displayName
end

return module
