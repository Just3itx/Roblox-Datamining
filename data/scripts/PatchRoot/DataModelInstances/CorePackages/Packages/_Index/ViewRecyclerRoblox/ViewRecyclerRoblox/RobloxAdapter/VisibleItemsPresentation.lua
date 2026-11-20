-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact08
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local _ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local module = {}

function module.new(func1: (...any) -> (...any))
    local bool1 = true
    local bool2 = false
    local var1 = nil
    local var2 = (setmetatable({}, { __mode = "k" }))

    local function check()
        local var3 = var1
        if not bool1 or bool2 or var3 == nil then
            return
        end
        local visibleRange = var3.visibleRange
        if visibleRange.lastIndex < visibleRange.firstIndex then
            return
        end
        local num1 = 0
        for _, mountedView in var3.mountedViews do
            local index = mountedView.state.index
            if index == nil or not (visibleRange.firstIndex <= index and index <= visibleRange.lastIndex) then
                continue
            end

            if var2[mountedView.itemView] ~= mountedView.state.assignment then
                return
            end
            num1 += 1
        end

        if num1 <= visibleRange.lastIndex - visibleRange.firstIndex then
            return
        end
        bool1 = false
        local var4 = func1()
        if var4 ~= nil then
            var4(table.freeze({ visibleRange = visibleRange }))
        end
    end

    return {
        rearm = function()
            bool1 = true
        end,
        present = function(arg1, arg2, callback)
            bool2 = true
            local success, result

            if FFlagViewRecyclerReact084 then
                success, result = pcall(callback)
            else
                success = nil
                result = nil
                if FFlagViewRecyclerReact08 then
                    success, result = pcall(callback)
                else
                    callback()
                end
            end
            bool2 = false
            var1 = arg1
            if (if FFlagViewRecyclerReact084 then not success else FFlagViewRecyclerReact08) and (FFlagViewRecyclerReact084 or not success) then
                error(result, 0)
            end

            if arg2 == 0 then
                bool1 = true
                return
            end
            check()
        end,
        presentationChanged = function(arg1, arg2)
            var2[arg1] = arg2
            check()
        end
    }
end

return module
