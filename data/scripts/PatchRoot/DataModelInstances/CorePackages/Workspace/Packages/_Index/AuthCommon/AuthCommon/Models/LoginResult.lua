-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local ArgCheck = require(AuthCommonParent.ArgCheck)
local t = require(AuthCommonParent.t)

local FFlagEnableLuaAccountSwitch = require(AuthCommonParent.SharedFlags).FFlagEnableLuaAccountSwitch

local module = {}
local tbl1 = {}
module[tbl1] = true

local var1 = t.interface({
    user = t.interface({ id = t.number, name = t.string }),
    twoStepVerificationData = t.optional(t.interface({ mediaType = t.string, ticket = t.string })),
    twoStepVerificationDataV2 = t.optional(t.interface({ mediaType = t.string, ticket = t.string })),
    accountBlob = t.optional(t.string)
})

function module.new(arg1)
    local tbl2 = {
        user = { id = "0", name = "" }
    }

    if arg1 and type(arg1) == "table" then
        if arg1.user then
            local id = arg1.user.id
            tbl2.user.id = tostring(id) or tbl2.user.id
            tbl2.user.name = arg1.user.name or tbl2.user.name
        end

        if arg1.twoStepVerificationData then
            tbl2.twoStepVerificationData = {}
            tbl2.twoStepVerificationData.mediaType = arg1.twoStepVerificationData.mediaType or ""
            tbl2.twoStepVerificationData.ticket = arg1.twoStepVerificationData.ticket or ""
        end
        if FFlagEnableLuaAccountSwitch and arg1.accountBlob then
            tbl2.accountBlob = arg1.accountBlob
        end
    end

    setmetatable(tbl2, module)
    return tbl2
end

function module.mock()
    local module2 = module.new()

    module2.user = { id = "1", name = "ROBLOX" }

    module2.twoStepVerificationData = {
        mediaType = "Email",
        ticket = "00000000-0000-0000-0000-000000000000"
    }

    return module2
end

function module:fromJsonData()
    local module2 = module.new()

    local var2, var3 = var1(self)

    if var2 then
        module2.user = {
            id = tostring(self.user.id),
            name = self.user.name
        }

        if self.twoStepVerificationData then
            module2.twoStepVerificationData = {
                mediaType = self.twoStepVerificationData.mediaType,
                ticket = self.twoStepVerificationData.ticket
            }
        end

        if FFlagEnableLuaAccountSwitch and self.accountBlob then
            module2.accountBlob = self.accountBlob
            return module2
        end
    else
        ArgCheck.assert(false, var3)
    end

    return module2
end

function module.is(arg1): boolean
    return type(arg1) == "table" and arg1[tbl1] == true
end

function module:hasTwoStepData()
    return module.is(self) and type(self.twoStepVerificationData) == "table"
end

module.__index = module

return module
