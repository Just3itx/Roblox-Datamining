-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local dependencies = require(PYMKCarousel.dependencies)

local RoduxUsers = dependencies.RoduxUsers
local convertActions = dependencies.convertActions
local llama = dependencies.llama
local usersActionAdaptor = dependencies.usersActionAdaptor
local usersOmniActionAdaptor = require(script.Parent.usersOmniActionAdaptor)

local tbl1 = {
    byUserId = {},
    byUsername = {}
}

local var1 = RoduxUsers.installReducer()

local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return llama.Dictionary.join(usersActionAdaptor(RoduxUsers), usersOmniActionAdaptor(arg1))
end

return function(arg1)
    return convertActions(var1, func1(arg1), tbl1)
end
