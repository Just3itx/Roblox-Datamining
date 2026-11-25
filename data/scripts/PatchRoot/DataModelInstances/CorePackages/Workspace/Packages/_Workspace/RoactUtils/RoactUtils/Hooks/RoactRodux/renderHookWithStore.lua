-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent
local RoactRodux = require(RoactUtilsParent.RoactRodux)
local React = require(RoactUtilsParent.React)
local ReactRoblox = require(RoactUtilsParent.ReactRoblox)
local act = ReactRoblox.act

local function renderHookWithStore(store, func1: (...any) -> (...any), arg1)
    local tbl1 = {}

    local function func2(arg2)
        tbl1.current = func1(arg2)
        return nil
    end

    local function createRootElement(arg2)
        local element = React.createElement(func2, arg2)
        if store ~= nil then
            element = React.createElement(RoactRodux.StoreProvider, { store = store }, { Wrapper = element })
        end

        return element
    end

    local frame = Instance.new("Frame")
    local root = ReactRoblox.createRoot(frame)

    act(function()
        root:render((createRootElement(arg1 or {})))
    end)

    return {
        result = tbl1,
        rerender = function(arg2)
            act(function()
                root:render((createRootElement(arg2)))
            end)
        end,
        cleanup = function()
            root:unmount()
        end
    }
end
return renderHookWithStore
