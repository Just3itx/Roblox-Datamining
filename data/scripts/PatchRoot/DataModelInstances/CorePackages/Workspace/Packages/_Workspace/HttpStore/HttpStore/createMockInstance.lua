-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local createMockHttpStore = require(scriptParentParent.InternalHttpStore).createMockHttpStore

local function createMockInstance()
    local mockHttpStore = createMockHttpStore()

    return {
        get = function()
            return mockHttpStore
        end,
        _create = function()
            return mockHttpStore
        end,
        _dispose = function()
            mockHttpStore.reset()
        end,
        setResponse = mockHttpStore.setResponse,
        reset = mockHttpStore.reset,
        mockStore = mockHttpStore
    }
end

return createMockInstance
